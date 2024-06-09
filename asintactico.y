%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "asintactico.tab.h"

extern FILE *yyin;
extern FILE *yyout;
extern char *yytext;

void yyerror(const char *s);
int yylex(void);
%}

%union {
    int intval;
    char *strval;
}

%token <intval> NUMBER
%token <strval> IDENTIFIER
%token <strval> CTE_STRING
%token IF ELSE WHILE SWITCH CASE PRINT READ RETURN DEF BREAK
%token OP_ASIG OP_SUM OP_REST OP_MULT OP_DIV OP_MOD OP_NOT OP_AND OP_OR
%token COMP_IGUAL COMP_DIST COMP_MENOR COMP_MAYOR COMP_MENOR_IGUAL COMP_MAYOR_IGUAL
%token PARENTESIS_I PARENTESIS_F COMA DOS_PUNTOS INDENT

%type <strval> expression statement statements cases case print_arguments print_argument


%left PRINT READ DEF
%right OP_ASIG
%left OP_OR
%left OP_AND
%left COMP_IGUAL COMP_DIST COMP_MENOR COMP_MAYOR COMP_MENOR_IGUAL COMP_MAYOR_IGUAL
%left OP_SUM OP_REST
%left OP_MULT OP_DIV OP_MOD
%right OP_NOT
%nonassoc ELSE
%nonassoc IDENTIFIER CTE_STRING NUMBER

%%

program:
    statements
    ;

statements:
    /* vacío */ { $$ = strdup(""); }
    | statements statement { 
        $$ = malloc(strlen($1) + strlen($2) + 1);
        strcpy($$, $1);
        strcat($$, $2);
        free($1);
        free($2);
    }
    ;

statement:
    expression { 
        $$ = malloc(strlen($1) + 3);
        sprintf($$, "%s;\n", $1);
        free($1);
    }
    | IF expression DOS_PUNTOS INDENT statements { 
        $$ = malloc(strlen($2) + strlen($5) + 9);
        sprintf($$, "if %s:\n%s", $2, $5);
        free($2);
        free($5);
    }
    | IF expression DOS_PUNTOS INDENT statements ELSE DOS_PUNTOS INDENT statements { 
        $$ = malloc(strlen($2) + strlen($5) + strlen($9) + 16);
        sprintf($$, "if %s:\n%selse:\n%s", $2, $5, $9);
        free($2);
        free($5);
        free($9);
    }
    | WHILE expression DOS_PUNTOS INDENT statements { 
        $$ = malloc(strlen($2) + strlen($5) + 13);
        sprintf($$, "while %s:\n%s", $2, $5);
        free($2);
        free($5);
    }
    | SWITCH expression DOS_PUNTOS INDENT cases { 
        $$ = malloc(strlen($2) + strlen($5) + 16);
        sprintf($$, "switch %s:\n%s", $2, $5);
        free($2);
        free($5);
    }
    | PRINT PARENTESIS_I print_arguments PARENTESIS_F {
        fprintf(yyout, "%s\n", $3); // Escribir en yyout
        free($3);
    }
    | READ PARENTESIS_I IDENTIFIER PARENTESIS_F { 
        $$ = malloc(strlen($3) + 12);
        sprintf($$, "%s = input()\n", $3);
        free($3);
    }
    | RETURN expression { 
        $$ = malloc(strlen($2) + 10);
        sprintf($$, "return %s\n", $2);
        free($2);
    }
    | DEF IDENTIFIER DOS_PUNTOS{ 
        $$ = malloc(strlen($2) + 10);
        sprintf($$, "def %s:\n", $2);
        free($2);
    }
    ;
    
print_arguments:
    /* vacío */ {$$ = strdup(""); }
    | PARENTESIS_I print_argument PARENTESIS_F { 
        $$ = malloc( strlen($2) + 3); // +1 para el nulo terminador
        sprintf($$, "%s",  $2);
        free($2);
    }
    | PARENTESIS_I print_argument COMA print_arguments PARENTESIS_F { 
        $$ = malloc(strlen($2) + strlen($4) + 3); // +1 para el nulo terminador
        sprintf($$, "%s%s", $2, $4);
        free($2);
        free($4);
    }
    ;

print_argument:
    expression { 
        $$ = strdup($1);
        free($1);
    }
    | CTE_STRING { 
        $$ = strdup(yytext); 
    }
    ;


cases:
    /* vacío */ { $$ = strdup(""); }
    | cases case {
        $$ = malloc(strlen($1) + strlen($2) + 1);
        strcpy($$, $1);
        strcat($$, $2);
        free($1);
        free($2);
    }
    ;

