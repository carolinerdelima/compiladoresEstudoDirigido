#include <stdio.h>

int x;

void func(int param) {
    x = param;
}

int main() {
    func();
    return 0;
}