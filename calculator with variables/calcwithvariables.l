%{
# include "calcwithvariables.tab.h"
#  include <stdio.h>
#  include <stdlib.h>
int yyerror(char *s);
int yylex();
%}

%%


"print"       {return PRINT;}
"*"						{ return MUL; }
"/"						{ return DIV; }
"+"						{ return ADD; }
"-"						{ return SUB; }
":="    { return ASN; }
[0-9]+  { yylval.num = atoi(yytext); return NUM;}
[a-z]   { yylval.string = yytext[0]; return VAR; }

";"     { return EOL; }
[ \t]   { /* ignore white space */ }
.	      {  }
%%
