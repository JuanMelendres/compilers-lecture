%{
#include <stdio.h>
%}

%token NUMBER CLOSE OPEN
%left '*'
%left '+'

/***************************
Grammar:
E -> T | T  + E
T -> int | int * T| ( E ) 

Sorry I forgot to add the lex, I will send you both part lex and yacc
***************************/

%%
E:  T
    {
      $$ = $1;
    }
    |
    T '+' E
    {
      $$ = $1 + $3;
    }
    ;
T: OPEN E CLOSE
    {
      $$ = ($2);
    }
    |
    NUMBER '*' E          
    {
      $$ = $1 * $3;
    }
    |
    NUMBER
    ;
%%

main(){
  if(yyparse()==0){
    printf("Parse sucessful\n");
  }else{
    return 1;
  }
  
}

yyerror(s)
char *s;
{
  fprintf(stderr, "%s\n",s);
}

yywrap(){
  return(1);
}