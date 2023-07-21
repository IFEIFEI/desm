%{
#include "lex.yy.c"

int yyparse(void);
void yyerror(char*);
void debug(char*);

%}

%token INST

%%
lang :  INST lang       { }
| inst                  { printf("%s\n",$1); }
;
%%
int main()
{
    FILE *fp;
    char name[15];
    fp = fopen("input_file","r");
    while(!feof(fp))
    {
        fscanf(fp,"%s",name);
        printf("read from: %s(%zu)\n", name, strlen(name));
        yyin=fopen(name,"r");
        // set_fvalid();
        // yyin=fopen("input.p","r");

        yyparse();
        fclose(yyin);
        // process();
    }
    fclose(fp);
    return 0;
}
void yyerror(char *s)
{
    fprintf(stderr,"%s\n",s);
}
int yywrap()
{
    return 1;
}
void debug(char* msg)
{
    printf("Parsed result: %s\n",msg);
}