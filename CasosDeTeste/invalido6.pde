#include <stdio.h>

int a;

int foo() {
    a = 1;
    return 0;
}

int main() {
    foo();
    return 0;
}