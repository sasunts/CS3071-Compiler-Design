%{
#  include <stdio.h>
#  include <stdlib.h>
int yyerror(char *s);
int yylex();
int yyparse();

%}
%output "calcwithvariables.tab.c"

%token
%token
%%

calclist: /* nothing */ {}
| calclist expr EOL {  }
;


expr: /*TODO*/
 | expr   { }
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
