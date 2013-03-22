// -*- C++ -*-
/* Copyright (C) 1990, 1991 Free Software Foundation, Inc.
     Written by James Clark (jjc@jclark.uucp)

This file is part of groff.

groff is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free
Software Foundation; either version 1, or (at your option) any later
version.

groff is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
for more details.

You should have received a copy of the GNU General Public License along
with groff; see the file LICENSE.  If not, write to the Free Software
Foundation, 675 Mass Ave, Cambridge, MA 02139, USA. */

// A C++ implementation of groff.sh.

#include <stdio.h>
#include <string.h>
#include <osfcn.h>
#include <stdlib.h>
#include <signal.h>
#include <errno.h>
#include <sys/types.h>
#ifndef NO_SYS_WAIT_H
#include <sys/wait.h>
#endif /* not NO_SYS_WAIT_H */

#include "lib.h"
#include "assert.h"
#include "errarg.h"
#include "error.h"
#include "stringclass.h"
#include "font.h"

#include "device.h"

#ifdef HAVE_PID_T
typedef pid_t PID_T;
#else
typedef int PID_T;
#endif

#ifdef HAVE_UNION_WAIT
typedef union wait WAIT_STATUS_T;
#else
typedef int WAIT_STATUS_T;
#endif

#ifdef NO_SYS_WAIT_H
extern "C" {
  PID_T wait(WAIT_STATUS_T *);
}
#endif /* NO_SYS_WAIT_H */


#ifdef HAVE_UNION_WAIT
/* Convert the argument which must be an lvalue of type union wait *
to an int. */
#define WTOI(s) (*(int *)&(s))
#else
#define WTOI(s) (s)
#endif

#ifndef WIFEXITED
#define WIFEXITED(s) ((WTOI(s) & 0377) == 0)
#define WIFSTOPPED(s) ((WTOI(s) & 0377) == 0177)
#define WIFSIGNALED(s) ((WTOI(s) & 0377) != 0 && ((WTOI(s) & 0377) != 0177))
#endif /* WIFEXITED */

#ifndef WEXITSTATUS
#define WEXITSTATUS(s) ((WTOI(s) >> 8) & 0377)
#define WTERMSIG(s) (WTOI(s) & 0177)
#define WSTOPSIG(s) ((WTOI(s) >> 8) & 0377)
#endif /* not WEXITSTATUS */

#ifdef WAIT_COREDUMP_0200
#define WCOREDUMPED(s) (WTOI(s) & 0200)
#else
#define WCOREDUMPED(s) 0
#endif

const char *strsignal(int);

const char *ps_print[] = { (PSPRINT) 0 };

const char *dvi_print[] = { (DVIPRINT) 0 };

const char *grops[] = { "grops", 0 };
const char *grotty[] = { "grotty", 0 };
const char *grodvi[] = { "grodvi", 0 };
const char *gxditview[] = { "gxditview", "-", 0 };

struct {
  const char *pseudo_name;
  const char *real_name;
  const char *description;  // Description of device (used in help message).
  const char **driver;	    // Driver argument vector.
  unsigned flags;	    // Bitwise OR of 
#define EQN_D_OPTION 01	    /* Add -D option to eqn. */
#define PIC_X_OPTION 02	    /* Add -x option to pic. */
#define PIC_P_OPTION 04	    /* Add -p option to pic. */
#define GROFF_OPTIONS 010   /* Driver understands -F and -v options. */
#define XT_OPTION 020	    /* Driver understands -title and -xrm options. */
#define PRINT_OPTION 040    /* Understands -printCommand. */
  const char *macro_file;   // -m option to pass to troff
  const char **spooler;	    // Spooler argument vector.
} device_table[] = {
  {
    "ps",
    "ps",
    "PostScript",
    grops,
    EQN_D_OPTION|PIC_X_OPTION|PIC_P_OPTION|GROFF_OPTIONS,
    "ps",
    ps_print,
    },
  {
    "ascii",
    "ascii",
    "ASCII",
    grotty,
    GROFF_OPTIONS,
    "tty",
    0
    },
  {
    "latin1",
    "latin1",
    "ISO Latin-1",
    grotty,
    GROFF_OPTIONS,
    "tty",
    0
    },
  {
    "dvi",
    "dvi",
    "TeX dvi format",
    grodvi,
    GROFF_OPTIONS|PIC_X_OPTION,
    "dvi",
    dvi_print,
    },
  {
    "X100",
    "X100",
    "X11 previewer at 100dpi",
    gxditview,
    EQN_D_OPTION|PIC_X_OPTION|XT_OPTION,
    "X",
    0
    },
  {
    "X75",
    "X75",
    "X11 previewer at 75dpi",
    gxditview,
    EQN_D_OPTION|PIC_X_OPTION|XT_OPTION,
    "X",
    0
    },
  {
    "X100-12",
    "X100-12",
    "X11 previewer at 100dpi (optimized for 12 point text)",
    gxditview,
    EQN_D_OPTION|PIC_X_OPTION|XT_OPTION,
    "X",
    0
    },
  {
    "X75-12",
    "X75-12",
    "X11 previewer at 75dpi (optimized for 12 point text)",
    gxditview,
    EQN_D_OPTION|PIC_X_OPTION|XT_OPTION,
    "X",
    0
    },
  {
    "Xps",
    "ps",
    "X11 previewer with PostScript metrics",
    gxditview,
    EQN_D_OPTION|PIC_X_OPTION|PIC_P_OPTION|XT_OPTION|PRINT_OPTION,
    "Xps",
    0
    },
};

