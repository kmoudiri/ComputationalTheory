%{
#include <stdio.h>
#include "cgen.h"

extern int yylex(void);
extern int line_num;
%}

%union
{
	char* str;
	int num;
}

%define parse.trace
%debug


%token KW_CONST
%token KW_INT
%token KW_REAL
%token KW_BOOL
%token KW_STRING
%token KW_TRUE
%token KW_FALSE
%token KW_IF
%token KW_ELSE
%token KW_FI
%token KW_WHILE
%token KW_LOOP
%token KW_POOL
%token KW_LET
%token KW_BREAK
%token KW_RETURN
%token KW_START


%right KW_NOT
%right KW_PLUS
%right KW_SUB
%left KW_MUL
%left KW_DIV
%left KW_MOD
%left KW_EQUAL
%left KW_NOTEQUAL
%left KW_LESSTHAN
%left KW_LESSEQUAL
%left KW_AND
%left KW_OR

%right SPLUS
%right SSUB
%left SUB
%left PLUS
%right PAR

%token KW_ERWTIMATIKO
%token KW_PARENTHESIS
%token KW_CLOSE_PARENTHESIS
%token KW_COMMA
%token KW_HK
%token KW_CLOSE_HK
%token KW_ARROW
%token KW_CLN
%token KW_SEPERATION
%token KW_BRACKET
%token KW_CLOSE_BRACKET
%token KW_THEN

%token <str> TK_IDENT
%token <str> TK_INT
%token <str> TK_REAL
%token <str> TK_ESCAPE
%token  TK_NONPRINT
%token <str> TK_CONSTANT

%start program_start

%type <str> program_start
%type <str> head
%type <str> program
%type <str> ext_declaration
%type <str> functions_declaration
%type <str> declarations
%type <str> assignment
%type <str> const_assignment
%type <str> value
%type <str> f_parameters
%type <str> body
%type <str> instructions
%type <str> instr_assignment
%type <str> type
%type <str> expression
%type <str> variables
%type <str> init_array
%type <str> call_function
%type <str> parameters
%type <str> if_statement
%type <str> while_statement
%type <str> stmt
%type <str> else_stmt

%%


//standard first lines (includes)
head:
{	$$ = template("\n#include <stdio.h>\n#include <stdlib.h>\n#include<string.h>\n#include \"teaclib.h\" \n\n");}
;


//main body of my program
program_start:
  head program KW_START KW_ARROW KW_PARENTHESIS KW_CLOSE_PARENTHESIS KW_CLN KW_INT KW_SEPERATION KW_BRACKET body KW_CLOSE_BRACKET {printf("%s %s\n int main() {\n%s\n}", $1, $2, $11);}
;

program:
ext_declaration {$$ = template ("%s", $1);}
| program ext_declaration  {$$ = template ("%s %s", $1, $2);}
;


// external declarations functions or variables - constant declarations
ext_declaration:
functions_declaration  {$$ = template ("%s", $1);}
| declarations  {$$ = template ("%s", $1);}
;


// my functions
functions_declaration:
KW_CONST TK_IDENT KW_ARROW  KW_PARENTHESIS f_parameters KW_CLOSE_PARENTHESIS KW_CLN type KW_SEPERATION KW_BRACKET body KW_CLOSE_BRACKET {$$ = template("\n%s  %s  (%s) {\n  %s}\n" ,$8 ,$2, $5, $11);}
| KW_CONST TK_IDENT KW_ARROW  KW_PARENTHESIS KW_CLOSE_PARENTHESIS KW_CLN type KW_SEPERATION KW_BRACKET body KW_CLOSE_BRACKET {$$ = template("\n%s  %s  () {\n  %s}\n" ,$7 ,$2, $10);}
;

// variable or constant declarations
declarations:
KW_LET assignment KW_CLN type KW_ERWTIMATIKO { $$ = template("%s %s;\n", $4, $2);}
|KW_CONST const_assignment KW_CLN type KW_ERWTIMATIKO { $$ = template("const %s %s;\n", $4, $2);}
;


// give constants
const_assignment:
TK_IDENT value {$$ = template ("%s %s", $1, $2);}
| const_assignment KW_COMMA TK_IDENT value { $$ = template("%s, %s %s", $1, $3, $4);}
| TK_IDENT KW_HK TK_INT KW_CLOSE_HK value {$$=template("%s[%s] %s",$1,$3,$5);}
| const_assignment KW_COMMA TK_IDENT KW_HK TK_INT KW_CLOSE_HK value {$$=template("%s,%s[%s] %s",$1,$3,$5,$7);}
;


// give variables
assignment:
TK_IDENT {$$ = template("%s", $1);}
| TK_IDENT value {$$ = template ("%s %s", $1, $2);}
| TK_IDENT KW_HK TK_INT KW_CLOSE_HK {$$=template("%s[%s]",$1,$3);}
| TK_IDENT KW_HK TK_INT KW_CLOSE_HK value {$$=template("%s[%s] %s",$1,$3,$5);}
| assignment KW_COMMA TK_IDENT { $$ = template("%s, %s", $1, $3);}
| assignment KW_COMMA TK_IDENT value { $$ = template("%s, %s %s", $1, $3, $4);}
| assignment KW_COMMA TK_IDENT KW_HK TK_INT KW_CLOSE_HK {$$=template("%s,%s[%s]",$1,$3,$5);}
| assignment KW_COMMA TK_IDENT KW_HK TK_INT KW_CLOSE_HK value {$$=template("%s,%s[%s] %s",$1,$3,$5,$7);}
;


