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