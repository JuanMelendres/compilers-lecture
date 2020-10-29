%{
#include <stdio.h>
#include "y.tab.h" 
%}
%option yylineno

%%
\/\/.*[\n]                      { /* DO NOTHING BECAUSE OF COMMENT */ }
[ \s]                           { /* DO NOTHING BECAUSE OF WHITESPACE */ }
f                               return(floatdcl);
i                               return(intdcl);
p                               return(print);
[a-eghj-oq-z]                   return(id);
([0-9]+"."[0-9]+)               return(fnum);
([0-9]+)                        return(inum);
=                               return(assgn);
\+                              return(plus);
\-                              return(minus);
\*                              return(mult);
\/                              return(division);
\n                              return(end);
%%

int yywrap (void)
{return 1;} 