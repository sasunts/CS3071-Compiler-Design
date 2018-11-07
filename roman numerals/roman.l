%{
# include "roman.tab.h"
int yyerror(char *s);
int yylex();
%}

%%
I{4,} { yyerror("syntax error"); }
X{4,} { yyerror("syntax error"); }
C{4,} { yyerror("syntax error"); }
IVI{1,} { yyerror("syntax error"); }
IXI{1,} { yyerror("syntax error"); }
XLX{1,} { yyerror("syntax error"); }
XCX{1,} { yyerror("syntax error"); }
CDC{1,} { yyerror("syntax error"); }
CMC{1,} { yyerror("syntax error"); }
"IV" { yylval = 4; return NUM;  }
"IX" { yylval =  9; return NUM; }
"XL" { yylval = 40; return NUM; }
"XC" { yylval = 90; return NUM; }
"CD" { yylval =  400; return NUM;}
"CM" { yylval =  900; return NUM; }
"I" { yylval  =  1;return NUM; }
"V" { yylval =  5; return NUM;}
"X" { yylval =  10; return NUM; }
"L" { yylval =  50;return NUM; }
"C" { yylval =  100; return NUM; }
"D" { yylval =  500; return NUM;}
"M" { yylval =  1000; return NUM; }

\n  { return EOL; }
.	{  }
%%
