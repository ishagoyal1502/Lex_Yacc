%{
    #include<stdio.h>
    #include<string.h>
    #define YYSTYPE char*
    int yylex();
void yyerror (const char *str)
{
    fprintf(stdout,"error: %s\n",str);
}
int yywrap()
{
    return 1;
}
%}

%token WHILE_KEY 
%token IF_KEY 
%token ELSE_KEY 
%token RETURN
%token TYPE 
%token RELATIONAL_OPERATOR 
%token ASSIGN 
%token SEMI_COLON 
%token ID 
%token LITERAL 
%token OPARAN 
%token CPARAN 
%token COMMA 
%token OFPARAN 
%token CFPARAN
%token OSPARAN 
%token CSPARAN
%token PLUS
%token SUB
%token MUL
%token DIV

%%

program: %empty
        |program TYPE name OPARAN arg_list CPARAN OFPARAN statements CFPARAN  

name: ID {fprintf(stdout,"function identifier : %s\n",$1);}

arg_list: conti TYPE ID      {fprintf(stdout,"function arg : %s\n",$3);}
         |%empty              

conti: conti TYPE ID COMMA    {fprintf(stdout,"function arg : %s\n",$3);}
     |%empty                   

statements: %empty      {fprintf(stdout,"body\n");}
            |statements statement SEMI_COLON 
            |statements block 
            |statements return

return: RETURN SEMI_COLON        {fprintf(stdout,"RET\n\n");}
       |RETURN expr SEMI_COLON   {fprintf(stdout,"RET\n\n");}

statement: statem    {fprintf(stdout,"\n");}
          |func      {fprintf(stdout,"\n");}

func: ID ASSIGN name OPARAN args CPARAN    {fprintf(stdout,"var: %s   :%s  function assignment",$1,$2);}
    |name OPARAN args CPARAN               

args: con expr           {fprintf(stdout,"function argument\n");}
     |con relational     {fprintf(stdout,"function argument\n");}
     |%empty

con: con expr COMMA         {fprintf(stdout,"function argument\n");}
    |con relational COMMA   {fprintf(stdout,"function argument\n");}
    |%empty

block: while     {fprintf(stdout,"while block body end \n");}
      |if_else   {fprintf(stdout,"if block body end\n");}

statem: declaration
        |expression

declaration:  TYPE ID ASSIGN expr   {fprintf(stdout,"local var: %s  :%s  ",$2,$3);}
            | TYPE ID                {fprintf(stdout,"local var: %s  ",$2);}

var: ID                                {fprintf(stdout,"var: %s  ",$1);}
    |LITERAL                            {fprintf(stdout,"const: %s  ",$1);}
    |ID OSPARAN expr CSPARAN            {fprintf(stdout,"var: %s%s%s ",$1,$2,$4);}

expr:  expri
       |expr PLUS expri         {fprintf(stdout,"%s  ",$2);}
       |expr SUB expri          {fprintf(stdout,"%s  ",$2);}

expri: exprj                   
      |expri MUL exprj           {fprintf(stdout,"%s  ",$2);}
      |expri DIV exprj           {fprintf(stdout,"%s  ",$2);}

exprj: var
      |OPARAN expr CPARAN     {fprintf(stdout,"%s%s   ",$1,$3);}


expression: ID ASSIGN expr         {fprintf(stdout,"var: %s , :%s",$1,$2);}
           |ID OSPARAN expr CSPARAN ASSIGN expr   {fprintf(stdout,"var: %s%s%s , :%s",$1,$2,$4,$5);}

while: WHILE_KEY OPARAN expwi CPARAN OFPARAN statements CFPARAN

if_else: IF_KEY OPARAN expwi CPARAN OFPARAN statements CFPARAN
        |IF_KEY OPARAN expwi CPARAN OFPARAN statements CFPARAN 
         ELSE_KEY OFPARAN statements CFPARAN

expwi: expression    {fprintf(stdout,"block ");}
     |var            {fprintf(stdout,"block ");}
     |relational     {fprintf(stdout,"block ");}

relational: ID RELATIONAL_OPERATOR expr                          {fprintf(stdout,"var: %s  :%s  ",$1,$2);}
           |ID OSPARAN expr CSPARAN RELATIONAL_OPERATOR expr      {fprintf(stdout,"var: %s%s%s :%s  ",$1,$2,$4,$5);}

%%
int main(int argc, char* argv[])
{
    if(argc==1 || argc>2)
    {
        printf("error: enter the write command");
    }
    else if(argc==2)
    {
        extern FILE *yyin,*yyout,*stdout;
        yyin=fopen(argv[1],"r");
        yyout=fopen("lexer.txt","w");
        stdout=fopen("parser.txt","w");
        yyparse();
    }
    
    return 0;
}
