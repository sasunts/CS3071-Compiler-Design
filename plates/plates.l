%{
#include <stdio.h>
#include <stdlib.h>
%}

plates1	  	([01][0-9]|[01][0-9][12])
plates2		([0189][0-9])
counties1 (DL)|(CW)|(CN)|(CE)|(C)|(D)|(G)|(KE)|(KK)|(KY)|(LD)|(LH)|(LM)|(LS)|(L)|(MH)|(MN)|(MO)|(OY)|(RN)|(SO)|(T)|(WH)|(WX)|(WW)|(W)

counties2 (DL)|(CW)|(CN)|(CE)|(C)|(D)|(G)|(KE)|(KK)|(KY)|(LD)|(LH)|(LK)|(LM)|(LS)|(L)|(MH)|(MN)|(MO)|(OY)|(RN)|(SO)|(TN)|(TS)|(WH)|(WD)|(WX)|(WW)|(W)
space	[\r\n\t\f\v ]

%%
{space} {}
"\n"+	{}
{plates1}-{counties1}-[0-9]{1,6}{space}+	{yearFrom(yytext);}

{plates2}-{counties2}-[0-9]{1,6}{space}+	{yearFrom(yytext);}


.*{space}		{printf("INVALID\n");}


%%
int yearFrom(char p[])
{
	char year[2];
	int pZero = p[0] - '0';

	if (pZero < 2)
	{
		int i =0;
		for (i =0; i<2; i++)
		{
			year[i] = p[i];
		}
		
		int yearFrom1 = 18 - atoi(year);
		printf("%d\n", yearFrom1);
	}
	char doubleYear[] = "1900";
	if (pZero >= 8)
	{
		int i=0;
		for (i =0; i<2; i++)
		{
			doubleYear[i+2] = p[i]; 		
		}
		int yearFrom2 = 2018 - atoi(doubleYear);
		printf("%d\n",yearFrom2);	
	}

}

int main()
{
	yylex();
	return 0;
}

