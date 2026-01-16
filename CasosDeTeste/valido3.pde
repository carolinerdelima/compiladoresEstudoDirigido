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