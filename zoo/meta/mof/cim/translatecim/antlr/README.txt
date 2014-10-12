http://www.antlr3.org/grammar/list.html
	http://sourceforge.net/projects/translatecim/
		http://heanet.dl.sourceforge.net/project/translatecim/translatecim/0.9.1/translatecim-0.9.1.tar.gz
			src/main/antlr3/com/kyben/translatecim/TranslateCIM.g

TranslateCIM
Pete Siemsen, Thu Jun 25, 2009 09:36

TranslateCIM is an ANTLR 3 translator that translates CIM (the DMTF's Common Information Model) specification files into Java source code.  Input is the ~1200 MOF files distributed by the DMTF, output is ~1200 Java files.  TranslateCIM's back-end uses StringTemplate, so other output than Java might be possible someday.

VVZ: The repository does not contain any actual commits, so tracking the evolution of the grammar is impossible.

=====================================================================
Title: CIM MOF to Java
Filename: TranslateCIM.g
Version: 0.9
Date: 2008-10-01
Author: Pete Siemsen
Contact: siemsen@ucar.edu, 303-497-1810

Thanks to Pedro Assis, passis@dee.isep.ipp.pt, for his ANTLR 2
grammar named cim22grammar.g, which served as a starting point for
this grammar.

    This ANTLR 3 grammar generates a translator that translates CIM
    MOF files into Java source files.  The CIM (Common Information
    Model) is a set of standard object definitions defined by the DMTF
    (Distributed Management Task Force).  CIM objects are defined
    using MOF (Managed Object Format) syntax, which is defined in the
    CIM Infrastructure Specification, which is available on the DMTF
    website at http://www.dmtf.org/home.

    ANTLR is a parser generator that provides several ways to get
    the job done.  For this job, this grammar produces a single-phase
    (a.k.a single-pass) parser.  In ANTLR-speak, it's a lexer and
    parser, it doesn't use ASTs, it uses StringTemplates to generate
    output, and it's a generator, not a rewriter.

TODO:
 1. Use "init" or "after" actions (see page 86 of the ANTLR book) to
    increment a counter each time a rule fires.  Then see if any of
    the rules never fire, and delete those rules from this grammar.
 2. How do I implement the idea that a className has to start with
    'CIM_' and the rest of the name can't have an underscore?

=====================================================================
History:
   2000.11 version 0.1 (Pedro Assis)
         - Lexer and basic parser development.
   2007.07 version 0.3 (Pete Siemsen)
         1. My goal is to produce a translator that converts CIM MOF
            files to the corresponding Java files.  I don't care if
            this grammar is precisely implements the DMTF's definition
            of MOF syntax as defined in Appendix A of the CIM
            Infrastructure Specification.  In other words, I consider
            this grammar to be correct if it translates all the CIM
            MOF files.  MOF language constructs that appear in the
            specification of the MOF language but don't actually
            appear in any of the CIM MOF files aren't important.
            Like, this grammar doesn't know about MOF "instances".
    2008.02
          It produces compileable Java!  Now to make it produce good
          Java.

Grammar in a broad sense fetched on 12 October 2014 by Vadim Zaytsev, http://grammarware.net
