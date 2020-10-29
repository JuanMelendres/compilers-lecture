%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define YYSTYPE char *
extern FILE * yyin;
extern FILE * yyout;
extern int yylineno;
%}
%start lines
%token inum
%token fnum
%token floatdcl
%token intdcl
%token assgn
%token print
%token id
%token plus minus mult division
%token end
%left plus minus
%left mult division
%%
lines: /* empty */
    | lines line /* do nothing */
line: assign end { fprintf(yyout, "digraph line%d {\n\tAssign -> %s\n}\n\n", yylineno - 1, $$);} 
    | declaration end { fprintf(yyout, "digraph line%d {\n\tDeclaration -> %s\n}\n\n", yylineno - 1, $$);} 
    | output end { fprintf(yyout, "digraph line%d {\n\tOutput -> %s\n}\n\n", yylineno - 1, $$);} 
    ;
assign : id assgn id operation num {
        char str[200];
        strcpy (str, "id1, assgn, id2, operation, num\n\toperation -> ");
        strcat (str, $4);
        strcat (str, "\n\tnum -> ");
        strcat (str, $5);
        $$ = str;
    }
    | id assgn num {
        char str[80];
        strcpy (str, "id, assgn, num\n\tnum -> ");
        strcat (str, $3);
        $$ = str;
    }
    ;
declaration : type id { 
        char str[80];
        strcpy (str, "type, id\n\ttype -> ");
        strcat (str, $$);
        $$ = str;
    };
output : print num {
        char str[200];
        strcpy (str, "print, num\n\tnum -> ");
        strcat (str, $2);
        $$ = str;
    }
    | print id {$$ = "print id";}
    ;
type : intdcl {$$ = "intdcl";}
    | floatdcl {$$ = "floatdcl";}
    ;
num : inum {$$ = "inum";}
    | fnum {$$ = "fnum";} 
    ;
operation: plus {$$ = "plus ";} 
    | minus {$$ = "minus ";}
    | mult {$$ = "mult ";} 
    | division {$$ = "division ";}
    ;
%%
int main (int argc, char **argv) {
    FILE *f;    
    if( argc != 2) {
        printf("usage: source code filename \n");
        exit(1);
    }
    if (!(yyin = fopen(argv[1],"r"))){ 
        printf("cannot open file\n");
        exit(1);
    }

    yyout = fopen("trees.dot", "w");

    return yyparse ( );
}

int yyerror (char *s) {fprintf (stderr, "%s\n", s);}