const int SOELIM_INDEX = 0;
const int REFER_INDEX = SOELIM_INDEX + 1;
const int PIC_INDEX = REFER_INDEX + 1;
const int TBL_INDEX = PIC_INDEX + 1;
const int EQN_INDEX = TBL_INDEX + 1;
const int TROFF_INDEX = EQN_INDEX + 1;
const int POST_INDEX = TROFF_INDEX + 1;
const int SPOOL_INDEX = POST_INDEX + 1;

const int NCOMMANDS = SPOOL_INDEX + 1;

// Children exit with this status if the execvp failed.
const int EXEC_FAILED_EXIT_STATUS = 0xff;

class possible_command {
  char *name;
  string args;
  char **argv;
public:
  PID_T pid;

  possible_command();
  ~possible_command();
  void set_name(const char *);
  const char *get_name();
  void append_arg(const char *, const char * = 0);
  void prepend_arg(const char *, const char * = 0);
  void execp();
  void clear_args();
  void build_argv();
  void print(int is_last, FILE *fp);
};

int lflag = 0;

possible_command commands[NCOMMANDS];

int run_commands();
void print_commands();
void append_arg_to_string(const char *arg, string &str);

void usage();
void help();
void devices();
void sys_fatal(const char *);

int main(int argc, char **argv)
{
  program_name = argv[0];
  static char stderr_buf[BUFSIZ];
  setbuf(stderr, stderr_buf);
  string Pargs, Largs;
  int Vflag = 0;
  int zflag = 0;
  int iflag = 0;
  int opt;
  const char *device = getenv("GROFF_TYPESETTER");
  if (!device)
    device = DEVICE;
  commands[TROFF_INDEX].set_name("gtroff");
  while ((opt = getopt(argc, argv,
		       "itpeRszavVhblCENZH:F:m:T:f:w:W:M:d:r:n:o:P:L:"))
	 != EOF) {
    char buf[3];
    buf[0] = '-';
    buf[1] = opt;
    buf[2] = '\0';
    switch (opt) {
    case 'i':
      iflag = 1;
      break;
    case 't':
      commands[TBL_INDEX].set_name("gtbl");
      break;
    case 'p':
      commands[PIC_INDEX].set_name("gpic");
      break;
    case 'e':
      commands[EQN_INDEX].set_name("geqn");
      break;
    case 's':
      commands[SOELIM_INDEX].set_name("gsoelim");
      break;
    case 'R':
      commands[REFER_INDEX].set_name("grefer");
      break;
    case 'z':
    case 'a':
      commands[TROFF_INDEX].append_arg(buf);
      // fall through
    case 'Z':
      zflag++;
      break;
    case 'l':
      lflag++;
      break;
    case 'V':
      Vflag++;
      break;
    case 'v':
      commands[POST_INDEX].append_arg(buf);
      // fall through
    case 'C':
      commands[SOELIM_INDEX].append_arg(buf);
      commands[PIC_INDEX].append_arg(buf);
      commands[TBL_INDEX].append_arg(buf);
      commands[EQN_INDEX].append_arg(buf);
      commands[TROFF_INDEX].append_arg(buf);
      break;
    case 'N':
      commands[EQN_INDEX].append_arg(buf);
      break;
    case 'h':
      help();
      break;
    case 'E':
    case 'b':
      commands[TROFF_INDEX].append_arg(buf);
      break;
    case 'T':
      device = optarg;
      break;
    case 'F':
      font::command_line_font_dir(optarg);
      commands[POST_INDEX].append_arg(buf, optarg);
      // fall through
    case 'f':
    case 'o':
    case 'm':
    case 'r':
    case 'M':
    case 'H':
    case 'd':
    case 'n':
    case 'w':
    case 'W':
      commands[TROFF_INDEX].append_arg(buf, optarg);
      break;
    case 'P':
      Pargs += optarg;
      Pargs += '\0';
      break;
    case 'L':
      Largs += optarg;
      Largs += '\0';
      break;
    case '?':
      usage();
      break;
    default:
      assert(0);
      break;
    }
  }
  int found = 0;
  for (int device_index = 0;
       device_index < sizeof(device_table)/sizeof(device_table[0]);
       device_index++)
    if (strcmp(device, device_table[device_index].pseudo_name) == 0) {
      found = 1;
      break;
    }
  if (!found) {
    error("unknown device `%1'", device);
    devices();
    exit(1);
  }
  device = device_table[device_index].real_name;
  if (device_table[device_index].macro_file != 0)
    commands[TROFF_INDEX].prepend_arg("-m",
				      device_table[device_index].macro_file);
  commands[POST_INDEX].set_name(device_table[device_index].driver[0]);
  if (!(device_table[device_index].flags & GROFF_OPTIONS))
    commands[POST_INDEX].clear_args();
  if ((device_table[device_index].flags & XT_OPTION)
      && argc - optind == 1) {
    commands[POST_INDEX].append_arg("-title");
    commands[POST_INDEX].append_arg(argv[optind]);
    commands[POST_INDEX].append_arg("-xrm");
    commands[POST_INDEX].append_arg("*iconName:", argv[optind]);
  }
  if (device_table[device_index].flags & PRINT_OPTION) {
    found = 0;
    for (int di = 0; di < sizeof(device_table)/sizeof(device_table[0]); di++) {
      if (strcmp(device, device_table[di].pseudo_name) == 0) {
	found = 1;
	break;
      }
    }
    assert(found);
    string print_string(device_table[di].driver[0]);
    int i;
    for (i = 1; device_table[di].driver[i]; i++)
      append_arg_to_string(device_table[di].driver[i], print_string);
    if (device_table[di].spooler) {
      print_string += " |";
      for (i = 0; device_table[di].spooler[i]; i++)
	append_arg_to_string(device_table[di].spooler[i], print_string);
    }
    print_string += '\0';
    commands[POST_INDEX].append_arg("-printCommand");
    commands[POST_INDEX].append_arg(print_string.contents());
  }
  const char *p = Pargs.contents();
  const char *end = p + Pargs.length();
  while (p < end) {
    commands[POST_INDEX].append_arg(p);
    p = strchr(p, '\0') + 1;
  }
  int i;
  for (i = 1; device_table[device_index].driver[i]; i++)
    commands[POST_INDEX].append_arg(device_table[device_index].driver[i]);
  if (device_table[device_index].flags & PIC_X_OPTION)
    commands[PIC_INDEX].append_arg("-x");
  if (device_table[device_index].flags & PIC_P_OPTION)
    commands[PIC_INDEX].append_arg("-p");
  if (device_table[device_index].flags & EQN_D_OPTION)
    commands[EQN_INDEX].append_arg("-D");
  if (lflag && device_table[device_index].spooler) {
    commands[SPOOL_INDEX].set_name(device_table[device_index].spooler[0]);
    p = Largs.contents();
    end = p + Largs.length();
    while (p < end) {
      commands[SPOOL_INDEX].append_arg(p);
      p = strchr(p, '\0') + 1;
    }
    for (i = 1; device_table[device_index].spooler[i]; i++)
      commands[SPOOL_INDEX].append_arg(device_table[device_index].spooler[i]);
  }
  if (zflag) {
    commands[POST_INDEX].set_name(0);
    commands[SPOOL_INDEX].set_name(0);
  }
  commands[TROFF_INDEX].append_arg("-T", device);
  int have_eqnchar = 0;
  if (commands[EQN_INDEX].get_name() != 0) {
    commands[EQN_INDEX].append_arg("-T", device);
    font::set_device_name(device);
    char *path = 0;
    FILE *fp = font::open_file("eqnchar", &path);
    if (fp) {
      fclose(fp);
      if (path[0] == '-' && path[1] != '\0')
	commands[EQN_INDEX].append_arg("--");
      commands[EQN_INDEX].append_arg(path);
      delete path;
      have_eqnchar = 1;
    }
  }
  for (int first_index = 0; first_index < TROFF_INDEX; first_index++)
    if (commands[first_index].get_name() != 0)
      break;
  if (optind < argc) {
    if (argv[optind][0] == '-' && argv[optind][1] != '\0'
	&& (!have_eqnchar || first_index != EQN_INDEX))
      commands[first_index].append_arg("--");
    for (i = optind; i < argc; i++)
      commands[first_index].append_arg(argv[i]);
    if (iflag)
      commands[first_index].append_arg("-");
  }
  if (have_eqnchar && (first_index != EQN_INDEX || optind >= argc))
    commands[EQN_INDEX].append_arg("-");
  if (Vflag) {
    print_commands();
    exit(0);
  }
  exit(run_commands());
}

