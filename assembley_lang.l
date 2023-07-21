%{
#include "y.tab.h"
#include "cond_s.h"

#include <stdio.h>
#include <string.h>
%}
numbers     ([0-9])+
imm         #{numbers}
opname      {ADD}
cond        [EQ|NE|CS|CC|MI|PL|VS|VC|HI|LS|GE|LT|GT|LE|AL]
suffix      S
opnamec     {opname}{cond}
opnames     {opname}{suffix}
opnamecs    {opname}{cond}{suffix}
re          [RX]{numbers}
rd          {re}
rn          {re}
shift       ASR#{imm}|LSL#{imm}|LSR#{imm}|ROR#{imm}|RRS
op2         {imm}|({re}(,{shift}{0,1}))

ADD         [Aa][Dd][Dd]

delim       [ \t]
sep         ,
whitespace  {delim}+
lmp         \[
lsp         \(
rmp         \]
rsp         \)
undefined   .*
%%
{opnamecs}    { yylval.str = strdup(yytext); yylval.suffix_t = parse_s(yytext); yylval.cond_t = parse_cond_s(yytext,1); return OPCODE; }
{opnames}     { yylval.str = strdup(yytext); yylval.suffix_t = parse_s(yytext); return OPCODE; }
{opnamec}     { yylval.str = strdup(yytext); yylval.cond_t = parse_cond(yytext); return OPCODE; }
{opname}      { yylval.str = strdup(yytext); return OPCODE; }



{rd}          { return RD; }
{rn}          { return RN; }
{op2}         { return OP2; }
{sep}         { return SEP; }
\n            {  }
%%
