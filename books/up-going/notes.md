# Notes related to what I learned while completing this item

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
