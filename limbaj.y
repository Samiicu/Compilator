%{
#include <stdio.h>
#include <string.h>
#include "ONLYHUMAN.h"
int erori=0;
extern FILE* yyin;
extern char* yytext;
extern int yylineno;
%}
%token ID TIP NR IF FOR WHILE ELSE MAX MIN PRINT MOD CMMDC CMMMC AFISEAZA START END MAIN ASIGNARE CONST STRCPY STRCAT PROP INCR DECR CLASA COMP
%union {int val;char *nume;}
%type<nume> ID TIP
%type<val> NR functie expresie
%start progr
%left '+' '-'
%left '*' '/'
%%
progr: declaratii cod TIP MAIN instructiuni  {if(erori==0){printf("%s",buffer); printf("program corect sintactic\n");}
                                else printf("\nprogram cu %d erori\n",erori);}
     ;


cod :  /* empty */
    | maimultcod
    | cod maimultcod
    |
    ;

maimultcod :  /* empty */
           | defunctii
           | clase
           |
           ;

defunctii :  /* empty */
        | defunctie
        | defunctii defunctie
        ;

defunctie : TIP ID '(' decparametrii ')' '{' bloc '}' 
          | TIP ID '('')' '{' bloc '}' 
          ;

declaratii :  declaratie ';'
           | declaratii declaratie ';'
           |  
           ;

           
declaratie : TIP ID '(' decparametrii ')' 
                                            
           | TIP ID '('')' 
           | decvariabile
           ;

decvariabile : TIP ID  
             | TIP ID ASIGNARE expresie 
             | TIP ID dimensiuni 
             | TIP ID dimensiuni ASIGNARE '{'tablou2 '}' 
             | CONST TIP ID dimensiuni ASIGNARE '{'tablou2 '}' 
             | CONST TIP ID ASIGNARE expresie 
             ;
clase: clase clasa
     | clasa
     |
     ; 

clasa:CLASA ID '{' dec_clasa '}' 
     ;          

dec_clasa:dec_clasa PROP declaratii 
         |PROP declaratii
         |
         ;

tablou2 : expresie
        | tablou2 ',' expresie
        ;

dimensiuni : '[' expresie ']' 
           | dimensiuni '[' expresie ']' 
           ;

decparametrii : decparametru 
              | decparametrii ',' decparametru 
              ;

decparametru : TIP ID 
             | TIP 
             | TIP '*' 
             | TIP '*' ID 
             ;
      
instructiuni : START bloc END  
             ;
     
bloc : instructiune ';'
     | decvariabile ';'
     | expresie ';'
     | bloc instructiune ';'
     | bloc decvariabile ';'
     | bloc expresie ';'
     |
     ;

instructiune : ID ASIGNARE expresie 
                                   
             | AFISEAZA '(' NR ')'
             | AFISEAZA '(' ID ')' 
             | AFISEAZA '(' expresie ')' 
             | control
             | ID INCR 
             | ID DECR  
             | class_object
             | ID ASIGNARE ID 
      
control : WHILE '(' expresie ')'  '{' bloc '}'
        | IF '(' expresie ')' '{'bloc'}'
        | IF '(' expresie ')' '{'bloc'}' ELSE'{'bloc'}'
        | ELSE '(' expresie ')' '{'bloc'}' ELSE '{'bloc'}'
        | FOR '(' decvariabile ';' expresie ';' ID INCR ')' '{' bloc '}'
        | FOR '(' decvariabile ';' expresie ';' ID DECR ')' '{' bloc '}'
        | 
        ;
        
expresie : expresie '+' expresie {$$=$1+$3;}
         | expresie '-' expresie {$$=$1-$3;}
         | expresie '*' expresie {$$=$1*$3;}
         | expresie '/' expresie {$$=$1/$3;}
         | NR {$$=$1;}
         | ID 
         | functie {$$=$1;}
         | expresie COMP expresie 
         | ID '('expresii ')' 
         | ID '('')'  
         | ID
         ;

class_object: /*empty*/
            |  ID '.' class_object
            |  ID '.' ID 
            |  ID '.' ID '(' expresie ')' ';'
            |  ID '.' ID '(' expresie ')'
            |  ID '.' ID '(' ')' ';'
            ;

expresii : expresie {nrexpresii++;}
         | expresii ',' expresie {nrexpresii++;}
         |
         ;

functie : MAX '(' expresie ',' expresie ')' {$$=maxim($3,$5);}
        | MIN '(' expresie ',' expresie ')' {$$=minim($3,$5);}
        | MOD '(' expresie ')' {$$=modul($3);}
        | CMMDC '(' expresie ',' expresie ')' {$$=cmmdc($3,$5);}
        | CMMMC '(' expresie ',' expresie ')' {$$=cmmmc($3,$5);}
        ;
%%
int yyerror(char * s){
erori++;
printf("\n!!!  eroare: %s la linia:%d\n",s,yylineno);
}

int main(int argc, char** argv){
yyin=fopen(argv[1],"r");
yyparse();
}