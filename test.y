%{
#include "lex.yy.c"

int yyparse(void);
void yyerror(char*);
void debug(char*);

%}
%union{
    char* str;
}
%token <str> INST
%token SEP
%type <str> lang

%%
lang : INST SEP lang             { printf("match inst  : %s\n", $1); }
| INST                           { printf("match inste : %s\n", $1); }                              
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