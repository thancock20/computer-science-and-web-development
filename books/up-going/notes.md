<!-- MDTOC maxdepth:6 firsth1:1 numbering:0 flatten:0 bullets:1 updateOnSave:1 -->

- [Chapter 1: Into Programming](#chapter-1-into-programming)   
   - [Code](#code)   
      - [Statements](#statements)   
      - [Expressions](#expressions)   
      - [Executing a program](#executing-a-program)   
   - [Operators](#operators)   
   - [Values & Types](#values-types)   
      - [Converting Between Types](#converting-between-types)   
   - [Code Comments](#code-comments)   
   - [Variables](#variables)   
   - [Blocks](#blocks)   
   - [Conditionals](#conditionals)   
   - [Loops](#loops)   
   - [Functions](#functions)   
      - [Scope](#scope)   

<!-- /MDTOC -->

# Chapter 1: Into Programming

## Code

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

### Converting Between Types

**Coercion**: Converting from one type to another.

**Explicit Coercion**: Using a built in function to convert types.

```js
var a = "42";
var b = Number(a);

console.log(a); // "42"
console.log(b); // 42
```

**Implicit Coercion**: When JavaScript coerces values as part of an operation

```js
"99.99" == 99.99;  // true
"99.99" === 99.99; // false
```

## Code Comments

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

## Variables

**Variable**: A symbolic container that holds a value that can *vary* over time as needed.

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
