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