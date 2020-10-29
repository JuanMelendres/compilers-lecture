all:
	yacc -d syntax.y 
	flex compiler.l
	gcc lex.yy.c y.tab.c -lfl -o lexic_analyzer

clean:
	rm -rf *.c
	rm -rf *.o
	rm -rf *.h
	rm -rf lexic_analyzer
	rm -rf syntax-calc