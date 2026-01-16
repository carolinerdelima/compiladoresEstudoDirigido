/*
 * Analisador léxico pra a linguagem “P‑de‑Prova”.
 *
 * Este scanner reconhece palavras‑chave, identificadores, literais
 * numéricos, operadores e sinais de pontuação.  Também trata
 * diretivas de pré‑processamento como #include e #define.  Espaços em
 * branco e comentários no estilo C/C++ são ignorados.  Os tokens
 * reconhecidos são repassados ao analisador sintático definido em
 * parser.y através da função yylex().
 */

%{
#include "parser.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

%}

%option noyywrap

%%

"#include".*               { return INCLUDE; }
"#define"                 { return DEFINE; }

 /* Palavras‑chave */
"void"                     { return T_VOID; }
"int"                      { return T_INT; }
"float"                    { return T_FLOAT; }
"char"                     { return T_CHAR; }
"for"                      { return T_FOR; }
"return"                   { return T_RETURN; }
"main"                     { return T_MAIN; }

 /* Operadores com dois caracteres.  A ordem importa: operadores mais longos primeiro. */
"&&"                      { return AND_OP; }
"||"                      { return OR_OP; }
"=="                      { return EQ_OP; }
"!="                      { return NE_OP; }
"<="                      { return LE_OP; }
">="                      { return GE_OP; }
"++"                      { return INC_OP; }
"--"                      { return DEC_OP; }

 /* Literais numéricos (constantes inteiras). */
[0-9]+                      { yylval.intVal = atoi(yytext); return NUMBER; }

 /* Identificadores.  Iniciam por uma letra ou sublinhado e são
 * seguidos por letras, dígitos ou sublinhados. */
[A-Za-z_][A-Za-z0-9_]*      { yylval.strVal = strdup(yytext); return IDENTIFIER; }

 /* Tokens de um único caractere.  Retornam o próprio literal. */
"["                       { return '['; }
"]"                       { return ']'; }
"("                       { return '('; }
")"                       { return ')'; }
"{"                       { return '{'; }
"}"                       { return '}'; }
";"                       { return ';'; }
","                       { return ','; }
"+"                       { return '+'; }
"-"                       { return '-'; }
"*"                       { return '*'; }
"/"                       { return '/'; }
"<"                       { return '<'; }
">"                       { return '>'; }
"="                       { return '='; }

 /* Ignora espaços em branco */
[ \t\r\n]+                { /* ignore */ }

 /* Ignora comentários de linha (estilo C++) */
"//".*                  { /* ignore */ }

 /* Ignora comentários de múltiplas linhas (estilo C) */
"/*"([^*]|[*][^/])*"*/"  { /* ignore */ }

 /* Ignora qualquer caractere não reconhecido.  Os erros de sintaxe
 * serão reportados pelo analisador quando encontrar tokens
 * inesperados. */
.                           { /* ignore */ }

%%