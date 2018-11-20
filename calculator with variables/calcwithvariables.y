%{
# include <stdio.h>
# include <stdlib.h>
# include <string.h>
int yyerror(char *s);
int yylex();
int yyparse();

%}
%output "calcwithvariables.tab.c"

%token EOL
%token VAR ASN PRINT NUM

%left '+' '-'
%left '*' '/'
%left '(' ')'

%start calclist

%%

stmt: {}
  |PRINT expr {printf("%d", $2);}
  |expr
  ;

expr: expr '+' expr {$$ = $1 + $3;}
  | expr '-' expr {$$ = $1 - $3;}
  | expr '*' expr {$$ = $1 * $3;}
  | expr '/' expr {$$ = $1 / $3;}
  | NUM {$$ = $1;}
  | expr ASN expr { }
  ;



calclist:  {}
| calclist stmt EOL {  }
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
