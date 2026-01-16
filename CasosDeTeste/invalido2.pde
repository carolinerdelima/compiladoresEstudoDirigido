/*
 * Invalid example 2 for the P‑de‑Prova grammar
 *
 * Functions in P‑de‑Prova must always be declared as void and take
 * no parameters.  This example defines a function with an integer
 * parameter, which should be rejected by the parser.
 */

#include <stdio.h>

int x;

void func(int param) {
    x = param;
}

int main() {
    func();
    return 0;
}