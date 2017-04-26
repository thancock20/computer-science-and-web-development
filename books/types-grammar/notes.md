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
