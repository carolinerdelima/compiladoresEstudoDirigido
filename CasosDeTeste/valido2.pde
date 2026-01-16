/*
 * Valid example 2 for the P‑de‑Prova grammar
 *
 * This program includes multiple #include directives and multiple
 * constants (#define).  It declares an array using one of the
 * constants and some scalar variables.  Two helper functions are
 * defined: one to fill the array and another to compute a running sum.
 * The main function calls both helpers and then executes a for loop
 * with a compound condition (j < LIMIT && j < SIZE) and a compound
 * increment (j = j + 2).  All assignments use at most two operands.
 */

#include <stdio.h>
#include <stdlib.h>
#define SIZE 5
#define LIMIT 10

float array[SIZE];
int i, j, sum;

void fill() {
    for (i = 0; i < SIZE; i++) {
        array[i] = i;
    }
}

void compute() {
    for (i = 0; i < SIZE; i++) {
        sum = sum + array[i];
    }
}

int main() {
    fill();
    compute();
    for (j = 0; j < LIMIT && j < SIZE; j = j + 2) {
        sum = sum + j;
    }
    return 1;
}