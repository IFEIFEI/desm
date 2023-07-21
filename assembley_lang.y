%{
#include "lex.yy.c"

int yyparse(void);
void yyerror(char*);
void debug(char*);

%}
%union{
    char* str;
    int cond_t;
    int suffix_t;
}
%token <str> OPCODE RE OP2
%token <cond_t> COND
%token <suffix_t> SUFFIX
%token SEP
%token DELIM

%type <str> inst lang op_1 op_2 op_3

%%
lang :  inst DELIM lang      {  }
| inst                       { }
;

inst : OPCODE                   { printf("match opcode: %s\n",$1); }
| OPCODE op_1                   { printf("match opcode1:%s %s\n",$1,$2); /*printf("match opcode3:%s %s %s %s\n", $1, $2, $4, $6);*/ }
| OPCODE op_1 SEP op_2          { printf("match opcode2:%s %s %s\n",$1,$2,$4); }
| OPCODE op_1 SEP op_2 SEP op_3 { printf("match opcode3:%s %s %s %s\n",$1,$2,$4,$6); }
;

op_1 : RE                           {}
;

op_2 : RE                           {}
;

op_3 : OP2                          {}
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