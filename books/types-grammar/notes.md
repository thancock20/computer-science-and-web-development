# Notes for YDKJS: Types & Grammar


<!-- toc orderedList:0 depthFrom:2 depthTo:6 -->

* [Types](#types)
  * [`undefined` vs "undeclared"](#undefined-vs-undeclared)
* [Values](#values)
  * [Arrays](#arrays)
  * [Strings](#strings)
  * [Numbers](#numbers)
    * [Small Decimal Values](#small-decimal-values)
  * [Special Values](#special-values)
* [Natives](#natives)
  * [Boxing Wrappers](#boxing-wrappers)
  * [Unboxing](#unboxing)
  * [Natives as Constructors](#natives-as-constructors)
* [Coercion](#coercion)
  * [Explicit Coercion](#explicit-coercion)
  * [Implicit Coercion](#implicit-coercion)
* [Grammar](#grammar)

<!-- tocstop -->

## Types

**type**: An intrinsic, built-in set of characteristics that uniquely identifies the behavior of a particular value and distinguishes it from other values, both to the engine and to the developer.

Javascript defines seven built in types:

1. `null`
2. `undefined`
3. `boolean`
4. `number`
5. `string`
6. `object`
7. `symbol`--added in ES6!

The `typeof` operator inspects the type of the given value, and returns one of seven string values:

```js
typeof undefined === 'undefined'; // true
typeof true === 'boolean';        // true
typeof 42 === 'number';           // true
typeof '42' === 'string';         // true
typeof { life: 42 } === 'object'; // true
typeof Symobl() === 'symbol';     // true
typeof null === 'object';         // true -- this is a bug

// to test for a null value
var a = null;
(!a && typeof a === 'object');                  // true

typeof function a(){ /* .. */ } === 'function'; // true -- but is actually a subtype of object
typeof [1,2,3] === 'object';                    // true
```

In JavaScript, variables don't have types -- **values have types**. If you use `typeof` against a variable, it's not asking "what's the type of the variable?" Instead, it's asking "what's the type of the value in the variable?"

### `undefined` vs "undeclared"

```js
var a;

typeof a; // 'undefined'

var b = 42;
var c;

// later
b = c;

typeof b; // 'undefined'
typeof c; // 'undefined'
```

```js
var a;

a;        // undefined
b;        // ReferenceError: b is not defined -- actually undeclared

typeof a; // 'undefined'
typeof b; // 'undefined' -- actually undeclared
```

```js
// check of global `DEBUG` variable

// oops, this would throw an error:
if (DEBUG) {
    console.log( "Debugging is starting" );
}

// this is a safe existence check
if (typeof DEBUG !== 'undefined') {
    console.log( "Debugging is starting" );
}
```

```js
// Also useful for polyfills
if (typeof atob === 'undefined') {
    atob = function() { /* .. */ };
}
```

## Values

### Arrays

```js
// arrays are just containers for any type of value
var a = [ 1, '2', [3] ];

a.length;      // 3
a[0] === 1;    // true
a[2][0] === 3; // true
```

```js
// arrays don't need to be presized
var a = [];

a.length; // 0

a[0] = 1;
a[1] = '2';
a[2] = [ 3 ];

a.length; // 3
```

```js
// be careful about creating "sparse" arrays
var a = [];

a[0] = 1;
// no a[1] slot set here
a[2] = [ 3 ];

a[1];    // undefined -- does not behave the same as explicitly set to undefined

a.length // 3
```

### Strings

It's a very common belief that `string`s are essentially just `array`s of characters. But this is not true, because `string`s are immutable. None of the `string` methods that alter its contents can modify in-place, but rather must create and return new `string`s.

If you are more commonly doing tasks on "strings" that treat them as basically arrays of characters, it's better to actually store them as `array`y and call `join("")` whenever you actually need the `string` representation.

### Numbers

```js
// By default, most numbers will be outputted as base-10 decimals, with trailing fractional 0s removed
var a = 42.300;
var b = 42.0;

a; // 42.3
b; // 42
```

```js
// Very large or very small numbers will be outputted in exponent form
var a = 5E10;
a;                 //  50000000000
a.toExponential(); // "5e+10"

var b = a *a;
b;                 // 2.5e+21

var c = 1 / a;
c;                 // 2e-11
```

```js
// The toFixed(..) method allows you to specify how many fractional decimal places you'd like the value to be represented with
var a = 42.59;

a.toFixed( 0 ); // "43"
a.toFixed( 1 ); // "42.6"
a.toFixed( 2 ); // "42.59"
a.toFixed( 3 ); // "42.590"
a.toFixed( 4 ); // "42.5900"
```

```js
// The toPrecision(..) method specifies how many significant digits should be usued to represent the value
var a = 42.59;

a.toPrecision( 1 ); // "4e+1"
a.toPrecision( 2 ); // "43"
a.toPrecision( 3 ); // "42.6"
a.toPrecision( 4 ); // "42.59"
a.toPrecision( 5 ); // "42.590"
a.toPrecision( 6 ); // "42.5900"
```

#### Small Decimal Values

```js
// floating-point imprecision at work
0.1 + 0.2 === 0.3; // false

// polyfill for number.EPSILON for pre ES6
if (!Number.EPSILON) {
   Number.EPSION = Math.pow(2,-52);
}

// compare two numbers for equality within the rounding error tolerance

function numbersCloseEnoughToEqual(n1,n2) {
    return Math.abs( n1 - n2 ) < Number.EPSILON;
}

var a = 0.1 + 0.2;
var b = 0.3;

numbersCloseEnoughToEqual( a, b );                // true
numbersCloseEnoughToEqual( .0000001, 0.0000002 ); // false
```

### Special Values

* `null` is also the value of the `null` type.
* `unidentified` is also the value of the `unidentified` type.
    * It is possible to assign a value to the `unidentified` identifier, but this would be a really bad idea!
    * The `void` operator always results in the `unidentified` value:
        ```js
        var a =42;

        console.log( void a, a); // unidentified 42
        ```
* `NaN` means "not a number", even though it's type is `number`
```js
// NaN is never equal to another NaN
var a = 2 / "foo";

a == NaN;          // false
a === NaN;         // false

 // ES6 introduces Number.isNaN()
Number.isNaN( a ); // true

// pre ES6 polyfill
if (!Number.isNaN) {
    Number.isNaN = function(n) {
        return n !== n;
    }
}
```
* Infinities
```js
var a = 1 / 0;       // Infinity
var b = -1 / 0;      // -Infinity

Infinity / Infinity; // NaN
1 / Infinity;        // 0
```
* Zeros
```js
var a = 0;
var b = 0 / -3; // -0

a == b;         // true
-0 == 0;        // true

a === b;        // true
-0 === 0;       // true

0 > -0;         // false
a > b;          // false
```

```js
// in ES6 the Object.is() utility will test for equality of NaN or the zeros
var a = 2 / "foo";
var b = -3 * 0;

Object.is(a, NaN); // true
Object.is(b, -0);  // true

Object.is(b, 0);   // false

// pre-ES6 polyfill
if (!Object.is) {
    Object.is = function(v1, v2) {
        // test for '-0'
        if (v1 === 0 && v2 === 0) {
            return 1 / v1 === 1 / v2;
        }
        // test for 'NaN'
        if (v1 !== v1) {
            return v2 !== v2;
        }
        // everything else
        return v1 === v2;
    };
}
```

## Natives

The most commonly used natives are:
* `String()`
* `Number()`
* `Boolean()`
* `Array()`
* `Object()`
* `Function()`
* `RegExp()`
* `Date()`
* `Error()`
* `Symbol()` -- added in ES6!

```js
// creates a string wrapper object, not the primitive value itself
var a = new String( "Hello World!" );

console.log( a.toString() );         // "Hello World"

typeof a;                            // "object" ... not "String"

a instanceof String;                 // true

Object.prototype.toString.call( a ); // "[object String]"
```

### Boxing Wrappers

```js
// primitive values don't have properties or methods,
// so JS will automatically box the primitive value to fulfill such accesses
var a = 'abc';

a.length;        // 3
a.toUpperCase(); // "ABC"
```

```js
// remember, objects are truthy
var a = new Boolean( false );

if (!a) {
  console.log( "Oops" ); // never runs
}
```

There's basically no reason to use the object form of primitives (`string`, `number`, `boolean`) directly. It's better to just let the boxing happen implicitly where necessary.

### Unboxing

```js
// get at the underlying primitive value with the valueOf() method
var a = new String( "abc" );
var b = new Number( 42 );
var c = new Boolean( true );

a.valueOf(); // "abc"
b.valueOf(); // 42
c.valueOf(); // true
```

### Natives as Constructors

For `array`, `object`, `function`, and regular-expression values, it's almost universally preferred to use the literal form for creating the values, but the literal form creates the same sort of object as the constructor form does (that is, there is no nonwrapped value).

```js
var a = new Array(1, 2, 3);
a; // [1, 2, 3]

var b = [1, 2, 3];
b; // [1, 2, 3]

var c = new Object();
c.foo = "bar";
c; // { foo: "bar" }

var d = { foo: "bar" };
d; // { foo: "bar" }

var e = new Function( "a", "return a * 2;" );
var f = function(a) { return a * 2; };
function g(a) { return a * 2; }

var h = new RegExp( "^a*b+", "g" );
var i = /^a*b+/g;
```

```js
// to create an array of undefined values
var a = Array.apply( null, { length: 3 } );
a; // [ undefined, undefined, undefined ]
```

```js
// the RegExp constructor can be used to
// dynamically define the pattern
var name = 'Kyle';
var namePattern = new RegExp( "\\b(?:" + name + ")+\\b", "ig" );

var matches = someText.match( namePattern );
```

The `Date()` and `Error()` native constructors are much more useful than the other natives, because there is no literal form for either.

```js
// get the current timestamp
Date.now();

// polyfill for pre-ES5
if (!Date.now) {
  Date.now = function() {
    return (new Date()).getTime();
  };
}
```

The main reason you'd want to create an error object is that it captures the current execution stack context into the object (in most JS engines, revealed as a read-only `.stack` property once constructed). This stack context includes the function call-stack and the line-number where the error object was created, which makes debugging that error much easier.

```js
// You would typically use such an error object with the throw operator
function foo(x) {
  if (!x) {
    throw new Error( "x wasn't provided" );
  }
  // ...
}
```

```js
// to use a predefined symbol, do something like this
obj[Symbol.iterator] = function() { /*..*/ };

// to define your own custom symbol
var mysym = Symbol( "my own symbol" ); // don't use new
mysym;                                 // Symbol(my own symbol)
mysym.toString();                      // "Symbol(my own symbol)"
typeof mysym;                          // "symbol"

var a = {  };
a[mysym] = "foobar";

Object.getOwnPropertySymbols( a ); // [ Symbol(my own symbol) ]
```
 **Note**: `Symbol`sare *not* `object`s, they are simple scalar primitives.

 ## Coercion

 *Explicit* coercion is code which is obvious that the intent is to convert a value from one type to another. The benefit is improvement in readability and maintainability of code by reducing confusion.

 *Implicit* coercion is "hidden" as a side-effect of some other operation, where it's not as obvious that the type conversion will occur.

 Especially for *implicit*, coercion must be used responsibly and consciously. Know why you're writing the code you're writing, and how it works. Strive to write code that others will easily be able to learn from and understand as well.

 ### Explicit Coercion

 ```js
 var a = 42;
 var b = String(a); // no new keyword

 var c = "3.14";
 var d = Number(c);

 b; // "42"
 d; // 3.14
 ```

 ```js
var a = 42;
var b = a.toString(); // boxes the number first

var c = "3.14";
var d = +c; // unary + operator

b; // "42"
d; // 3.14
```

```js
// parseInt will get integer part at beginning of string
var a = "42";
var b = "42px";

Number(a); // 42
parseInt(a); // 42

Number(b); // NaN
parseInt(b); // 42
```

```js
// coerce to boolean using native function
var a = "0";
var b = [];
var c = {};

var d = "";
var e = 0;
var f = null;
var g; // undefined

Boolean(a); // true
Boolean(b); // true
Boolean(c); // true

Boolean(d); // false
Boolean(e); // false
Boolean(f); // false
Boolean(g); // false
```

```js
// coerce to boolean using !!
var a = "0";
var b = [];
var c = {};

var d = "";
var e = 0;
var f = null;
var g; // undefined

!!a; // true
!!b; // true
!!c; // true

!!d; // false
!!e; // false
!!f; // false
!!g; // false
```

### Implicit Coercion

```js
// coerce number to string by adding blank string
var a = 42;
var b = a + "";

b; // "42"
```

```js
// coerce string to number by subtracting 0
var a = "3.14";
var b = a - 0;

b; // 3.14
```

```js
// boolean to number coercion can simplify this...
function onlyOne(a,b,c) {
  return !!((a && !b && !c) ||
          (!a && b && !c) || (!a && !b && c));
}

// ...to this, and use any number of arguments
function onlyOne() {
  var sum = 0;
  for (var i = 0; i < arguments.length; i++) {
    sum += !!arguments[i];
  }
  return sum == 1;
}
```

## Grammar

JavaScript grammar has plenty of nuance that we as developers should spend a little more time paying closer attention to than we typically do. A little bit of effort goes a long way to solidifying your deeper knowledge of the language.

Statements and expressions have analogs in English language -- statements are like sentences and expressions are like phrases. Expressions can be pure/self-contained, or they can have side effects.

The JavaScript grammar layers semantic usage rules (aka context) on top of the pure syntax. For example, `{ }` pairs used in various places in your program can mean statement blocks, `object` literals, (ES6) destructuring assignments, or (ES6) named function arguments.

JavaScript operators all have well-defined rules for precedence (which ones bind first before others) and associativity (how multiple operator expressions are implicitly grouped). Once you learn these rules, it's up to you to decide if precedence/associativity are too implicit for their own good, or if they will aid in writing shorter, clearer code.

ASI (Automatic Semicolon Insertion) is a parser-error-correction mechanism built into the JS engine, which allows it under certain circumstances to insert an assumed `;` in places where it is required, was omitted, and where insertion fixes the parser error. The debate rages over whether this behavior implies that most `;` are optional (and can/should be omitted for cleaner code) or whether it means that omitting them is making mistakes that the JS engine merely cleans up for you.

JavaScript has several types of errors, but it's less known that it has two classifications for errors: "early" (compiler thrown, uncatchable) and "runtime" (`try..catch`able). All syntax errors are obviously early errors that stop the program before it runs, but there are others, too.

Function arguments have an interesting relationship to their formal declared named parameters. Specifically, the `arguments` array has a number of gotchas of leaky abstraction behavior if you're not careful. Avoid `arguments` if you can, but if you must use it, by all means avoid using the positional slot in `arguments` at the same time as using a named parameter for that same argument.

The `finally` clause attached to a `try` (or `try..catch`) offers some very interesting quirks in terms of execution processing order. Some of these quirks can be helpful, but it's possible to create lots of confusion, especially if combined with labeled blocks. As always, use `finally` to make code better and clearer, not more clever or confusing.

The `switch` offers some nice shorthand for `if..else if..` statements, but beware of many common simplifying assumptions about its behavior. There are several quirks that can trip you up if you're not careful, but there's also some neat hidden tricks that `switch` has up its sleeve!

For more info on grammar see [here](https://github.com/getify/You-Dont-Know-JS/blob/master/types%20%26%20grammar/ch5.md).
