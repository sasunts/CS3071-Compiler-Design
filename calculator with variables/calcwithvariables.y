%{
# include <stdio.h>
# include <stdlib.h>
# include <string.h>
int yyerror(char *s);
int yylex();
int yyparse();

%}
%output "calcwithvariables.tab.c"
%union {
  struct ast *a;
	double d;
  struct symbol *s;
  struct symlist *sl;
  int fn;
}

%token EOL
%token<d> NUM
%token<s> VAR
%token<fn> FUNC

%token PRINT

%nonassoc <fn> CMP
%right '='
%left '+' '-'
%left '*' '/'
%nonassoc '|' UMINUS


%type <a> expr stmt list explist
%type <sl> symlist

%start calclist

%%

calclist:  {}
| calclist stmt EOL {  }
| PRINT stmt EOL {printf("%d",$2);}
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
