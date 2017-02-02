# Notes for YDKJS: Scope & Closures


<!-- toc orderedList:0 depthFrom:2 depthTo:6 -->

* [Compiler Theory](#compiler-theory)
* [Understanding Scope](#understanding-scope)
  * [Nested Scope](#nested-scope)
  * [Errors](#errors)
  * [Collision Avoidance](#collision-avoidance)
* [Function and Block Scope](#function-and-block-scope)
* [Hoisting](#hoisting)
* [Closure](#closure)
* [Modules](#modules)

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

**Scope**: The set of rules that determines where and how a variable can be looked-up.

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
function foo(a) {     // `a` is in the scope of `foo`
  console.log(a + b); // `b` will be looked for in the next scope up
}

var b = 2;            // `b` is in the global scope

foo(2);               // 4
```

### Errors

Unfulfilled RHS references result in `ReferenceError`s being thrown. Unfulfilled LHS references result in an automatic, implicitly-created global of that name (if not in "Strict Mode"), or a `ReferenceError` (if in "Strict Mode").

### Collision Avoidance

 Hiding variables and functions inside a scope is good to avoid unintended collision between two different identifiers with the same name but different intended usages.

```js
function foo() {
  function bar(a) {
    i = 3; // no `var`, so is changing the `i` in the enclosing scopes for-loop
    console.log(a + i);
  }

  for (var i=0; i<10; i++) {
    bar(i * 2); // oops, infinite loop ahead!
  }
}

foo();
```

## Function and Block Scope

```js
// `var`: Scopes a variable to the enclosing function, or global object.
function foo(bar) {

  if (bar) {
    var baz = 2;
    console.log(baz); // 2
  }

  console.log(baz); // 2  
}

foo(true);

console.log(baz); // ReferenceError
```

```js
// `let`: Scopes a variable to the enclosing block -- { .. } pair
function foo(bar) {

  if (bar) {
    let baz = 2;
    console.log(baz); // 2
  }

  console.log(baz); // ReferenceError
}

foo(true);

console.log(baz); // ReferenceError
```

```js
// `const`: Scopes a variable to the enclosing block, and fixes the value
function foo(bar) {

  if (bar) {
    const baz = 2;
    console.log(baz); // 2

    baz = 3; // error!
  }

  console.log(baz); //ReferenceError
}

foo(true);

console.log(baz); // ReferenceError
```

## Hoisting

**Hoisting**: Declarations of functions and variables are moved to the top of their scope and compilation, before execution. Assignments, even assignments of function expressions, are *not* hoisted.

```js
foo();

function foo() {
  console.log(a); // undefined
  var a = 2;
}

// above code will be interpreted like this
function foo() {
  var a;
  console.log(a); // undefined
  a = 2;
}

foo();
```

```js
foo(); // TypeError
bar(); // ReferenceError

var foo = function bar() {
  // ...
};

// above code will be interpreted like this
var foo;

foo(); // TypeError
bar(); // ReferenceError

foo = function() {
  var bar = ...self...
  // ...
};
```

## Closure

**Closure**: When a function is able to remember and access its lexical scope even when that function is executing outside its lexical scope.

```js
function foo() {
  var a = 2; // `a` is scoped to function `foo`, so can't be used outside of it

  function bar() {
    console.log(a); // `a` is used in function `bar`, so it is remembered
  }

  return bar;
}

var baz = foo(); // `baz` is now a reference to the function `bar`

baz(); // 2 -- `a` is remembered even outside of `foo`
```

```js
// This does not work as expected because of closure
// `i` will be 6 by the time the first `setTimeout` runs
for (var i=1; i<=5; i++) {
  setTimeout(function timer() {
    console.log(i);
  }, i*1000);
}

// This works as expected
for (var i=1; i<=5; i++) {
  (function() {
    var j = i; // `j` gets a copy of `i` at each iteration
    setTimeout(function timer() {
      console.log(j);
    }, j*1000);
  })();
}

// This also works, because `let` creates a new value at each iteration
for (let i=1; i<=5; i++) {
  setTimeout(function timer() {
    console.log(i);
  }, i*1000);
}
```

## Modules

There are 2 requirements for the module pattern:
1. There must be an outer enclosing function, and it must be invoked at least once (each time creates a new module instance).
2. The enclosing function must return back at least one inner function, so that this inner function has closure over the private scope, and can access and/or modify that private state.

```js
// example module
function CoolModule() {
  var something = "cool";
  var another = [1, 2, 3];

  function doSomething() {
    console.log( something );
  }

  function doAnother() {
    console.log( another.join( " ! ") );
  }

  // This object is the public API
  return {
    doSomething: doSomething,
    doAnother: doAnother
  };
}

var foo = CoolModule();

foo.doSomething(); // cool
foo.doAnother();   // 1 ! 2 ! 3
```

```js
// example "singleton" module
var foo = (function CoolModule() {
  var something = "cool";
  var another = [1, 2, 3];

  function doSomething() {
    console.log( something );
  }

  function doAnother() {
    console.log( another.join( " ! ") );
  }

  return {
    doSomething: doSomething,
    doAnother: doAnother
  };
})();

foo.doSomething(); // cool
foo.doAnother();   // 1 ! 2 ! 3
```
