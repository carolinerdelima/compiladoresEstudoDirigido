/*
 * Invalid example 3 for the P‑de‑Prova grammar
 *
 * Assignment statements in P‑de‑Prova are limited to expressions
 * containing at most two operands.  This example attempts to assign
 * a sum of three variables to 'sum', which should cause a syntax
 * error.
 */

#include <stdio.h>

int a, b, c, d, sum;

void compute() {
    a = 1;
    b = 2;
    c = 3;
    d = 4;
    sum = a + b + c; // invalid: more than two operands
}

int main() {
    compute();
    return 0;
}