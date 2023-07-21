%{
#include "y.tab.h"
#include "cond_s.h"

#include <stdio.h>
#include <string.h>
%}
numbers     ([0-9])*
imm         #{numbers}
opname      {ADD}
cond        (EQ)|(NE)|(CS)|(CC)|(MI)|(PL)|(VS)|(VC)|(HI)|(LS)|(GE)|(LT)|(GT)|(LE)|(AL)
suffix      S|s
opnamec     {opname}{cond}
opnames     {opname}{suffix}
opnamecs    {opname}{cond}{suffix}
re          [RrXx]{numbers}
shift       ASR#{imm}|LSL#{imm}|LSR#{imm}|ROR#{imm}|RRS
op2         {imm}|({re}(,{shift}{0,1}))

ADD         [Aa][Dd][Dd]

delim       \n
sep         ","
ws          [ \t]
whitespace  {ws}*

lmp         \[
lsp         \(
rmp         \]
rsp         \)
undefined   .*
%%
{whitespace}  { }
{delim}       { return DELIM; }
{opnamecs}    { yylval.str = strdup(yytext); return OPCODE; }
{opnamec}     { yylval.str = strdup(yytext); return OPCODE; }
{opnames}     { yylval.str = strdup(yytext); return OPCODE; }
{opname}      { yylval.str = strdup(yytext); return OPCODE; }
{re}|(RR)          { yylval.str = strdup(yytext); return RE; }
{sep}         { return SEP; }
{op2}         { yylval.str = strdup(yytext); return OP2; }

%%
