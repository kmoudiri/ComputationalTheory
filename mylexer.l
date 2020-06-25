%{
  #include <stdio.h>
  #include <string.h>
  #include "cgen.h"
  #include  "myanalyzer.tab.h"
  #include <math.h>
  int line_num = 1;
%}


%x comment


Identifiers      [a-zA-Z][0-9a-zA-Z_]*
Integers   [0-9][0-9]*
Real    {Integers}("."[0-9][0-9]*)([eE][+-]?{Integers})?
Non_print [^"\\\"^"\\'"^"\\"^"\\n"]
Escape_Characters    ("\\n"|"\\t"|"\\r"|"\\\\"|"\\\"")
Constant_strings  ("\"")(({Escape_Characters}|{Non_print})*)("\"")

Arithmetic_Operators    ("+"|"-"|"*"|"/"|"%")
Relational_Operators    ("="|"!="|"<"|"<=")
Logical_operators   ("and"|"or"|"not")
Effecient_operators   ("+"|"-")


%%

"(*"                    { BEGIN(comment); printf("/* comment started at line: %d\n", line_num); }

<comment>[^*\n]*        /* eat anything that's not a '*' */
<comment>\n             ++line_num;
<comment>"*"+")"        { BEGIN(INITIAL); printf("comment ended at line: %d\n */", line_num); }
"--"[^\n]*              /* line comment */



"const start" {yylval.str = strdup(yytext); return KW_START;}
const {yylval.str = strdup(yytext); return KW_CONST;}
int {yylval.str = strdup(yytext); return KW_INT;}
real {yylval.str = strdup(yytext); return KW_REAL;}
bool { yylval.str = strdup(yytext); return KW_BOOL;}
string {yylval.str = strdup(yytext); return KW_STRING;}
true {yylval.str = strdup(yytext); return KW_TRUE;}
false { yylval.str = strdup(yytext); return KW_FALSE;}
if { yylval.str = strdup(yytext); return KW_IF;}
else { yylval.str = strdup(yytext); return KW_ELSE;}
fi { yylval.str = strdup(yytext); return KW_FI;}
while { yylval.str = strdup(yytext); return KW_WHILE;}
loop { yylval.str = strdup(yytext); return KW_LOOP;}
pool { yylval.str = strdup(yytext); return KW_POOL;}
let { yylval.str = strdup(yytext); return KW_LET;}
break { yylval.str = strdup(yytext); return KW_BREAK;}
return {yylval.str = strdup(yytext); return KW_RETURN;}
not { yylval.str = strdup(yytext); return KW_NOT;}
and { yylval.str = strdup(yytext); return KW_AND;}
or { yylval.str = strdup(yytext); return KW_OR;}
then { yylval.str = strdup(yytext); return KW_THEN;}


"+" {  yylval.str = strdup(yytext); return KW_PLUS;}
"-" {  yylval.str = strdup(yytext); return KW_SUB;}
"*" {  yylval.str = strdup(yytext); return KW_MUL;}
"/" {  yylval.str = strdup(yytext); return KW_DIV;}
"%" {  yylval.str = strdup(yytext); return KW_MOD;}
"=" {  yylval.str = strdup(yytext); return KW_EQUAL;}
"!=" {  yylval.str = strdup(yytext); return KW_NOTEQUAL;}
"<" {  yylval.str = strdup(yytext); return KW_LESSTHAN;}
"<=" {  yylval.str = strdup(yytext); return KW_LESSEQUAL;}
";" {  yylval.str = strdup(yytext); return KW_ERWTIMATIKO;}
"(" {  yylval.str = strdup(yytext); return KW_PARENTHESIS;}
")" {  yylval.str = strdup(yytext); return KW_CLOSE_PARENTHESIS;}
"," {  yylval.str = strdup(yytext); return KW_COMMA;}
"[" {  yylval.str = strdup(yytext); return KW_HK;}
"]" {  yylval.str = strdup(yytext); return KW_CLOSE_HK;}
"<-" {  yylval.str = strdup(yytext); return KW_ARROW;}
":" {  yylval.str = strdup(yytext); return KW_CLN;}
"=>" { yylval.str = strdup(yytext); return KW_SEPERATION;}
"{" {yylval.str = strdup(yytext); return KW_BRACKET;}
"}" {yylval.str = strdup(yytext); return KW_CLOSE_BRACKET;}


{Constant_strings} {yylval.str = strdup(yytext); return TK_CONSTANT;}
{Identifiers}  {yylval.str = strdup(yytext); return TK_IDENT;}
{Integers}     {yylval.str = strdup(yytext); return TK_INT;}
{Real}   {yylval.str = strdup(yytext); return TK_REAL;}



[ \r\t]+			/* skip whitespace */

\n 					 ++line_num;
.           { printf("Line %d Lexical Error: Unrecognized literal %s\n", line_num, yytext); }
