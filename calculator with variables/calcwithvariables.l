%{
# include "calcwithvariables.tab.h"
int yyerror(char *s);
int yylex();
%}

%%


"print" {return PRINT;}
"+"	    { return ADD; }
"-"	    { return SUB; }
"*"	    { return MUL; }
"/"	    { return DIV; }
":="    { return ASN; }
[0-9]+  { yylval = atoi(yytext); return NUM;}
[a-z]   { yylval.string = strdup(yytext); return VARIABLE; }

";"     { return EOL; }
[ \t]   { /* ignore white space */ }
.	      {  }
%%
