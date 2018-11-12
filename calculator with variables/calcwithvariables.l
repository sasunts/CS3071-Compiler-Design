%{
# include "calcwithvariables.tab.h"
int yyerror(char *s);
int yylex();
%}

%%

\n  { return EOL; }
.	{  }
%%
