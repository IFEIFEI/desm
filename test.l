%{
#include "y.tab.h"
#include "cond_s.h"

#include <stdio.h>
#include <string.h>
%}
str         [A-Za-z0-9]
delim       [ \t]
undefined   .*
%%
str         { return INST; }
\n            {  }
%%
