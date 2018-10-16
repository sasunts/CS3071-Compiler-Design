%{

%}

string   ["][^"]*["]
comment1 [{].*[}]+
comment2 "**".*+
comment3 [{](.*\n)*[}]+
comment4 [{](\n.*)*[}]+
syntax1 [}]
syntax2 [{]


%%

{string}	{printf("%s",yytext);}
{comment1}	{}
{comment2}	{}
{comment3}	{}
{comment4}	{}
{syntax1}	{
			printf("syntax error\n");
			return 0;
		}
{syntax2}	{
			printf("syntax error\n");
			return 0;
			}


%%

int main()
{
	yylex();
	return 0;
}
