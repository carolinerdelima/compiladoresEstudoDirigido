/*
 * Valid example 3 for the P‑de‑Prova grammar
 *
 * This example shows a nested for loop inside a function and a
 * compound condition in the main function's loop.  Two constants (M
 * and N) define the bounds of the loops.  The variable 'value' is
 * updated inside the nested loops and again in main.  The grammar
 * allows nested for loops and compound conditions in the for loop.
 */

#include <stdio.h>
#define M 3
#define N 4

float matrix[M];
int i, j, k, value;

void process() {
    for (i = 0; i < M; i++) {
        for (j = 0; j < N; j = j + 1) {
            value = i + j;
        }
    }
}

int main() {
    process();
    for (k = 0; k < M && k < N; k++) {
        value = value + k;
    }
    return 1;
}