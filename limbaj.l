%{
#include <stdio.h>
#include "y.tab.h"
#include<string.h>
%}
%%
"main()" {return MAIN;}
"inceput" {return START;}
"sfarsit" {return END;}
"int"|"float"|"char"|"string" {yylval.nume=strdup(yytext);return TIP;}
"if" {return IF;}
"while" {return WHILE;}
"for" {return FOR;}
"else" {return ELSE;}
"strcpy" {return STRCPY;}
"strcat" {return STRCAT;}
"clasa" {return CLASA;}
"privat:"|"public:"|"protected:" {return PROP;}
"++" {return INCR;}
"--" {return DECR;}
maxim {return MAX;}
minim {return MIN;}
modul {return MOD;}
cmmdc {return CMMDC;}
cmmmc {return CMMMC;}
afiseaza {return AFISEAZA;}
"const" {return CONST;}
"=" {return ASIGNARE;}
"<"|">"|"<="|">="|"=="|"!=" {return COMP;}
[a-zA-Z][a-zA-Z0-9]*  {yylval.nume=strdup(yytext);return ID;}
"-"?[1-9][0-9]* {yylval.val=atoi(yytext);return NR;}
[ \t]+ ;
"\r\n"|"\n" {yylineno++;}
. {return yytext[0];}
%%