void print_commands()
{
  for (int last = SPOOL_INDEX; last >= 0; last--)
    if (commands[last].get_name() != 0)
      break;
  for (int i = 0; i <= last; i++)
    if (commands[i].get_name() != 0)
      commands[i].print(i == last, stdout);
}

// Run the commands. Return the code with which to exit.

int run_commands()
{
  for (int last = SPOOL_INDEX; last >= 0; last--)
    if (commands[last].get_name() != 0)
      break;
  int last_input = 0;
  int proc_count = 0;
  for (int i = 0; i <= last; i++)
    if (commands[i].get_name() != 0) {
      proc_count++;
      int pdes[2];
      if (i != last) {
	if (pipe(pdes) < 0)
	  sys_fatal("pipe");
      }
#ifdef HAVE_VFORK
      PID_T pid = vfork();
      if (pid < 0)
	sys_fatal("vfork");
#else /* !HAVE_VFORK */
      PID_T pid = fork();
      if (pid < 0)
	sys_fatal("fork");
#endif /* !HAVE_VFORK */
      if (pid == 0) {
	// child
	if (last_input != 0) {
	  if (close(0) < 0)
	    sys_fatal("close");
	  if (dup(last_input) < 0)
	    sys_fatal("dup");
	  if (close(last_input) < 0)
	    sys_fatal("close");
	}
	if (i != last) {
	  if (close(1) < 0)
	    sys_fatal("close");
	  if (dup(pdes[1]) < 0)
	    sys_fatal("dup");
	  if (close(pdes[1]) < 0)
	    sys_fatal("close");
	  if (close(pdes[0]))
	    sys_fatal("close");
	}
	commands[i].execp();
      }
      // in the parent
      if (last_input != 0) {
	if (close(last_input) < 0)
	  sys_fatal("close");
      }
      if (i != last) {
	if (close(pdes[1]) < 0)
	  sys_fatal("close");
	last_input = pdes[0];
      }
      commands[i].pid = pid;
    }
  int ret = 0;
  while (proc_count > 0) {
    WAIT_STATUS_T status;
    PID_T pid = wait(&status);
    if (pid < 0)
      sys_fatal("wait");
    for (i = 0; i < NCOMMANDS; i++)
      if (commands[i].pid == pid) {
	--proc_count;
	if (WIFSIGNALED(status)) {
	  int sig = WTERMSIG(status);
	  if (sig != SIGPIPE) {
	    error("%1: %2%3",
		  commands[i].get_name(),
		  strsignal(sig),
		  WCOREDUMPED(status) ? " (core dumped)" : "");
	    ret |= 2;
	  }
	}
	else if (WIFEXITED(status)) {
	  int exit_status = WEXITSTATUS(status);
	  if (exit_status == EXEC_FAILED_EXIT_STATUS)
	    ret |= 4;
	  else if (exit_status != 0)
	    ret |= 1;
	}
	else
	  error("unexpected status %1", WTOI(status));
	break;
      }
  }
  return ret;
}

