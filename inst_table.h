#ifndef INST_TABLE_H
#define INST_TABLE_H

#include "stdh.h"

#define OP_COUNT 10
#define OP_ABS  0
#define OP_ADD  1

struct inst_table{
    char* op_name;
    int op_type;
};



struct inst_table* gen_inst_table();
int check_inst(struct inst_table* it, char* op_name);


#endif