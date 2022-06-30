%{
#include <stdio.h>
#define YYSTYPE char*
#include "cucu.tab.h"
extern YYSTYPE yylval;

%}

%%
\/\*[^\*\/]*\*\/
\/\/(.*)
"while"                    {fprintf(yyout,"keyword : %s\n",yytext);yylval=strdup(yytext); return (WHILE_KEY);}
"if"                       {fprintf(yyout,"keyword : %s\n",yytext); yylval=strdup(yytext);return IF_KEY;}
"else"                     {fprintf(yyout,"keyword : %s\n",yytext); yylval=strdup(yytext);return ELSE_KEY;}
"return"                   {fprintf(yyout,"keyword : %s\n",yytext); yylval=strdup(yytext);return RETURN;}
"int"                      {fprintf(yyout,"type : %s\n",yytext); yylval=strdup(yytext);return TYPE;}
"char *"|"char **"         {fprintf(yyout,"type : %s\n",yytext); yylval=strdup(yytext);return TYPE;}
"=="|"!="                  {fprintf(yyout,"relational operator : %s\n",yytext); yylval=strdup(yytext);return RELATIONAL_OPERATOR;}
"="                        {fprintf(yyout,"assign : %s\n",yytext); yylval=strdup(yytext);return ASSIGN;}
";"                        {fprintf(yyout,"semi-colon : %s\n",yytext);yylval=strdup(yytext);return SEMI_COLON;}
[a-zA-Z][a-zA-Z_0-9]*      {fprintf(yyout,"idnetifier : %s\n",yytext);  yylval=strdup(yytext);return ID;}
[0-9]+                     {fprintf(yyout,"numeric literal : %s\n",yytext); yylval=strdup(yytext);return LITERAL;}
[ \t\n]+      
"+"                        {fprintf(yyout,"operator : %s\n",yytext);yylval=strdup(yytext); return PLUS;}
"*"                        {fprintf(yyout,"operator : %s\n",yytext);yylval=strdup(yytext); return MUL;}
"/"                        {fprintf(yyout,"operator : %s\n",yytext); yylval=strdup(yytext);return DIV;}
"-"                        {fprintf(yyout,"operator : %s\n",yytext);yylval=strdup(yytext); return SUB;}
"("                        {fprintf(yyout,"open paranthesis : %s\n",yytext); yylval=strdup(yytext);return OPARAN;}
")"                        {fprintf(yyout,"close paranthesis : %s\n",yytext); yylval=strdup(yytext);return CPARAN;}
"{"                        {fprintf(yyout,"open flower paranthesis : %s\n",yytext);yylval=strdup(yytext); return OFPARAN;}
"}"                        {fprintf(yyout,"close flower paranthesis : %s\n",yytext);yylval=strdup(yytext); return CFPARAN;}
"["                        {fprintf(yyout,"open square paranthesis : %s\n",yytext);yylval=strdup(yytext); return OSPARAN;}
"]"                        {fprintf(yyout,"close square paranthesis : %s\n",yytext);yylval=strdup(yytext); return CSPARAN;}
","                        {fprintf(yyout,"comma : %s\n",yytext);yylval=strdup(yytext); return COMMA;}
["][a-zA-Z]+["]            {fprintf(yyout,"string literal : %s\n",yytext); yylval=strdup(yytext);return LITERAL;}
['][a-zA-Z][']             {fprintf(yyout,"character literal : %s\n",yytext); yylval=strdup(yytext);return LITERAL;}
.                          {return yytext[0];}


%%
int yywrap(void){
    return 1;
}

