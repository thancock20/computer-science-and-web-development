# Notes for YDKJS: Up & Going

<!-- toc orderedList:0 depthFrom:2 depthTo:6 -->

* [Code](#code)
  * [Code Comments](#code-comments)
  * [Statements](#statements)
  * [Expressions](#expressions)
  * [Executing a program](#executing-a-program)
* [Operators](#operators)
* [Values & Types](#values-types)
  * [Objects](#objects)
    * [Arrays](#arrays)
  * [Converting Between Types](#converting-between-types)
    * [Truthy & Falsy](#truthy-falsy)
    * [Equality](#equality)
    * [Inequality](#inequality)
* [Variables](#variables)
* [Blocks](#blocks)
* [Conditionals](#conditionals)
* [Loops](#loops)
* [Functions](#functions)
  * [Scope](#scope)
    * [Hoisting](#hoisting)
  * [Functions As Values](#functions-as-values)
    * [Immediately Invoked Function Expressions (IIFEs)](#immediately-invoked-function-expressions-iifes)
    * [Closure](#closure)
      * [Modules](#modules)
* [`this` Identifier](#this-identifier)

<!-- tocstop -->

## Code

### Code Comments

Comments should explain *why*, not *what*. They can optionally explain *how* if that's particularly confusing.

```js
// This is a single-line comment

/* But this is
      a multiline
          comment.
              */

var a = /* This is a comment in the middle of a line */ 42;

console.log(a); // 42
```

### Statements

**Statement**: A group of words, numbers, and operators that perform a specific task is a .

```js
a = b * 2;
```
Programs are just collections of statements, which together describe all the steps that it takes to perform the program's purpose.

### Expressions

**Expression**: Any reference to a variable or value, or a set of variable(s) and value(s) combined with operators.

```js
2         // literal value expression
b         // variable expression
b * 2     // arithmetic expression
a = b * 2 // assignment expression
```

**Expression statement**: A general expression that stands alone.

### Executing a program

There are two ways to translate code into commands that a computer can understand.

**Interpreting**: Translation of commands is done from top to bottom, line by line, every time the program is run.

**Compiling**: Translation is done ahead of time, so when the program runs later, what's running is actually the already compiled computer instructions ready to go.

The JavaScript engine *compiles* the program on the fly and then immediately runs the compiled code.

## Operators

**Operators** perform actions and variables and values.

Some of the most common operators in JavaScript:

* **Assignment**: `=` as in `a = 2`.
* **Math**: `+` (addition), `-` (subtraction), `*` (multiplication) and `/` (division), as in `a * 3`.
* **Compound Assignment**: `+=`, `-+`, `*=`, and `/=`. Combine Math and Assignment, as in `a += 2` `(same as a = a + 2)`.
* **Increment/Decrement**: `++` (increment), `--` (decrement), as in a++ (similar to `a = a + 1`).
* **Object Property Access**: `.` as in `console.log()`.
* **Equality**: `==` (loose-equals), `===` (strict-equals), `!=` (loose not-equals), `!==` (strict not-equals), as in   `a == b`.
* **Comparison**: `<` (less than), `>` (greater than), `<=` (less than or loose-equals), `>=` (greater than or loose-equals), as in ` a <= b`.
* **Logical**: `&&` (and), `||` (or), as in `a || b` that selects either `a` or `b`.

More details at MDN's [Expressions and Operators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Expressions_and_Operators).

## Values & Types

**Literals**: Values that are included directly in the source code

```js
"I am a string";
'I am also a string';

42; // a number

// booleans
true;
false;
```

`typeof` operator examines a value and tells what type it is:

```js
var a;
typeof a;          // "undefined"

a = "hello world";
typeof a;          // "string"

a = 42;
typeof a;          // "number"

a = true;
typeof a;          // "boolean"

a = null;
typeof a;          // "object" -- weird bug. Type is actually null

a = undefined;
typeof a;          // "undefined"

a = { b: "c" };
typeof a;          // "object"
```

### Objects

**Object**: A compound value where you can set properties (named locations) that each hold their own values of any type.

```js
var obj = {
  a: "hello world",
  b: 42,
  c: true
};

// dot notation
obj.a;        // "hello world"
obj.b;        // 42
obj.c;        // true

// bracket notation
// requires variable or string literal
obj["a"]      // "hello world"
obj["b"]      // 42
obj["c"]      // true

var b = "a";
obj[b];       // "hello world"
obj["b"]      // 42
```

#### Arrays

**Array**: An `object` that holds values (of any type) not particularly in named properties/keys, but rather in numerically indexed positions.

```js
var arr = [
  "hello world",
  42,
  true
];

arr[0];     // "hello world"
arr[1];     // 42
arr[3];     // true
arr.length; // 3

typeof arr; // "object"
```

### Converting Between Types

**Coercion**: Converting from one type to another.

**Explicit Coercion**: Using a built in function to convert types.

```js
var a = "42";
var b = Number(a); // "42" is explicitly coerced to 42 here

a;                 // "42"
b;                 // 42
```

**Implicit Coercion**: When JavaScript coerces values as part of an operation

```js
var a = "42";

var b = a * 1; // "42" is implicitly coerced to 42 here

a;             // "42"
b;             // 42
```

#### Truthy & Falsy

**Falsy**: Values which become `false` when coerced to a `boolean`:

* `""` (empty string)
* `0`, `-0`, `NaN` (invalid number)
* `null`, `undefined`
* `false`

**Truthy**: Values which become `true` when coerced to a `boolean`. This is any value not on the falsy list.

#### Equality

```js
var a = "42";
var b = 42;

a == b;     // true - allows coercion
a === b;    // false - is strict and does not allow coercion

a != b;     // false - allows coercion
a !== b;    // true - does not allow coercion
```

Simple rules of when to use which `==` (`!=`) vs `===` (`!==`):

* If either value in a comparison could be the `true` or `false` value, avoid `==` and use `===`.
* If either value in a comparison could be these specific values - `0`, `""`, or `[]` (empty array) - avoid `==` and use `===`.
* In *all* other cases, you're safe to use `==`. Not only is it safe, but in may cases it simplifies your code in a way that improves readability.

```js
var a = [1,2,3];
var b = [1,2,3];
var c = "1,2,3";

// Arrays coerce to strings as a comma separated list
a == c; // true
b == c; // true

// But comparing two objects (including arrays) checks the references, not the values
a == b; // false
```

#### Inequality

```js
3 < 4         // true - simple number comparison
"bar" < "foo" // true - alphabetic order
41 < "42"     // true - strings are coerced to numbers

// Strings that cannot be coerced to numbers become NaN
// NaN is not equal-to, greater-than, or less-than any other value
// including itself

var a = 42;
var b = "foo";

a < b;        // false
a > b;        // false
a == b;       // false

NaN == NaN;   // false
```

## Variables

**Variable**: A symbolic container that holds a value that can *vary* over time as needed. A variable must be a valid *identifier*.

**Identifier**: Must start with `a`--`z`, `A`--`Z`, `$`, of `_`. It can then contain any of those characters plus the numerals `0`--`9`.

**Dynamic Typing**: Variables can hold values of any *type* without any *type* enforcement.

```js
var amount = 99.99;

amount = amount * 2;

console.log(amount);  // 199.98

// convert `amount` to a string, and
// add "$" on the beginning
amount = "$" + String(amount);

console.log(amount);  // "$199.98"
```

## Blocks

**Block**: A series of statements that is grouped together. In JavaScript, a block is defined b y wrapping one or more statements inside a curly-brace pair `{ .. }`.

```js
var amount = 99.99;

// a general block
{
  amount = amount * 2;
  console.log(amount); // 199.98
}
```

Typically, blocks are attached to some control statement, such as `if`.

```js
var amount = 99.99;

// is amount big enough?
if (amount > 10) {     // <-- block attached to 'if'
  amount = amount * 2;
  console.log(amount); // 199.98
}
```

**Note**: Unlike most other statements, a block statement does not need a `;` to conclude it.

## Conditionals

**Conditional**: A decision point in a program

```js
const ACCESSORY_PRICE = 9.99;

var bank_balance = 302.13;
var amount = 99.99;

amount = amount * 2;

// can we afford the extra purchase?
if (amount < bank_balance) {
  console.log("I'll take the accessory!");
  amount = amount + ACCESSORY_PRICE;
}
// otherwise
else {
  console.log("No, thanks.");
}
```

```js
// series of `if...else...if` statements
if (a == 2) {
  // do something
} else if (a == 10) {
  // do another thing
} else if (a == 42) {
  // do yet another thing
} else {
  // fallback to here
}

// written as `switch` statement
switch (a) {
  case 2:
    // do something
    break; // keeps execution from continuing to next case
  case 10:
    // do another thing
    break;
  case 42:
    // do yet another thing
    break;
  default:
    // fallback to here
}
```

```js
// sometimes "fall through" is desired
switch (a) {
  case 2:
  case 10:
    // some cool stuff -- executes if a is 2 or 10
    break;
  case 42:
    // other stuff
    break;
  default:
    // fallback
}
```

```js
var a = 42;
var b;

// `if..else` statement
if (a > 41) {
  b = "hello";
} else {
  b = "world";
}

// written using ternary operator
b = (a > 41) ? "hello" : "world";
```


## Loops

**Loop**: Repeats a set of actions only while a certain condition holds.

```js
while (numOfCustomers > 0) { // won't run at all if false
  console.log("How may I help you?");

  // help the customer...

  numOfCustomers = numOfCustomers - 1;
}

// versus:

do { // will always run the 1st time, even is false
  console.log("How may I help you?");

  // help the customer...

  numOfCustomers = numOfCustomers - 1;
} while (numOfCustomers > 0); // condition evaluated after loop runs once
```

```js
var i = 0;

// a `while..true` loop would run forever, right?
while (true) {
  // stop the loop?
  if (( i <= 9) === false) {
    break;
  }

  console.log(i);
  i = i + 1;
}
// 0 1 2 3 4 5 6 7 8 9

// the above as a `for` loop
for (var i = 0; i <= 9; i++) {
  console.log(i);
}
// 0 1 2 3 4 5 6 7 8 9
```

## Functions

**Function**: A named section of code that can be called by name, and the code inside it will be run each time.

```js
function printAmount() {
  console.log(amount.toFixed(2));
}

var amount = 99.99;

printAmount(); // "99.99"

amount = amount * 2;

printAmount(); // "199.98"
```

**Arguments/Parameters**: Values passed into a function.

```js
const TAX_RATE = 0. 08;

function calculateFinalPurchase(amt) { // amt is the argument
  // calculate the new amount with the tax
  amt = amt + (amt * TAX_RATE);

  // return the new amount
  return amt;
}

var amount = 99.99;

amount = calculateFinalPurchase(amount);

console.log(amount.toFixed(2)); // "107.99"
```

### Scope

**Scope**: A collection of variables as well as the rules for how those variables are accessed by name.

```js
function one() {
  // this 'a' only belongs to the 'one()' function
  var a = 1;
  console.log(a);
}

function two() {
  // this 'a' only belongs to the 'two()' function
  var a = 2;
  console.log(a);
}

one(); // 1
two(); // 2
```

Lexical scope rules say that code in one scope can access variables of either that scope or any scope outside of it.

```js
function outer() {
  var a = 1;

  function inner() {
    var b = 2;

    // we can access both 'a' and 'b' here
    console.log(a + b); // 3
  }

  inner();

  // we can only access 'a' here
  console.log(a);       // 1
}

outer();
```

#### Hoisting

**Hoisting**: Whenever a `var` appears inside a scope, that declaration is taken to belong to the entire scope and accessible everywhere throughout.

```js
var a = 2;

// works because `foo()` declaration is hoisted
foo();             

function foo() {
   a = 3;

   console.log(a); // 3

// declaration is hoisted to the top of `foo()`
   var a;          
}

console.log(a);    // 2
```

```js
// Always formally declare variables

function foo() {
  a = 1; // `a` is not formally declared
}

foo();
a; // 1 -- oops, auto global variable :(
```

```js
// ES6 includes `let` keyword to scope variables to blocks (not just functions)

function foo() {
  var a = 1;

  if (a >= 1) {
    let b = 2;       // `b` belongs to `if` block only

    while (b < 5) {
      let c = b * 2; // `c` belongs to `while` block only
      b++;

      console.log(a + c);
    }
  }
}

foo();               // 5 7 9
```

### Functions As Values

```js
// A function itself is a value that can be assigned to variables, or passed to or returned from other functions

var foo = function () {}; // anonymous function expression

var x = function bar() {}; // named function expression
```

#### Immediately Invoked Function Expressions (IIFEs)

```js
// `foo` function expression
function foo() {
  console.log("Hello!")
}

// then `()` executes it
foo(); // "Hello!"

// `IIFE` function expression, then `()` executes it
(function IIFE() {
  console.log("Hello!");
})();
// "Hello!"
```

```js
// IIFEs can return values
var x = (function IIFE() {
  return 42;
})();

x; // 42
```

#### Closure

**Closure**: A way to remember and continue to access a function's scope even once the function has finished running.

```js
function makeAdder(x) {
  // parameter `x` is an inner variable

  // inner function `add()` uses `x`, so it has a closure over it
  function add(y) {
    return y + x;
  };

  return add;
}

// `plusOne` gets a reference to the inner `add(..)`
// function with closure over the `x` parameter of
// the outer `makeAdder(..)`
var plusOne = makeAdder(1);

// `plusTen` gets a reference to the inner `add(..)`
// function with closure over the `x` parameter of
// the outer `makeAdder(..)`
var plusTen = makeAdder(10);

plusOne(3);  // 4 <-- 1+3
plusOne(41); // 42 <-- 1+41

plusTen(13); // 23 <-- 10+13
```

##### Modules

**Modules**: Use closure to let you define private implementation details that are hidden from the outside world, as well as a public API that *is* accessible from the outside.

```js
function User() {
  var username, password;

  function doLogin(user,pw) {
    username = user;
    password = pw;

    // do the rest of the login work
  }

  var publicAPI = {
    login: doLogin
  };

  return publicAPI;
}

// create a `User` module instance
var fred = User();

fred.login( "fred", "12battery34!" );
```

## `this` Identifier

```js
// `this` in a function points to an object
// not to the function itself

function foo() {
  console.log(this.bar);
}

var bar = "global";

var obj1 = {
  bar: "obj1",
  foo: foo
};

var obj2 = {
  bar: "obj2"
};

foo();          // "global"
obj1.foo();     // "obj1"
foo.call(obj2); // "obj2"
new foo();      // undefined
```