possible_command::possible_command()
: pid(-1), name(0), argv(0)
{
}

possible_command::~possible_command()
{
  delete name;
  delete argv;
}

void possible_command::set_name(const char *s)
{
  name = strsave(s);
}

const char *possible_command::get_name()
{
  return name;
}

void possible_command::clear_args()
{
  args.clear();
}

void possible_command::append_arg(const char *s, const char *t)
{
  args += s;
  if (t)
    args += t;
  args += '\0';
}

void possible_command::prepend_arg(const char *s, const char *t)
{
  string old(args);
  args = s;
  if (t)
    args += t;
  args += '\0';
  args += old;
}

void possible_command::build_argv()
{
  // Count the number of arguments.
  int len = args.length();
  int argc = 1;
  char *p = 0;
  if (len > 0) {
    p = &args[0];
    for (int i = 0; i < len; i++)
      if (p[i] == '\0')
	argc++;
  }
  // Build an argument vector.
  argv = new char *[argc + 1];
  argv[0] = name;
  for (int i = 1; i < argc; i++) {
    argv[i] = p;
    p = strchr(p, '\0') + 1;
  }
  argv[argc] = 0;
}

void possible_command::print(int is_last, FILE *fp)
{
  build_argv();
  fputs(argv[0], fp);
  string str;
  for (int i = 1; argv[i] != 0; i++) {
    str.clear();
    append_arg_to_string(argv[i], str);
    put_string(str, fp);
  }
  if (is_last)
    putc('\n', fp);
  else
    fputs(" | ", fp);
}

