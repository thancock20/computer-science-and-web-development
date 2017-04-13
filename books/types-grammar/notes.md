# Notes for YDKJS: Types & Grammar

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
typeof true === 'boolean'; // true
typeof 42 === 'number'; // true
typeof '42' === 'string'; // true
typeof { life: 42 } === 'object'; // true
typeof Symobl() === 'symbol'; // true
typeof null === 'object'; // true -- this is a bug

// to test for a null value
var a = null;
(!a && typeof a === 'object'); // true

typeof function a(){ /* .. */ } === 'function'; // true -- but is actually a subtype of object
typeof [1,2,3] === 'object'; // true
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

a; // undefined
b; // ReferenceError: b is not defined -- actually undeclared

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
