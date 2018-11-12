%{
#  include <stdio.h>
#  include <stdlib.h>
int yyerror(char *s);
int yylex();
int yyparse();

%}
%output "calcwithvariables.tab.c"

%token PRINT ADD SUB MUL DIV ASN EOL LPAR RPAR
%token NUM VAR
%%

calclist:  {}
| calclist expr EOL { printf("%d",$2); }
;

expr: factor
| expr ADD factor { $$ = $1 + $3; }
| expr SUB factor { $$ = $1 - $3; }
;

factor: value
 | factor MUL value { $$ = $1 * $3; }
 | factor DIV value { $$ = $1 / $3; }
 ;

value: NUM
;


%%
int yyerror(char *s)
{
  printf("%s\n", s);
  exit(0);
}

int
main()
{
  yyparse();
  return 0;
}
