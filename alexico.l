%{
#include "asintactico.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%option yylineno

%%

"def"                    { fprintf(stderr, "TOKEN: DEF\n"); return DEF; }
"if"                     { fprintf(stderr, "TOKEN: IF\n"); return IF; }
"else"                   { fprintf(stderr, "TOKEN: ELSE\n"); return ELSE; }
"while"                  { fprintf(stderr, "TOKEN: WHILE\n"); return WHILE; }
"switch"                 { fprintf(stderr, "TOKEN: SWITCH\n"); return SWITCH; }
"case"                   { fprintf(stderr, "TOKEN: CASE\n"); return CASE; }
"break"                  { fprintf(stderr, "TOKEN: BREAK\n"); return BREAK; }
"print"                  { fprintf(stderr, "TOKEN: PRINT\n"); return PRINT; }
"read"                   { fprintf(stderr, "TOKEN: READ\n"); return READ; }
"return"                 { fprintf(stderr, "TOKEN: RETURN\n"); return RETURN; }
":"                      { fprintf(stderr, "TOKEN: DOS_PUNTOS\n"); return DOS_PUNTOS; }
"=="                     { fprintf(stderr, "TOKEN: COMP_IGUAL\n"); return COMP_IGUAL; }
"!="                     { fprintf(stderr, "TOKEN: COMP_DIST\n"); return COMP_DIST; }
"<"                      { fprintf(stderr, "TOKEN: COMP_MENOR\n"); return COMP_MENOR; }
">"                      { fprintf(stderr, "TOKEN: COMP_MAYOR\n"); return COMP_MAYOR; }
"<="                     { fprintf(stderr, "TOKEN: COMP_MENOR_IGUAL\n"); return COMP_MENOR_IGUAL; }
">="                     { fprintf(stderr, "TOKEN: COMP_MAYOR_IGUAL\n"); return COMP_MAYOR_IGUAL; }
"="                      { fprintf(stderr, "TOKEN: OP_ASIG\n"); return OP_ASIG; }
"+"                      { fprintf(stderr, "TOKEN: OP_SUM\n"); return OP_SUM; }
"-"                      { fprintf(stderr, "TOKEN: OP_REST\n"); return OP_REST; }
"*"                      { fprintf(stderr, "TOKEN: OP_MULT\n"); return OP_MULT; }
"/"                      { fprintf(stderr, "TOKEN: OP_DIV\n"); return OP_DIV; }
"%"                      { fprintf(stderr, "TOKEN: OP_MOD\n"); return OP_MOD; }
"!"                      { fprintf(stderr, "TOKEN: OP_NOT\n"); return OP_NOT; }
"&&"                     { fprintf(stderr, "TOKEN: OP_AND\n"); return OP_AND; }
"||"                     { fprintf(stderr, "TOKEN: OP_OR\n"); return OP_OR; }
"("                      { fprintf(stderr, "TOKEN: PARENTESIS_I\n"); return PARENTESIS_I; }
")"                      { fprintf(stderr, "TOKEN: PARENTESIS_F\n"); return PARENTESIS_F; }
","                      { fprintf(stderr, "TOKEN: COMA\n"); return COMA; }
" "                      { /* Ignorar espacios en blanco en otros contextos */ }
[ \t]                   { fprintf(stderr, "TOKEN: INDENT (%s)\n", yytext); yylval.intval = yyleng; return INDENT; } 
[0-9]+                   { fprintf(stderr, "TOKEN: NUMBER (%s)\n", yytext); yylval.intval = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]*   { fprintf(stderr, "TOKEN: IDENTIFIER (%s)\n", yytext); yylval.strval = strdup(yytext); return IDENTIFIER; }
\"[^\"\n]*\"             { fprintf(stderr, "TOKEN: CTE_STRING (%s)\n", yytext); yylval.strval = strdup(yytext); return CTE_STRING; }
  
\n                       { yylineno++; /* Manejar salto de línea */ }
.                        { fprintf(stderr, "Carácter no reconocido: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
