# Notes for YDKJS: Scope & Closures


<!-- toc orderedList:0 depthFrom:2 depthTo:6 -->

* [Compiler Theory](#compiler-theory)
* [Understanding Scope](#understanding-scope)
  * [Nested Scope](#nested-scope)
  * [Errors](#errors)

<!-- tocstop -->

## Compiler Theory

The JavaScript engine compiles code before it executes. Usually *right* before.

3 Steps of compilation:

1. **Tokenizing/Lexing**: Breaking up a string of characters into meaningful chunks, called tokens.
2. **Parsing**: Taking a stream of tokens and turning it into a tree of nested elements, which collectively represent the grammatical structure of the program. This tree is call an "AST" (**A**bstract **S**yntax **T**ree).
3. **Code-Generation**: The process of taking an AST and turning it into executable machine code.

Statements like `var a = 2;` are split into two separate steps:
1. During compilation `var a` declares the variable in that scope.
2. Later, during execution, `a=2` looks up the variable and assigns to it if found.

## Understanding Scope

**Scope**: The set of rules that determines where and  how a variable can be looked-up.

**Lexical Scope**: Scope is defined by author-time decisions of where functions are declared. The lexing phase of complilation is able to know where and how all identifiers are declared, and thus predict how they will be looked-up during execution.

**LHS**: Left-hand-side reference. A look-up for the purpose of assigning to the variable.

**RHS**: Right-hand-side reference. A look-up for the purpose of retrieving the variable's value.

```js
a = 2;            // LHS reference to `a`

console.log(a);   // RHS reference to `a`

function foo(a) { // RHS reference to `a`
  console.log(a); // RHS reference to `a`
}

foo(2);           // LHS reference to `a` when 2 is passed to it
```

### Nested Scope
For both LHS and RHS references, if the engine doesn't find the variable in the current scope, it looks up the variable in the next outermost scope, and continues until it reaches the global scope

```js
function foo(a) { // `a` is in the scope of `foo`
  console.log(a + b); // `b` will be looked for in the next scope up
}

var b = 2; // `b` is in the global scope

foo(2); // 4
```

### Errors

Unfulfilled RHS references result in `ReferenceError`s being thrown. Unfulfilled LHS references result in an automatic, implicitly-created global of that name (if not in "Strict Mode"), or a `ReferenceError` (if in "Strict Mode").
