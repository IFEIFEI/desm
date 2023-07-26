CC = gcc
CFLAG = -lm -ly -ll -lz3
DEBUG = -ggdb3
INST = add

pl: y.tab.c y.tab.h lex.yy.c cond_s.o $(INST).o
	$(CC) -o pl y.tab.c cond_s.o  $(INST).o $(FLAG) $(DEBUG)

y.tab.c y.tab.h: assembley_lang.y
	yacc -v -d assembley_lang.y

lex.yy.c: assembley_lang.l y.tab.h cond_s.h
	lex assembley_lang.l

cond_s : cond_s.h cond_s.c
	$(CC) -c -o cond_s.o cond_s.c $(DEBUG)

$(INST).o: $(INST).h $(INST).c
	$(CC) -c -o $(INST).o $(INST).c $(DEBUG)

.PHONY : clean
clean : 
	rm y.tab.c y.tab.h lex.yy.c cond_s.o pl 
