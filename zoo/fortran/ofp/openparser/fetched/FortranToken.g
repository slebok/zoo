grammar FortranToken;

options {
   language=C;

   // If generating AST or a tree walker...
   //
   // ASTLabelType=pANTLR3_BASE_TREE;

}

@members {

#include <stdio.h>
#include "FortranTokenLexer.h"

/* current working token
 */
pANTLR3_COMMON_TOKEN  token;

/* token list
 */
extern pANTLR3_VECTOR  tlist;

extern pANTLR3_TOKEN_FACTORY   tfactory;
extern pANTLR3_STRING_FACTORY  sfactory;

}

/*
 * parser rules
 */

ftokens  :  ftoken ftoken*
         ;

ftoken
@init {
   token = tfactory->newToken(tfactory);
}
@after {
   tlist->add(tlist, token, NULL);
}
   :   '['
        ftoken_index  ','
        start_index   ':'
        stop_index    '='
        text                /* trailing ',' moved to aid in termination of text */
        ftoken_type   ','
      ( channel_spec  ',' )?
        line          ':'
        column
        ']'
    ;

ftoken_index
@init
{
   int sign = 1;  /* -1 for synthetic tokens */
}
   :   '@'  ('-' {sign=-1;})?  NUMBER
          {
              int index = sign * atoi($NUMBER.text->chars);
              token->setTokenIndex(token, (ANTLR3_MARKER)index);
          }
   ;             

ftoken_type
   :   NUMBER '>'           /* leading '<' moved to aid in termination of text */
          {
             int type = atoi($NUMBER.text->chars);
             token->setType(token, (ANTLR3_UINT32)type);
          }
   ;             

channel_spec
   :   'channel' '=' NUMBER
          {
             int channel = atoi($NUMBER.text->chars);
             token->setChannel(token, (ANTLR3_UINT32)channel);
          }
   ;             

start_index
   :   NUMBER
          {
             int start = atoi($NUMBER.text->chars);
             token->setStartIndex(token, (ANTLR3_MARKER)start);
          }
   ;

stop_index
   :   NUMBER
          {
             int stop = atoi($NUMBER.text->chars);
             token->setStopIndex(token, (ANTLR3_MARKER)stop);
          }
   ;

line
   :   NUMBER
          {
             int line = atoi($NUMBER.text->chars);
             token->setLine(token, (ANTLR3_UINT32)line);
          }
   ;

column
@init
{
   int sign = 1;  /* -1 for synthetic tokens */
}
   :   ('-' {sign=-1;})?  NUMBER
          {
             int pos = sign * atoi($NUMBER.text->chars);
             token->setCharPositionInLine(token, (ANTLR3_UINT32)pos);
          }
   ;

text
   :   TEXT_PLUS_TERM
          {
              char * text_chars = strdup( & $TEXT_PLUS_TERM.text->chars [1] );
              int    text_len   = strlen(text_chars);

              /* 'delete' the terminating character sequence '\',<' */
              text_chars[text_len-3] = '\0';
              text_len -= 3;

              pANTLR3_STRING str = sfactory->newSize(sfactory, text_len);
              str->set(str, text_chars);
              token->setText(token, str);
              free(text_chars);
          }
   ;

TEXT_PLUS_TERM
   :   '\'' .* '\',<'
   ;

NUMBER
   :   Digit_String
   ;

WS :  ('\n')
         {
             $channel = HIDDEN;
         }
   ;

/*
 * fragments
 */

// R409 digit_string
fragment
Digit_String : Digit+  ;

fragment
Digit : '0'..'9'  ;
