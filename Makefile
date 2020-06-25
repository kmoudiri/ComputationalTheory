ul:
	bison -d -v -r all myanalyzer.y
	flex mylexer.l
	gcc -o mycompiler lex.yy.c myanalyzer.tab.c cgen.c -lfl
	./mycompiler < useless.tc > useless.c
	gcc useless.c 
	./a.out

prime:
	bison -d -v -r all myanalyzer.y
	flex mylexer.l
	gcc -o mycompiler lex.yy.c myanalyzer.tab.c cgen.c -lfl
	./mycompiler < prime.tc > prime.c
	gcc prime.c 
	./a.out

hello:
	bison -d -v -r all myanalyzer.y
	flex mylexer.l
	gcc -o mycompiler lex.yy.c myanalyzer.tab.c cgen.c -lfl
	./mycompiler < helloworld.tc > helloworld.c
	gcc helloworld.c 
	./a.out

hellowrong:
	bison -d -v -r all myanalyzer.y
	flex mylexer.l
	gcc -o mycompiler lex.yy.c myanalyzer.tab.c cgen.c -lfl
	./mycompiler < hellowrong.tc > hellowrong.c
	gcc hellowrong.c 
	./a.out

uselesswrong:
	bison -d -v -r all myanalyzer.y
	flex mylexer.l
	gcc -o mycompiler lex.yy.c myanalyzer.tab.c cgen.c -lfl
	./mycompiler < uselesswrong.tc > uselesswrong.c
	gcc uselesswrong.c 
	./a.out
