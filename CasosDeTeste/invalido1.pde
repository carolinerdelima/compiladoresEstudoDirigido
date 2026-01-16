#include <stdio.h>
#define N 5

float arr[N];
int i, sum;

void func() {
    for (i = 0; i < N; i++)
        arr[i] = i;
}

int main() {
    func();
    sum = 0;
    return 0;
}