case:
    CASE NUMBER DOS_PUNTOS INDENT statements BREAK INDENT { 
        $$ = malloc(strlen($5) + 20);
        sprintf($$, "case %d:\n    %sbreak;\n", $2, $5);
        free($5);
    }
    ;

expression:
    NUMBER { 
        $$ = strdup(yytext); 
    }
    | IDENTIFIER { 
        $$ = strdup(yytext); 
    }
    | CTE_STRING {  // Agregamos la regla para reconocer cadenas de caracteres
        $$ = strdup(yytext);
    }
    | IDENTIFIER OP_ASIG expression { 
        $$ = malloc(strlen($1) + strlen($3) + 4);
        sprintf($$, "%s = %s\n", $1, $3);
        free($1);
        free($3);
    }
    | expression OP_SUM expression {
        $$ = malloc(strlen($1) + strlen($3) + 4);
        sprintf($$, "%s + %s\n", $1, $3);
        free($1);
        free($3);
    }
    | expression OP_REST expression {
        $$ = malloc(strlen($1) + strlen($3) + 4);
        sprintf($$, "%s - %s\n", $1, $3);
        free($1);
        free($3);
    }
    | expression OP_MULT expression {
        $$ = malloc(strlen($1) + strlen($3) + 4);
        sprintf($$, "%s * %s\n", $1, $3);
        free($1);
        free($3);
    }
    | expression OP_DIV expression {
        $$ = malloc(strlen($1) + strlen($3) + 4);
        sprintf($$, "%s / %s\n", $1, $3);
        free($1);
        free($3);
    }
    | expression OP_MOD expression {
        $$ = malloc(strlen($1) + strlen($3) + 4);
        sprintf($$, "%s %% %s\n", $1, $3);
        free($1);
        free($3);
    }
    | OP_NOT expression {
        $$ = malloc(strlen($2) + 4);
        sprintf($$, "!%s\n", $2);
        free($2);
    }
    | expression OP_AND expression {
        $$ = malloc(strlen($1) + strlen($3) + 6);
        sprintf($$, "%s && %s\n", $1, $3);
        free($1);
        free($3);
    }
    | expression OP_OR expression {
        $$ = malloc(strlen($1) + strlen($3) + 5);
        sprintf($$, "%s || %s\n", $1, $3);
        free($1);
        free($3);
    }
    | expression COMP_IGUAL expression {
        $$ = malloc(strlen($1) + strlen($3) + 5);
        sprintf($$, "%s == %s\n", $1, $3);
        free($1);
        free($3);
    }
    | expression COMP_DIST expression {
        $$ = malloc(strlen($1) + strlen($3) + 5);
        sprintf($$, "%s != %s\n", $1, $3);
        free($1);
        free($3);
    }
    | expression COMP_MENOR expression {
        $$ = malloc(strlen($1) + strlen($3) + 4);
        sprintf($$, "%s < %s\n", $1, $3);
        free($1);
        free($3);
    }
    | expression COMP_MAYOR expression {
        $$ = malloc(strlen($1) + strlen($3) + 4);
        sprintf($$, "%s > %s\n", $1, $3);
        free($1);
        free($3);
    }
    | expression COMP_MENOR_IGUAL expression {
        $$ = malloc(strlen($1) + strlen($3) + 5);
        sprintf($$, "%s <= %s\n", $1, $3);
        free($1);
        free($3);
    }
    | expression COMP_MAYOR_IGUAL expression {
        $$ = malloc(strlen($1) + strlen($3) + 5);
        sprintf($$, "%s >= %s", $1, $3);
        free($1);
        free($3);
    }
    | PARENTESIS_I expression PARENTESIS_F {
        $$ = malloc(strlen($2) + 3);
        sprintf($$, "(%s)", $2);
        free($2);
    }
    ;

%%

int main(int argc, char** argv) {
    FILE* archivo_entrada;
    FILE* archivo_salida;

    if (argc < 2) {
        printf("Uso: %s <archivo de entrada>\n", argv[0]);
        return 1;
    }

    archivo_entrada = fopen(argv[1], "r");
    if (!archivo_entrada) {
        perror("Error al abrir el archivo de entrada");
        return 1;
    }

    archivo_salida = fopen("output.txt", "w");
    if (!archivo_salida) {
        perror("Error al abrir el archivo de salida");
        fclose(archivo_entrada);
        return 1;
    }

    yyin = archivo_entrada;
    yyout = archivo_salida;

    yyparse();
    fflush(yyout);

    fclose(archivo_entrada);
    fclose(archivo_salida);

    return 0;
}


void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
