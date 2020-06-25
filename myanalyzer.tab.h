/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

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

#ifndef YY_YY_MYANALYZER_TAB_H_INCLUDED
# define YY_YY_MYANALYZER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    KW_CONST = 258,
    KW_INT = 259,
    KW_REAL = 260,
    KW_BOOL = 261,
    KW_STRING = 262,
    KW_TRUE = 263,
    KW_FALSE = 264,
    KW_IF = 265,
    KW_ELSE = 266,
    KW_FI = 267,
    KW_WHILE = 268,
    KW_LOOP = 269,
    KW_POOL = 270,
    KW_LET = 271,
    KW_BREAK = 272,
    KW_RETURN = 273,
    KW_START = 274,
    KW_NOT = 275,
    KW_PLUS = 276,
    KW_SUB = 277,
    KW_MUL = 278,
    KW_DIV = 279,
    KW_MOD = 280,
    KW_EQUAL = 281,
    KW_NOTEQUAL = 282,
    KW_LESSTHAN = 283,
    KW_LESSEQUAL = 284,
    KW_AND = 285,
    KW_OR = 286,
    SPLUS = 287,
    SSUB = 288,
    SUB = 289,
    PLUS = 290,
    PAR = 291,
    KW_ERWTIMATIKO = 292,
    KW_PARENTHESIS = 293,
    KW_CLOSE_PARENTHESIS = 294,
    KW_COMMA = 295,
    KW_HK = 296,
    KW_CLOSE_HK = 297,
    KW_ARROW = 298,
    KW_CLN = 299,
    KW_SEPERATION = 300,
    KW_BRACKET = 301,
    KW_CLOSE_BRACKET = 302,
    KW_THEN = 303,
    TK_IDENT = 304,
    TK_INT = 305,
    TK_REAL = 306,
    TK_ESCAPE = 307,
    TK_NONPRINT = 308,
    TK_CONSTANT = 309
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 10 "myanalyzer.y" /* yacc.c:1909  */

	char* str;
	int num;

#line 114 "myanalyzer.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_MYANALYZER_TAB_H_INCLUDED  */
