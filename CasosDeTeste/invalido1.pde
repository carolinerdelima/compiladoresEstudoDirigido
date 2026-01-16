/*
 * Invalid example 1 for the P‑de‑Prova grammar
 *
 * This program defines a for loop inside a function without enclosing
 * the loop body in braces.  The grammar requires that the body of a
 * for loop be contained within curly braces, so this code should
 * produce a syntax error.
 */

#include <stdio.h>
#define N 5

float arr[N];
int i, sum;

void func() {
    for (i = 0; i < N; i++)
        arr[i] = i; // missing braces around the loop body
}

int main() {
    func();
    sum = 0;
    return 0;
}