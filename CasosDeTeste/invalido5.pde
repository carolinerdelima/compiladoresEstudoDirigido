/*
 * Invalid example 5 for the P‑de‑Prova grammar
 *
 * All variable declarations must precede any function declarations.  This
 * program declares a variable 'a' after the definition of the function
 * foo(), which should not be allowed by the grammar.
 */

#include <stdio.h>

void foo() {
}

int a; // variable declared after functions, should be invalid

int main() {
    a = 0;
    return 0;
}