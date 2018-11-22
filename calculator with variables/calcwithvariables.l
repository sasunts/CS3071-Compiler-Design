%{
#include "calcwithvariables.tab.h"
int yyerror (char *s);
int yylex();
%}
%%

"print"			 {return print;}
[a-z]			   {yylval.id = yytext[0]; return variable;}
[0-9]+       {yylval.num = atoi(yytext); return number;}
[ \t\n]      ;
":="         {return ASN;}
";"          {return yytext[0];}
"+"          {return PLUS;}
"-"          {return MINUS;}
"/"          {return DIV;}
"*"          {return MUL;}
.            {}

%%
int yywrap (void) {return 1;}