// give values (<- x)
value:
KW_ARROW expression {$$ = template ("= %s", $2);}
;


expression:
variables {$$ = template("%s", $1);}
| KW_BRACKET init_array KW_CLOSE_BRACKET {$$=template("{%s}",$2);}
| call_function
| KW_PARENTHESIS expression KW_CLOSE_PARENTHESIS %prec PAR {$$ = template("(%s)", $2);}
| expression KW_PLUS expression %prec PLUS {$$ = template("%s + %s", $1, $3);}
| KW_NOT expression {$$ = template("! %s", $2);}
| KW_PLUS expression %prec SPLUS {$$ = template("+ %s", $2);}
| KW_SUB expression %prec SSUB {$$ = template("- %s", $2);}
| expression KW_SUB expression %prec SUB {$$ = template("%s - %s", $1, $3);}
| expression KW_MUL expression {$$ = template("%s * %s", $1, $3);}
| expression KW_DIV expression {$$ = template("%s / %s", $1, $3);}
| expression KW_MOD expression {$$ = template("%s %% %s", $1, $3);}
| expression KW_EQUAL expression {$$ = template("%s == %s", $1, $3);}
| expression KW_NOTEQUAL expression {$$ = template("%s != %s", $1, $3);}
| expression KW_LESSTHAN expression {$$ = template("%s < %s", $1, $3);}
| expression KW_LESSEQUAL expression {$$ = template("%s <= %s", $1, $3);}
| expression KW_AND expression {$$ = template("%s && %s", $1, $3);}
| expression KW_OR expression {$$ = template("%s || %s", $1, $3);}
;


// types of variables
variables:
TK_INT
| TK_REAL
| TK_CONSTANT
| TK_IDENT
| KW_TRUE { $$ = template("1");}
| KW_FALSE { $$ = template("0");}
;


// intialize arrays - give values
init_array:
variables {$$ = template("%s",$1);}
| init_array KW_COMMA variables { $$ = template("%s, %s", $1, $3);}
;


// function parameters
f_parameters:
TK_IDENT KW_CLN type { $$ = template("%s %s", $3, $1); }
| TK_IDENT KW_HK TK_INT KW_CLOSE_HK KW_CLN type { $$ = template("%s [%s] %s", $1, $3, $6);}
| f_parameters KW_COMMA TK_IDENT KW_CLN type { $$ = template("%s, %s %s", $1, $5, $3); }
;


// body of functions
body:
instructions { $$ = template("%s", $1);}
| body instructions { $$ = template("%s %s", $1, $2);}
;


instructions:
instr_assignment KW_ERWTIMATIKO { $$ = template("%s;\n",$1);}
| if_statement  {$$ = template("%s", $1);}
| while_statement KW_POOL KW_ERWTIMATIKO {$$ = template("%s\n", $1);}
| KW_RETURN expression KW_ERWTIMATIKO { $$ = template("return %s ;\n", $2);}
| declarations { $$ = template("%s", $1);}
| call_function KW_ERWTIMATIKO { $$ = template("%s;\n", $1);}
;


// give a value to a variable using an expression
instr_assignment:
TK_IDENT KW_ARROW expression { $$ = template("%s = %s",$1 , $3);}
| type TK_IDENT KW_ARROW expression { $$ = template("%s %s = %s",$1 ,$2 ,$4);}
| TK_IDENT KW_HK TK_INT KW_CLOSE_HK KW_ARROW expression {$$ = template("%s [%s] = %s",$1, $3, $6);}
;


if_statement:
	KW_IF expression KW_THEN  stmt KW_ELSE else_stmt KW_FI KW_ERWTIMATIKO {$$ = template("if (%s) {\n %s} else %s\n", $2, $4, $6);}
|	KW_IF expression KW_THEN stmt KW_FI KW_ERWTIMATIKO  {$$ = template("if (%s) {\n%s}\n", $2, $4);}
;


else_stmt:
instructions { $$ = template("%s", $1);}
| stmt instructions { $$ = template("{\n%s %s}", $1, $2);}
;


while_statement:
KW_WHILE expression KW_LOOP stmt { $$ = template("while (%s) {\n%s}\n", $2, $4);}
;


// one or more instructions into if and while
stmt:
instructions { $$ = template("%s", $1);}
| stmt instructions { $$ = template("%s %s", $1,$2);}
;


type:
KW_INT {$$ = template("int");}
| KW_REAL {$$ = template("double");}
| KW_BOOL {$$ = template("int");}
| KW_STRING {$$ = template("char");}
;


call_function:
TK_IDENT KW_PARENTHESIS parameters KW_CLOSE_PARENTHESIS { $$ = template("%s(%s)", $1, $3);}
| TK_IDENT KW_PARENTHESIS KW_CLOSE_PARENTHESIS  { $$ = template("%s()", $1);}
;


parameters:
expression {$$ = template("%s", $1);}
| parameters KW_COMMA TK_IDENT {$$ = template("%s, %s", $1, $3);}
;

%%
int main () {
  if ( yyparse() != 0 )
    printf("Rejected!\n");
}
