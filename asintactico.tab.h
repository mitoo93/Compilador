
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     NUMBER = 258,
     IDENTIFIER = 259,
     CTE_STRING = 260,
     IF = 261,
     ELSE = 262,
     WHILE = 263,
     SWITCH = 264,
     CASE = 265,
     PRINT = 266,
     READ = 267,
     RETURN = 268,
     DEF = 269,
     BREAK = 270,
     OP_ASIG = 271,
     OP_SUM = 272,
     OP_REST = 273,
     OP_MULT = 274,
     OP_DIV = 275,
     OP_MOD = 276,
     OP_NOT = 277,
     OP_AND = 278,
     OP_OR = 279,
     COMP_IGUAL = 280,
     COMP_DIST = 281,
     COMP_MENOR = 282,
     COMP_MAYOR = 283,
     COMP_MENOR_IGUAL = 284,
     COMP_MAYOR_IGUAL = 285,
     PARENTESIS_I = 286,
     PARENTESIS_F = 287,
     COMA = 288,
     DOS_PUNTOS = 289,
     INDENT = 290
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 15 "asintactico.y"

    int intval;
    char *strval;



/* Line 1676 of yacc.c  */
#line 94 "asintactico.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