void append_arg_to_string(const char *arg, string &str)
{
  str += ' ';
  int needs_quoting = 0;
  int contains_single_quote = 0;
  for (const char *p = arg; *p != '\0'; p++)
    switch (*p) {
    case ';':
    case '&':
    case '(':
    case ')':
    case '|':
    case '^':
    case '<':
    case '>':
    case '\n':
    case ' ':
    case '\t':
    case '\\':
    case '"':
    case '$':
      needs_quoting = 1;
      break;
    case '\'':
      contains_single_quote = 1;
      break;
    }
  if (contains_single_quote || arg[0] == '\0') {
    str += '"';
    for (p = arg; *p != '\0'; p++)
      switch (*p) {
      case '"':
      case '\\':
      case '$':
	str += '\\';
	// fall through
      default:
	str += *p;
	break;
      }
    str += '"';
  }
  else if (needs_quoting) {
    str += '\'';
    str += arg;
    str += '\'';
  }
  else
    str += arg;
}


void possible_command::execp()
{
  build_argv();
  execvp(name, argv);
  error("couldn't exec %1: %2", name, strerror(errno));
  fflush(stderr);		// just in case
  _exit(EXEC_FAILED_EXIT_STATUS);
}

void synopsis()
{
  fprintf(stderr,
"usage: %s [-abehilpstvzCENRVZ] [-Hfile] [-Fdir] [-mname] [-Tdev] [-ffam]\n"
"       [-wname] [-Wname] [ -Mdir] [-dcs] [-rcn] [-nnum] [-olist] [-Parg]\n"
"       [-Larg] [files...]\n",
	  program_name);
}

void devices()
{
  fputs("Available devices are:\n", stderr);
  for (int i = 0; i < sizeof(device_table)/sizeof(device_table[0]); i++)
    fprintf(stderr, "%s\t%s\n",
	    device_table[i].pseudo_name,
	    device_table[i].description);
}

void help()
{
  synopsis();
  fputs("\n"
"-h\tprint this message\n"
"-t\tpreprocess with tbl\n"
"-p\tpreprocess with pic\n"
"-e\tpreprocess with eqn\n"
"-s\tpreprocess with soelim\n"
"-R\tpreprocess with refer\n"
"-Tdev\tuse device dev\n"
"-mname\tread macros tmac.name\n"
"-dcs\tdefine a string c as s\n"
"-rcn\tdefine a number register c as n\n"
"-nnum\tnumber first page n\n"
"-olist\toutput only pages in list\n"
"-ffam\tuse fam as the default font family\n"
"-Fdir\tsearch directory dir for device directories\n"
"-Mdir\tsearch dir for macro files\n"
"-Hfile\tread hyphenation patterns from file\n"
"-v\tprint version number\n"
"-z\tsuppress formatted output\n"
"-Z\tdon't postprocess\n"
"-a\tproduce ASCII description of output\n"
"-i\tread standard input after named input files\n"
"-wname\tenable warning name\n"
"-Wname\tinhibit warning name\n"
"-E\tinhibit all errors\n"
"-b\tprint backtraces with errors or warnings\n"
"-l\tspool the output\n"
"-C\tenable compatibility mode\n"
"-V\tprint commands on stdout instead of running them\n"
"-Parg\tpass arg to the postprocessor\n"
"-Larg\tpass arg to the spooler\n"
"-N\tdon't allow newlines within eqn delimiters\n"
"\n",
	stderr);
  devices();
  exit(0);
}

void usage()
{
  synopsis();
  fprintf(stderr, "%s -h gives more help\n", program_name);
  exit(1);
}

void sys_fatal(const char *s)
{
  fatal("%1: %2", s, strerror(errno));
}

#ifdef HAVE_SYS_SIGLIST
extern "C" {
  extern char *sys_siglist[];
}
#endif /* HAVE_SYS_SIGLIST */
  
const char *strsignal(int n)
{
  static char buf[sizeof("Signal ") + 1 + INT_DIGITS];
#ifdef HAVE_SYS_SIGLIST
  if (n >= 0 && n < NSIG && sys_siglist[n] != 0)
    return sys_siglist[n];
#endif /* HAVE_SYS_SIGLIST */
  sprintf(buf, "Signal %d", n);
  return buf;
}

