#include "stdh.h"
#include "cond_s.h"

int parse_cond(char *op)
{
    return parse_cond_s(op, 0);
}

int parse_s(char *op)
{
    int len = strlen(op);
    printf("%c", op[len-1]);
    return op[len-1] == 's' || op[len-1] == 'S';
}

int parse_cond_s(char *op, int shift_s)
{
    int len = strlen(op) - shift_s;
    char ch2 = toupper(op[len-1]);
    char ch1 = toupper(op[len-2]);
    printf("%c%c", ch1, ch2);
    switch (ch2)
    {
    case 'Q': return EQ;
    case 'I':
        if(ch1 == 'M') return MI;
        else return HI;
    case 'L': 
        if(ch1 == 'P') return PL;
        else return AL;
    case 'T': 
        if(ch1 == 'L') return LT;
        else GT;
    case 'S': 
        if(ch1 == 'C') return CS;
        else if(ch1 == 'L') return LS;
             else return VS;
    case 'E':
        if(ch1 == 'N') return NE;
        if(ch1 == 'G') return GE;
        return LE;
    case 'C':
        if(ch1 == 'C') return CC;
        return VC;
    default:
        printf("condition parse error");
    }
   return -1;
}
