/*
 * Gramática Bison para a linguagem “P‑de‑Prova”.
 *
 * Esta gramática aceita programas com a seguinte estrutura:
 *   • Qualquer quantidade de diretivas de inclusão (por exemplo, #include <stdio.h>)
 *   • Qualquer quantidade de definições de constantes (por exemplo, #define N 20)
 *   • Qualquer quantidade de declarações de variáveis.  As variáveis podem ser
 *     simples ou vetores e podem ser dos tipos int, float ou char.  Vetores
 *     devem possuir um tamanho inteiro constante.
 *   • Qualquer quantidade de declarações de funções.  As funções são sempre
 *     declaradas com a palavra‑chave “void”, não têm parâmetros e contêm um
 *     bloco de instruções.  Dentro de uma função são permitidas atribuições,
 *     chamadas de função, instruções de retorno, blocos aninhados e laços
 *     for.
 *   • Uma única função principal da forma “int main() { … }”.  Dentro de main
 *     apenas são permitidas atribuições, chamadas de função e laços for.
 *   • Atribuições suportam expressões aritméticas simples com no máximo um
 *     operador binário (dois operandos).  Cada operando pode ser uma
 *     constante inteira ou uma variável (opcionalmente indexando um vetor).
 *   • Laços for seguem a sintaxe do C “for (init; condição; incremento) { … }”,
 *     onde o incremento pode ser uma atribuição simples ou um operador de
 *     incremento/decremento (por exemplo, i++).  A condição do laço pode
 *     consistir de uma ou duas expressões relacionais unidas por operadores
 *     lógicos && ou ||.
 *
 * Se a análise for bem-sucedida, o programa imprime “Programa aceito.” no
 * stdout; erros de sintaxe são reportados pela função yyerror().
 */

%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);

%}

%union {
    int intVal;      /* integer constants */
    char *strVal;    /* identifiers */
}

%token <intVal> NUMBER
%token <strVal> IDENTIFIER

%token T_VOID T_INT T_FLOAT T_CHAR

%token T_FOR T_RETURN T_MAIN

%token DEFINE INCLUDE

%token AND_OP OR_OP
%token EQ_OP NE_OP LE_OP GE_OP
%token INC_OP DEC_OP

%left OR_OP
%left AND_OP
%nonassoc EQ_OP NE_OP
%nonassoc '<' '>' LE_OP GE_OP
%left '+' '-'
%left '*' '/'

%expect 1

%%

program
    : includes defines declarations functions main_func
    ;

includes
    : /* empty */
    | includes include_stmt
    ;

include_stmt
    : INCLUDE
    ;

/* Um token define é seguido por um identificador e um literal inteiro. */
defines
    : /* empty */
    | defines define_stmt
    ;

define_stmt
    : DEFINE IDENTIFIER NUMBER
    ;

/* Cada declaração começa com um tipo e contém uma lista de variáveis separadas por vírgulas.
 * Declarações de vetores indicam um tamanho constante. */
declarations
    : /* empty */
    | declarations declaration
    ;

declaration
    : type varlist ';'
    ;

type
    : T_INT
    | T_FLOAT
    | T_CHAR
    ;

varlist
    : varlist ',' var_decl
    | var_decl
    ;

var_decl
    : IDENTIFIER
    | IDENTIFIER '[' NUMBER ']'
    /* Permit array sizes to be defined by constants (identifiers) as well */
    | IDENTIFIER '[' IDENTIFIER ']'
    ;

functions
    : /* empty */
    | functions function
    ;

function
    : T_VOID IDENTIFIER '(' ')' block
    ;

main_func
    : T_INT T_MAIN '(' ')' block
    ;

block
    : '{' statements '}'
    ;

/* Zero ou mais instruções dentro de um bloco. */
statements
    : /* empty */
    | statements statement
    ;

statement
    : assignment ';'
    | function_call ';'
    | return_stmt ';'
    | for_loop
    | block
    ;

/* Atribuição */
assignment
    : var '=' expr
    ;

/* São suportados identificadores simples e indexação de vetores. */
var
    : IDENTIFIER
    | IDENTIFIER '[' expr ']'
    ;

function_call
    : IDENTIFIER '(' ')'
    ;

return_stmt
    : T_RETURN expr
    ;

for_loop
    : T_FOR '(' assignment ';' condition_opt ';' increment_opt ')' block
    ;

/* Condição opcional. Uma condição ausente é tratada como verdadeira. */
condition_opt
    : /* empty */
    | condition
    ;

/* Duas expressões relacionais podem ser combinadas usando os operadores lógicos && ou ||. */
condition
    : expr rel_op expr
    | condition logic_op expr rel_op expr
    ;

rel_op
    : '<'
    | '>'
    | LE_OP
    | GE_OP
    | EQ_OP
    | NE_OP
    ;

logic_op
    : AND_OP
    | OR_OP
    ;

/* O incremento pode ser uma atribuição completa
 * ou uma variável seguida de um operador de incremento/decremento. */
increment_opt
    : /* empty */
    | increment
    ;

increment
    : assignment
    | var INC_OP
    | var DEC_OP
    ;


/* Expressões aritméticas. */
expr
    : term
    | term '+' term
    | term '-' term
    | term '*' term
    | term '/' term
    ;

term
    : NUMBER
    | var
    ;

%%

/* Em caso de erros de sintaxe. */
void yyerror(const char *s) {
    fprintf(stderr, "Erro de sintaxe: %s\n", s);
}

/* yyparse() retorna 0 em caso de sucesso e diferente de zero em caso de falha. */
int main(void) {
    if (yyparse() == 0) {
        printf("Programa aceito.\n");
    }
    return 0;
}