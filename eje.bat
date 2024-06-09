@echo off
flex alexico.l
bison -d asintactico.y
gcc asintactico.tab.c lex.yy.c -lfl -o programa
del asintactico.tab.c
del asintactico.tab.h
del lex.yy.c