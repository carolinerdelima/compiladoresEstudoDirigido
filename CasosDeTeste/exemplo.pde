#include <stdio.h>
#define N 20

float notas[N];
int a, b, i;

void limpeza() {
    for (i = 0; i < N; i++) {
        notas[i] = 0;
    }
}

int main() {
    limpeza();
    a = 10;
    b = a * 2;
    return 1;
}
