/*
 * Valid example 1 for the P‑de‑Prova grammar
 *
 * This program demonstrates the basic structure of a valid program in the
 * P‑de‑Prova language: multiple directives, array declarations using a
 * constant, a simple function with a for loop, and a main function with
 * assignments.  The size of the array is defined via a constant (N) and
 * the program uses a loop to initialize the array and then performs a
 * series of arithmetic assignments in main.
 */

#include <stdio.h>
#define N 10

float notas[N];
int a, b, c, i;

void initialize() {
    for (i = 0; i < N; i++) {
        notas[i] = 1;
    }
}

int main() {
    initialize();
    a = 5;
    b = a + 3;
    c = b * 2;
    return 0;
}