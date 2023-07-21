#ifndef COND_S_H
#define COND_S_H

#define EQ 0x0000
#define NE 0x0001
#define CS 0x0010
#define CC 0x0011
#define MI 0x0100
#define PL 0x0101
#define VS 0x0110
#define VC 0x0111
#define HI 0x1000
#define LS 0x1001
#define GE 0x1010
#define LT 0x1011
#define GT 0x1100
#define LE 0x1101
#define AL 0x1110

int parse_cond(char *op);
int parse_s(char *op);
int parse_cond_s(char *op, int shift_s);

#endif