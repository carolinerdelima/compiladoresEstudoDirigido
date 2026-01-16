# Analisador P‑de‑Prova

Este diretório contém um analisador léxico Flex (`lexer.l`) e uma gramática Bison (`parser.y`) que juntos reconhecem um subconjunto da linguagem “P‑de‑Prova”, semelhante à linguagem C. A gramática aceita programas com as seguintes características:

* **Diretivas de inclusão**: qualquer número de diretivas `#include`. Cada linha de inclusão começa com `#include` e pode especificar um cabeçalho entre sinais de menor/maior (`<…>`) ou entre aspas duplas (`"…"`). O nome do cabeçalho não é utilizado pela gramática.
* **Definições de constantes**: qualquer número de definições `#define`. Uma definição consiste em `#define`, um identificador e uma constante inteira na mesma linha.
* **Declarações de variáveis**: qualquer número de declarações dos tipos `int`, `float` ou `char`. Variáveis podem ser declaradas como vetores usando um tamanho inteiro constante (por exemplo, `float notas[N];`). Múltiplas variáveis podem ser declaradas em uma mesma instrução, separadas por vírgulas.
* **Definições de funções**: qualquer número de funções. As funções são sempre declaradas com `void`, não recebem parâmetros e são seguidas por um bloco de instruções delimitado por `{` e `}`. Dentro de uma função são permitidos:
  * atribuições do tipo `var = expr;`, onde `expr` contém no máximo um operador binário (dois operandos);
  * chamadas de função sem argumentos (por exemplo, `limpeza();`);
  * instruções `return` retornando uma expressão (mesmo com a função declarada `void`);
  * laços `for` da forma `for (init; condição; incremento) { … }`, em que as partes condição e incremento são opcionais;
  * blocos de instruções aninhados.
* **Função principal**: exatamente uma função `int main()`. Dentro de `main` apenas atribuições, chamadas de função e laços `for` são permitidos.

Quando a análise sintática é bem sucedida o programa imprime **“Programa aceito.”**. Qualquer erro de sintaxe é reportado pela função `yyerror()`.

## Compilação

Para compilar o analisador em um sistema com Flex e Bison instalados, execute os seguintes comandos a partir deste diretório:

```sh
bison -d parser.y -o parser.tab.c
flex -o lexer.c lexer.l
gcc parser.tab.c lexer.c -o pdeprova -lfl
```

Isso gerará um executável chamado `pdeprova`. Para testar o analisador com um arquivo de código fonte, execute:

```sh
./pdeprova < arquivo.pde
```

Se o programa de entrada estiver conforme a gramática, o analisador imprimirá `Programa aceito.`; caso contrário, emitirá um erro de sintaxe.

## Casos de teste

No diretório `CasosDeTeste` existem arquivos de exemplo para validar a implementação:

| Arquivo | Tipo | Descrição |
| --- | --- | --- |
| `exemplo.pde` | válido | Exemplo simples com declaração de vetor e função de limpeza. |
| `valido1.pde` | válido | Demonstra diretivas, declaração de vetor com constante e atribuições básicas. |
| `valido2.pde` | válido | Utiliza múltiplos `#include`, define constantes, declara vetor e duas funções auxiliares, além de laço `for` com condição e incremento compostos. |
| `valido3.pde` | válido | Possui laços `for` aninhados em função e condição composta em `main`. |
| `invalido1.pde` | inválido | Laço `for` sem bloco delimitado por chaves -> deve produzir erro. |
| `invalido2.pde` | inválido | Função `void` com parâmetro -> não permitido. |
| `invalido3.pde` | inválido | Atribuição com mais de dois operandos -> não permitido. |
| `invalido4.pde` | inválido | Falta de ponto e vírgula após declaração de variável. |
| `invalido5.pde` | inválido | Declaração de variável após definição de função. |
| `invalido6.pde` | inválido | Função não‑`void` retornando valor. |

Para executar um teste, redirecione o conteúdo de um desses arquivos para a entrada padrão do programa. Por exemplo:

```sh
./pdeprova < CasosDeTeste/valido2.pde
```

O analisador indicará se o código é aceito ou se apresenta erro de sintaxe.