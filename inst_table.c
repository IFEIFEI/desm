#include "stdh.h"
#include "debug.h"

#include "inst_table.h"


struct inst_table* gen_inst_table()
{
    struct inst_table* it = malloc(sizeof(struct inst_table)*OP_COUNT);
    it[0].op_name = strdup("abs");
    it[0].op_type = OP_ABS;

    it[1].op_name = strdup("add");
    it[1].op_type = OP_ADD;

#ifdef INST_TABLE_DEBUG
    for(int i=0; i < OP_COUNT; i++)
        printf("op table[%d]:%d\t%s\n", i, it[i].op_type, it[i].op_name);
#endif

    return it;
}

int check_inst(struct inst_table* it, char* op_name)
{
#ifdef INST_TABLE_DEBUG
    printf("check inst:%s\n", op_name);
#endif
    for(int i=0; i < OP_COUNT; i++)
        if(!strcasecmp(op_name, it[i].op_name))
            return it[i].op_type;
    return -1;
}