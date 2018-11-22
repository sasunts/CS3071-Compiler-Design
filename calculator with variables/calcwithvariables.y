%{
int yyerror (char *s);
int yylex();
#include <stdio.h>
#include <stdlib.h>
int symbols[100];
int symbolVal(char symbol);
void updateSymbolVal(char symbol, int val);
%}
%output "calcwithvariables.tab.c"

%union {int num; char id;}
%start calclist
%token ASN DIV MUL PLUS MINUS
%token print
%token <num> number
%token <id> variable
%type <num> calclist exp term
%type <id> assignment
%%

calclist: assignment ';'		{}
	| print exp ';'						{ printf("%d\n", $2); }
	| calclist assignment ';'	{}
	| calclist print exp ';'	{ printf("%d\n", $3); }
  ;

assignment : variable ASN exp  { updateSymbolVal($1,$3); }
	;

exp: term                 { $$ = $1; }
	| MINUS term						{ $$ = -$2; }
  | exp PLUS term         { $$ = $1 + $3; }
  | exp MINUS term        {
														if($3>0){
																$$ = $1 - $3;
															}
															else{
																$$ = $1 + $3;
															}
													}
	| exp MUL term          { $$ = $1 * $3; }
	| exp DIV term          { $$ = $1 / $3; }
  ;

term: number        { $$ = $1; }
		| variable			{ $$ = symbolVal($1); }
    ;

%%

int computeSymbolIndex(char token)
{
	int index = token - 'a' + 26;
	return index;
}

int symbolVal(char symbol)
{
	int value = computeSymbolIndex(symbol);
	return symbols[value];
}

void updateSymbolVal(char symbol, int val)
{
	int value = computeSymbolIndex(symbol);
	symbols[value] = val;
}

int main (void)
{
	int i;
	for(i=0; i<52; i++)
	{
		symbols[i] = 0;
	}

	return yyparse ( );
}

int yyerror(char *s)
{
  printf("%s\n", s);
  exit(0);
  return 0;
}
