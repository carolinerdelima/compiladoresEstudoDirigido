/*
 * Invalid example 4 for the P‑de‑Prova grammar
 *
 * Each variable declaration must be terminated by a semicolon.  This
 * example omits the semicolon after the declaration of 'a', which
 * should trigger a syntax error during parsing.
 */

#include <stdio.h>

int a

int main() {
    a = 0;
    return 0;
}