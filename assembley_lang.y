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
%token <str> OPCODE RD RN OP2
%token <cond_t> COND
%token <suffix_t> SUFFIX
%token SEP

%%
lang :  inst lang      { printf("lang inst\n"); }
| inst                  { printf("inst\n"); }
;

inst : inst_op                      { printf("inst0\n"); } 
| inst_op op_1                      { printf("inst1\n"); }
| inst_op op_1 SEP op_2             { printf("inst2\n"); }
| inst_op op_1 SEP op_2 SEP op_3    { printf("inst3\n"); }
;

inst_op : OPCODE                    { printf("op(%s)\t", $1); }
| OPCODE COND                       { printf("cond\t"); }
| OPCODE COND SUFFIX                { printf("cond\t suff\t"); }
| OPCODE SUFFIX                     { printf("suff\t"); }
;

op_1 : RD                           { printf("rd\t"); }
;

op_2 : RN                           { printf("rn\t"); }
;

op_3 : OP2                          { printf("op2\n"); }
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