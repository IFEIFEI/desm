#include "stdh.h"
#include "add.h"

void gen_add()
{
    gen_add_fun();
    gen_add_stat_acc();
    gen_add_lemma();
}

void gen_add_fun()
{
    char* fun = "definition g1 ::  \"state ⇒ state \" where  [my_def]:\n \
     \"g1 s  = s⦇ \n \
        sR:=sR s⦇ \
        R4 := R3(sR s) + 0x1, \n \
        PC := PC (sR s) + 0x2 \n \
    ⦈                      \n \
  ⦈\"\n"; 
    printf("%s", fun);

}

void gen_add_stat_acc()
{
    char* acc = " definition F1_2 :: \"state ⇒ state\" where  [my_def]: \
              \" F1_2 s = g1_2 s \n ";
    printf("%s", acc);
}

void gen_add_lemma()
{
    char* lemma = " lemma L1_2: \n \
         assumes \" prec s = True \" \n \
         shows   \" F1_2 s = s⦇  \n \
     R4 := R3(sR s) + 0x1, \n \
     PC := PC (sR s) + 0x2 \n \
    ⦈                      \n \
  using  assms   by (auto simp : my_def ) \n";
    printf("%s", lemma);
}
