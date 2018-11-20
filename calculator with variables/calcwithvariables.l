%{
# include "calcwithvariables.tab.h"
#  include <stdio.h>
#  include <stdlib.h>
int yyerror(char *s);
int yylex();
%}

%%


"print" {return PRINT;}
":="    { return ASN; }
[0-9]+  { yylval = atoi(yytext); return NUM;}
[a-z]   { yylval = yytext[0]; return VAR; }

";"     { return EOL; }
[ \t]   { /* ignore white space */ }
.	      {  }
%%
