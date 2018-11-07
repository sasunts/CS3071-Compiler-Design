%{
#  include <stdio.h>
#  include <stdlib.h>
int yyerror(char *s);
int yylex();
int yyparse();

%}
%output "roman.tab.c"

%token NUM
%token EOL
%%

calclist: /* nothing */ {}
| calclist expr EOL { printf("%d\n", $2); }
;


expr: NUM
 | expr NUM   { $$ = $$ + $2;  }
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
