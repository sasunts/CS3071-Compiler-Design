%{
int result = 0;

%}


%%

[0-9]*[02468][^a-zA-Z0-9_]+	{result++;}
\n			{}
.			{}

%%

int main()
{
  yylex();
  printf("%d\n",result);
	return 0;
}
