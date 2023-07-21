%{
#include "y.tab.h"
#include "cond_s.h"

#include <stdio.h>
#include <string.h>
%}
str         [^\n]*
delim       \n
undefined   .*
%%
{str}         { yylval.str = strdup(yytext); return INST; }
{delim}       { return SEP; }
{undefined}   { printf("error!"); exit(1); }
%%
