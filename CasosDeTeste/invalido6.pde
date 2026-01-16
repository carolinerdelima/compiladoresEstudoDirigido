/*
 * Invalid example 6 for the P‑de‑Prova grammar
 *
 * Only void functions without parameters are permitted.  This example
 * defines a function 'foo' that returns an int and returns a value
 * inside its body, which is not allowed by the grammar.
 */

#include <stdio.h>

int a;

int foo() { // invalid: non-void function
    a = 1;
    return 0;
}

int main() {
    foo();
    return 0;
}