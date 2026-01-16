# P‑de‑Prova parser

This directory contains a Flex scanner (`lexer.l`) and a Bison grammar
(`parser.y`) that together recognise a subset of the C‑like “P‑de‑Prova”
language described in the assignment.  The grammar accepts programs
with the following features:

* Any number of `#include` directives.  Each include line begins with
  `#include` and may specify a header using angle brackets (`<…>`) or
  double quotes (`"…"`).  The header name itself is ignored by the
  grammar.
* Any number of `#define` constant definitions.  A definition consists
  of `#define`, an identifier and an integer constant on the same
  line.
* Any number of variable declarations of type `int`, `float` or
  `char`.  Variables may be declared as arrays using a constant
  integer size (e.g. `float notas[N];`).  Multiple variables can be
  declared in one statement separated by commas.
* Any number of function definitions.  Functions are always declared
  with `void`, take no parameters and are followed by a block of
  statements delimited by `{` and `}`.  Within a function the
  allowed statements are:
  * variable assignments of the form `var = expr;` where `expr`
    contains at most one binary operator (two operands)
  * function calls with no arguments (e.g. `limpeza();`)
  * `return` statements returning an expression (even though the
    function is declared `void`)
  * `for` loops of the form `for (init; condition; increment) { … }`
    where the condition and increment parts are optional
  * nested blocks of statements
* A single `int main()` function.  Inside `main` only assignments,
  function calls and `for` loops are permitted.

On successful parsing the parser prints **“Programa aceito.”**.  Any
syntax error is reported via `yyerror()`.

## Building

To build the parser on a system with Flex and Bison installed, run
the following commands from within this directory:

```sh
bison -d parser.y -o parser.tab.c
flex -o lexer.c lexer.l
gcc parser.tab.c lexer.c -o pdeprova -lfl
```

This produces an executable named `pdeprova`.  To test the parser
with a source file, run:

```sh
./pdeprova < source.c
```

If the input program conforms to the grammar, the parser prints
`Programa aceito.`; otherwise it emits a syntax error.