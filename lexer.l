/*
 * Flex scanner for the simplified “P‑de‑Prova” language.
 *
 * The scanner recognises keywords, identifiers, numeric literals,
 * operators and punctuation.  It also handles preprocessor
 * directives such as #include and #define.  White space and C‑style
 * comments are skipped.  Tokens are passed to the parser defined in
 * parser.y via yylex().
 */

%{
#include "parser.tab.h"    /* Bison interface (token definitions) */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* We rely on the default yylex() signature provided by Flex. */
%}

%option noyywrap

%%

 /* Preprocessor directives.  Match '#include' followed by the remainder
 * of the line (dot does not match newline in flex) so that the header
 * specification does not emit stray tokens.  '#define' is returned on
 * its own; the identifier and value are handled by other rules. */
"#include".*               { return INCLUDE; }
"#define"                 { return DEFINE; }

 /* Keywords */
"void"                     { return T_VOID; }
"int"                      { return T_INT; }
"float"                    { return T_FLOAT; }
"char"                     { return T_CHAR; }
"for"                      { return T_FOR; }
"return"                   { return T_RETURN; }
"main"                     { return T_MAIN; }

 /* Multi-character operators.  Order matters: match longer tokens first. */
"&&"                      { return AND_OP; }
"||"                      { return OR_OP; }
"=="                      { return EQ_OP; }
"!="                      { return NE_OP; }
"<="                      { return LE_OP; }
">="                      { return GE_OP; }
"++"                      { return INC_OP; }
"--"                      { return DEC_OP; }

 /* Numeric literals (integer constants). */
[0-9]+                      { yylval.intVal = atoi(yytext); return NUMBER; }

 /* Identifiers.  Start with a letter or underscore followed by letters,
 * digits or underscores. */
[A-Za-z_][A-Za-z0-9_]*      { yylval.strVal = strdup(yytext); return IDENTIFIER; }

 /* Single-character tokens.  Return the literal character itself. */
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

 /* Skip whitespace */
[ \t\r\n]+                { /* ignore */ }

 /* Skip C++ style single-line comments */
"//".*                  { /* ignore */ }

 /* Skip C style multi-line comments */
"/*"([^*]|[*][^/])*"*/"  { /* ignore */ }

 /* Ignore any unrecognised character.  Syntax errors will be reported
 * by the parser when it sees unexpected tokens. */
.                           { /* ignore */ }

%%