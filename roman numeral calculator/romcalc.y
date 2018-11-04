%{
#  include <stdio.h>
#  include <stdlib.h>
#  include <string.h>
int yyerror(char *s);
int yylex();
int yyparse();
int printRoman(int number);
void predigit(char num1, char num2);
void postdigit(char c, int n);

%}
%output "romcalc.tab.c"

%token NUM
%token LPARENTHESIS RPARENTHESIS
%token MULTIPLY DIVIDE ADD SUBTRACT
%token EOL
%%

calclist:  {}
| calclist expr EOL { printRoman($2); }
;

expr: factor
| expr ADD factor { $$ = $1 + $3; }
| expr SUBTRACT factor { $$ = $1 - $3; }
;

factor: parenthesis
 | factor MULTIPLY parenthesis { $$ = $1 * $3; }
 | factor DIVIDE parenthesis { $$ = $1 / $3; }
 ;

parenthesis: value
| LPARENTHESIS expr RPARENTHESIS { $$ = $2; }
;

value: NUM
 | value NUM   { $$ = $$ + $2;  }
 ;
%%

char romanval[1000];
int i = 0;
int printRoman(int number)
{
    int j;
    if (number == 0)
    {
        printf("Z\n");
        return 0;
    }
    else if (number < 0)
    {
        int positive = abs(number);
        printf("-");
        return printRoman(positive);
    }
    while (number != 0)
    {
        if (number >= 1000)
        {
            postdigit('M', number / 1000);
            number = number - (number / 1000) * 1000;
        }
        else if (number >= 500)
        {
            if (number < (500 + 4 * 100))
            {
                postdigit('D', number / 500);
                number = number - (number / 500) * 500;
            }
            else
            {
                predigit('C','M');
                number = number - (1000-100);
            }
        }
        else if (number >= 100)
        {
            if (number < (100 + 3 * 100))
            {
                postdigit('C', number / 100);
                number = number - (number / 100) * 100;
            }
            else
            {
                predigit('L', 'D');
                number = number - (500 - 100);
            }
        }
        else if (number >= 50 )
        {
            if (number < (50 + 4 * 10))
            {
                postdigit('L', number / 50);
                number = number - (number / 50) * 50;
            }
            else
            {
                predigit('X','C');
                number = number - (100-10);
            }
        }
        else if (number >= 10)
        {
            if (number < (10 + 3 * 10))
            {
                postdigit('X', number / 10);
                number = number - (number / 10) * 10;
            }
            else
            {
                predigit('X','L');
                number = number - (50 - 10);
            }
        }
        else if (number >= 5)
        {
            if (number < (5 + 4 * 1))
            {
                postdigit('V', number / 5);
                number = number - (number / 5) * 5;
            }
            else
            {
                predigit('I', 'X');
                number = number - (10 - 1);
            }
        }
        else if (number >= 1)
        {
            if (number < 4)
            {
                postdigit('I', number / 1);
                number = number - (number / 1) * 1;
            }
            else
            {
                predigit('I', 'V');
                number = number - (5 - 1);
            }
        }
    }
    for(j = 0; j < i; j++)
        printf("%c", romanval[j]);
    printf("\n");
    memset(romanval, 0, sizeof(romanval));
    i=0;
    return 0;
}

void predigit(char num1, char num2)
{
    romanval[i++] = num1;
    romanval[i++] = num2;
}

void postdigit(char c, int n)
{
    int j;
    for (j = 0; j < n; j++)
        romanval[i++] = c;
}

int yyerror(char *s)
{
  printf("%s\n", s);
  exit(0);
  return 0;
}


int
main()
{
  yyparse();
  return 0;
}
