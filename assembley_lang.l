%{
#include "y.tab.h"
#include "cond_s.h"

#include <stdio.h>
#include <string.h>
%}
numbers     ([0-9])+
imm         #{numbers}
opname      {ADD}
cond        (EQ)|(NE)|(CS)|(CC)|(MI)|(PL)|(VS)|(VC)|(HI)|(LS)|(GE)|(LT)|(GT)|(LE)|(AL)
suffix      S|s
opnamec     {opname}{cond}
opnames     {opname}{suffix}
opnamecs    {opname}{cond}{suffix}
reindex     ([0-9])|([12][0-9])|(3[0-1])
re          [RrXx]{reindex}
shiftcode   (ASR)|(LSL)|(LSR)|(ROR)
shift       ({shiftcode}{ws}+#{imm})|(RRS)
op2         {imm}|({re}(,{shift})?)

ADD         [Aa][Dd][Dd]

delim       \n
sep         [,]
whitespace  [ \t]
ws          {whitespace}*

lbp         \{
lmp         \[
lsp         \(
rbp         \}
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
{re}          { yylval.str = strdup(yytext);  return RE; }
{sep}         { return SEP; }
{op2}         { yylval.str = strdup(yytext); return OP2; }
{lbp}         { return LBP; }
{lmp}         { return LMP; }
{lsp}         { return LSP; }
{rbp}         { return RBP; }
{rmp}         { return RMP; }
{rsp}         { return RSP; }
-             { return CON; }
{imm}         { return IMM; }
{shift}       { return SHIFT; }
%%
