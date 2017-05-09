# Notes from ES6 & Beyond


<!-- toc orderedList:0 depthFrom:2 depthTo:6 -->

* [ES? Now & Future](#es-now-future)
* [Syntax](#syntax)
  * [Block Scoped Declarations](#block-scoped-declarations)
  * [Spread/Rest](#spreadrest)
  * [Default Parameter Values](#default-parameter-values)
  * [Destructuring](#destructuring)
  * [Object Literal Extensions](#object-literal-extensions)
    * [Concise Properties](#concise-properties)
    * [Concise Methods](#concise-methods)
    * [Computed Property Names](#computed-property-names)
  * [Template Literals](#template-literals)
    * [Tagged Template Literals](#tagged-template-literals)
  * [Arrow Functions](#arrow-functions)
  * [`for..of` Loops](#forof-loops)
  * [Regular Expressions](#regular-expressions)
    * [Unicode Flag](#unicode-flag)
    * [Sticky Flag](#sticky-flag)
    * [Regular Expressiong `flags`](#regular-expressiong-flags)
  * [Number Literal Extensions](#number-literal-extensions)
  * [Symbols](#symbols)
    * [Global Symbol Registry](#global-symbol-registry)
    * [Symbols as Object Properties](#symbols-as-object-properties)
* [Organization](#organization)
* [Async Flow Control](#async-flow-control)
* [Collections](#collections)
  * [TypedArrays](#typedarrays)
  * [Maps](#maps)
  * [WeakMaps](#weakmaps)
  * [Sets](#sets)
  * [WeakSets](#weaksets)
* [API Additions](#api-additions)
  * [`Array`](#array)
  * [`Object`](#object)
  * [`Math`](#math)
  * [`Number`](#number)
  * [`String`](#string)

<!-- tocstop -->

## ES? Now & Future

ES6 (some may try to call it ES2015) is just landing as of the time of this writing, and it has lots of new stuff you need to learn!

But it's even more important to shift your mindset to align with the new way that JavaScript is going to evolve. It's not just waiting around for years for some official document to get a vote of approval, as many have done in the past.

Now, JavaScript features land in browsers as they become ready, and it's up to you whether you'll get on the train early or whether you'll be playing costly catch-up games years from now.

Whatever labels that future JavaScript adopts, it's going to move a lot quicker than it ever has before. Transpilers and shims/polyfills are important tools to keep you on the forefront of where the language is headed.

If there's any narrative important to understand about the new reality for JavaScript, it's that all JS developers are strongly implored to move from the trailing edge of the curve to the leading edge. And learning ES6 is where that all starts!

## Syntax

### Block Scoped Declarations

```js
// using `let`
var a = 2;

{
  let a = 3;
  console.log( a ); // 3
}

console.log( a ); // 2
```

```js
// `let` does not hoist
{
  console.log( a );  // undefined
  console.log( b ); // ReferenceError!

  var a;
  let b;
}
```

```js
// `let` in a `for` loop redeclares a new variable for each iteration of the loop
// so this...
var funcs = [];

for (let i = 0; i < 5; i++) {
  funcs.push( function() {
    console.log( i );
  } );
}

funcs[3](); // 3

// is equivalent to this...
var funcs = [];

for (var i = 0; i < 5; i++) {
  let j = i;
  funcs.push( function() {
    console.log( j );
  } );
}

funcs[3](); // 3
```

```js
// using `const` - cannot be reassigned
{
  const a = 2;
  console.log( a ); // 2
  a = 3;            // TypeError!
}
```

```js
// functions are block-scoped
{
  foo(); // works!

  function foo() {
    // ..
  }
}

foo(); // ReferenceError!
```

### Spread/Rest

```js
// use in front of iterable to spread out its individual values
function foo(x,y,z) {
  console.log( x, y, z );
}

foo( ...[1,2,3] ); // 1 2 3
```

```js
var a = [2,3,4];
var b = [ 1, ...a, 5 ];

console.log( b ); // [1,2,3,4,5]
```

```js
// also used to gather values together into an array
function foo(x, y, ...z) {
  console.log( x, y, z );
}

foo( 1, 2, 3, 4, 5 ); // 1 2 [3,4,5]
```

```js
// gather all arguments
function foo (...args) {
  // `args` is already a real array

  // discard first element in `args`
  args.shift();

  // pass along all of `args` as arguments to `console.log`
  console.log( ...args );
}

foo( 0, 1, 2, 3 ); // 1, 2, 3
```

### Default Parameter Values

```js
function foo(x = 11, y = 31) {
  console.log( x + y );
}

foo();                // 42
foo( 5, 6 );          // 11
foo( 0, 42 );         // 42

foo ( 5 );            // 36
foo( 5, undefined );  // 36 <-- `undefined` is missing
foo( 5, null );       // 5 <-- `null` coerces to `0`

foo ( undefined, 6 ); // 17 <-- `undefined` is missing
foo( null, 6 );       // 6 <-- `null` coerces to `0`
```

```js
// default values can be any expression
function bar(val) {
  console.log( "bar called" );
  return y + val;
}

function foo(x = y + 3, z = bar( x )) {
  console.log( x, z );
}

var y = 5;
foo();                // "bar called"
                      // 8 13

foo( 10 );            // "bar called"
                      // 10 15

y = 6;
foo( undefined, 10 ); // 9 10
```

### Destructuring

```js
function foo() {
  return [1,2,3];
}

function bar() {
  return {
    x: 4,
    y: 5,
    z: 6
  };
}

var [ a, b, c ] = foo();          // array destructuring
var { x: x, y: y, z: z } = bar(); // object destructuring

console.log( a, b, c ); // 1 2 3
console.log( x, y, z ); // 4 5 6
```

```js
// shortened object syntax
var { x, y, z } = bar();

console.log( x, y, z ); // 4 5 6
```

```js
// assigning property to different variable name
var { x: bam, y: baz, z: bap } = bar();

console.log( bam, baz, bap ); // 4 5 6
console.log( x, y, z );       // ReferenceError
```

```js
// swap two variables
var x = 10, y = 20;

[ y, x ] = [ x, y ];

console.log( x, y ); // 20 10
```

```js
// nested destructuring
var a1 = [ 1, [2, 3, 4], 5 ];
var o1 = { x: { y: { z: 6 } } };

var [ a, [ b, c, d ], e ] = a1;
var { x: { y: { z: w } } } = o1;

console.log( a, b, c, d, e ); // 1 2 3 4 5
console.log( w );             // 6
```

```js
// destructuring parameters
function foo( [ x, y ] ) {
  console.log( x, y );
}

foo( [ 1, 2 ] );  // 1 2
foo( [ 1 ] );     // 1 undefined
foo( [] );        // undefined undefined

function bar( { x, y } ) {
  console.log( x, y );
}

bar( { y: 1, x: 2 } ); // 2 1
bar( { y: 42 } );      // undefined 42
bar( {} );             // undefined undefined
```

```js
// default value assignment
function foo() {
  return [1,2,3];
}

function bar() {
  return {
    x: 4,
    y: 5,
    z: 6
  };
}

var [ a = 3, b = 6, c = 9, d = 12 ] = foo();
var { x = 5, y = 10, z = 15, w = 20 } = bar();

console.log( a, b, c, d ); // 1 2 3 12
console.log( x, y, z, w ); // 4 5 6 20
```

```js
// destructuring and restructuring
var defaults = {
  options: {
    remove: true,
    enable: false,
    instance: {}
  },
  log: {
    warn: true,
    error: true
  }
};

var config = {
  options: {
    remove: false,
    instance: null
  }
};

// merge defaults into config
{
  // destructure (with default value assignments)
  let {
    options: {
      remove = defaults.options.remove,
      enable = defaults.options.enable,
      instance = defaults.options.instance
    } = {},
    log: {
      warn = defaults.log.warn,
      error = defaults.log.error
    } = {}
  } = config;

  // restructure
  config = {
    options: { remove, enable, instance },
    log: { warn, error }
  };
}
```

### Object Literal Extensions

#### Concise Properties

```js
// old way
var x = 2, y = 3, o = {
  x: x,
  y: y
};

// ES6 way
var x = 2, y = 3, o = {
  x,
  y
};
```

#### Concise Methods

```js
// old way
var o = {
  x: function() {
    // ..
  },
  y: function() {
    // ..
  }
};

// ES6 way
var o = {
  x() {
    // ..
  },
  y() {
    // ..
  }
};
```

#### Computed Property Names

```js
var prefix = "user_";

var o = {
  baz: function(..){..},
  [ prefix + "foo" ]: function(..){..},
  [ prefix + "bar" ]: function(..){..}
  ..
};
```

### Template Literals

```js
// old way
var name = "Kyle";

var greeting = "Hello " + name + "!";

console.log( greeting );        // "Hello Kyle!"
console.log( typeof greeting ); // "string"

// ES6 way
var name = "Kyle";

var greeting = `Hello ${name}!`;

console.log( greeting );        // "Hello Kyle!"
console.log( typeof greeting ); // "string"
```

#### Tagged Template Literals

```js
function foo(strings, ...values) {
  console.log(strings);
  console.log(values);
}

var desc = "awesome";

foo`Everything is ${desc}!`;
// [ "Everything is ", "!" ]
// [ "awesome" ]
```

```js
function dollabillsyall(strings, ...values) {
	return strings.reduce( function(s,v,idx){
		if (idx > 0) {
			if (typeof values[idx-1] == "number") {
				// look, also using interpolated
				// string literals!
				s += `$${values[idx-1].toFixed( 2 )}`;
			}
			else {
				s += values[idx-1];
			}
		}

		return s + v;
	}, "" );
}

var amt1 = 11.99,
	amt2 = amt1 * 1.08,
	name = "Kyle";

var text = dollabillsyall
`Thanks for your purchase, ${name}! Your
product cost was ${amt1}, which with tax
comes out to ${amt2}.`

console.log( text );
// Thanks for your purchase, Kyle! Your
// product cost was $11.99, which with tax
// comes out to $12.95.
 ```

 ### Arrow Functions

 ```js
 function foo(x,y) {
   return x + y;
 }

 // versus

 var foo = (x,y) => x + y;
 ```

 ```js
 // other variations
 f1 = () => 12;
 f2 = x => x * 2;
 f3 = (x,y) => {
   var z = x * 2 +y;
   y++;
   x *= 3;
   return (x + y + z) / 2;
 };
```

In arrow functions, `this` binding is lexical

```js
// old way
var controller = {
  makeRequest: function(..) {
    var self = this;

    btn.addEventListener( "click", function() {
      // ..
      self.makeRequest(..);
    }, false );
  }
};

// with arrow function
var controller = {
  makeRequest: function(..) {
    btn.addEventListener( "click", () => {
      // ..
      this.makeRequest(..);
    }, false );
  }
};
```

"Rules" for when `=>` is apprpriate and not:
* If you have a short, single-statement inline function expression, where the only statement is a `return` of some computed value, *and* that function doesn't already make a `this` reference inside it, *and* there's no self-reference (recursion, event binding/unbinding), *and* you don't reasonably expect the function to ever be that way, you can probably safely refactor it to be an `=>` arrow function.
* If you have an inner function expression that's relying on a `var self = this` hack or a `.bind(this)` call on it in the enclosing function to ensure proper `this` binding, that inner function expression can probably safely become an `=>` arrow function.
* If you have an inner function expression that's relying on something like `var args = Array.prototype.slice.call(arguments)` in the enclosing function to make a lexical copy of `arguments`, that inner function expression can probably safely become an `=>` arrow function.
* For everything else -- normal function declarations, longer multistatement function expressions, functions that need a lexical name identifier self-reference (recursion, etc.), and any other function that doesn't fit the previous characteristics -- you should probably avoid `=>` function syntax.

![Arrow-decision](./arrow-decision.png)

### `for..of` Loops

```js
var a = ['a','b','c','d','e'];

// for..in loop
for (var idx in a) {
  console.log( idx );
}
// 0 1 2 3 4

// for..of loop
for (var val of a) {
  console.log( val );
}
// "a" "b" "c" "d" "e"
```

The value looped over in a `for..of` loop must be an *iterable*. Standard built-in iterables include:
* Arrays
* Strings
* Generators
* Collections/TypedArrays

### Regular Expressions

#### Unicode Flag

```js
/𝄞/.test( "𝄞-clef" );			     // true
/^.-clef/ .test( "𝄞-clef" );		// false -- 𝄞 is two separate characters
/^.-clef/u.test( "𝄞-clef" );	 // true -- 𝄞 is single character
```

#### Sticky Flag

```js
var re1 = /foo/,    // <-- no sticky flag
	str = "++foo++";

re1.lastIndex;			// 0
re1.test( str );		// true
re1.lastIndex;			// 0 -- not updated

re1.lastIndex = 4;
re1.test( str );		// true -- ignored `lastIndex`
re1.lastIndex;			// 4 -- not updated

var re2 = /foo/y,		// <-- notice the `y` sticky flag
	str = "++foo++";

re2.lastIndex;			// 0
re2.test( str );		// false -- "foo" not found at `0`
re2.lastIndex;			// 0

re2.lastIndex = 2;
re2.test( str );		// true
re2.lastIndex;			// 5 -- updated to after previous match

re2.test( str );		// false
re2.lastIndex;			// 0 -- reset after previous match failure
```

#### Regular Expressiong `flags`

```js
var re = /foo/ig;
re.flags;                            // "gi"

var re1 = /foo*/y;
re1.source;                          // "foo*"
re1.flags;                           // "y"

var re2 = new RegExp( re1 );
re2.source;                          // "foo*"
re2.flags;                           // "y"

var re3 = new RegExp( re1, "ig" );
re3.source;                          // "foo*"
re3.flags;                           // "gi"
```

### Number Literal Extensions

```js
// ES6 literal forms
var dec = 42,
    oct = 0o52,     // or '0O52' :(
    hex = 0x2a,     // or '0X2a' :/
    bin = 0b101010; // or '0B101010' :/

// coerced to number
Number( "42" );       // 42
Number( "0o52" );     // 42
Number( "0x2a" );     // 42
Number( "0b101010" ); // 42

// coerced from number
var a = 42;

a.toString();     // "42" -- also `a.toString(10)`
a.toString( 8 );  // "52"
a.toString( 16 ); // "2a"
a.toString( 2 );  // "101010"
```

### Symbols

```js
var sym = Symbol( "some optional description" );

typeof sym; // "symbol"

sym.toString(); // "Symbol(some optional description)"
```

The main point of a symbol is to create a string-like value that can't collide with any other value.

```js
const EVT_LOGIN = Symbol( "event.login" );

evthub.listen(EVT_LOGIN, function(data) {
  // ..
});
```

#### Global Symbol Registry

```js
// add a symbol to the registry
const s = Symbol.for( "something cool" );
console.log( s ); // Symbol("something cool")

// retrieve the symbol's key
var desc = Symbol.keyFor( s );
console.log( desc ); // "something cool"

// get the symbol from the registry again
var s2 = Symbol.for( desc );

s2 === s; // true
```

#### Symbols as Object Properties

```js
var o = {
  foo: 42,
  [ Symbol( "bar" ) ]: "hello world",
  baz: true
};

Object.getOwnPropertyNames( o ); // [ "foo", "baz" ]

Object.getOwnPropertySymbols( o ); // [ Symbol(bar) ]
```

## Organization

ES6 Introduces several new features that aid in code organization:
* Iterators provide sequential access to data or operations. They can be consumed by new language features like `for..of` and `...`.
* Generators are locally pause/resume capable functions controlled by an iterator. They can be used to programmatically (and interactively, through `yield / next(..)` message passing) *generate* values to be consumed via iteration.
* Modules allow private encapsulation of implementation details with a publicly exported API. Module definitions are file-based, singleton instances, and statically resolved at compile time.
* Classes provide cleaner syntax around prototype-based coding. The addition of `super` also solves tricky issues with relative references in the `[[Prototype]]` chain.

These new tools should be your first stop when trying to improve the architecture of your JS projects by embracing ES6.

## Async Flow Control

As JavaScript continues to mature and grow in its widespread adoption, asynchronous programming is more and more of a central concern. Callbacks are not fully sufficient for these tasks, and totally fall down the more sophisticated the need.

Thankfully, ES6 adds Promises to address one of the major shortcomings of callbacks: lack of trust in predictable behavior. Promises represent the future completion value from a potentially async task, normalizing behavior across sync and async boundaries.

But it's the combination of Promises with generators that fully realizes the benefits of rearranging our async flow control code to de-emphasize and abstract away that ugly callback soup (aka "hell").

Right now, we can manage these interactions with the aide of various async libraries' runners, but JavaScript is eventually going to support this interaction pattern with dedicated syntax alone!

## Collections

### TypedArrays

**TypedArrays** provide "view"s of binary data buffers that align with various number types, like 8bit unsigned integers and 32-bit floats. The array access to binary data makes operations much easier to express and maintain, which enables you to more easily work with complex data like video, audio, canvas data, and so on.

```js
var buf = new ArrayBuffer( 32 );
buf.byteLength;                    // 32

var arr = new Uint16Array( buf );
arr.length;                        // 16
```

TypedArray constructors:
* `Int8Array` (8-bit signed integers), `Uint8Array` (8-bit unsigned integers)
  * `Uint8ClampedArray` (8-bit unsigned integers, each value clamped on setting to the `0`-`255` range)
* `Int16Array` (16-bit signed integers), `Uint16Array` (16-bit unsigned integers)
* `Int32Array` (32-bit signed integers), `Uint32Array` (32-bit unsigned integers)
* `Float32Array` (32-bit floating point, IEEE-754)
* `Float64Array` (64-bit floating point, IEEE-754)

### Maps

*Maps* are key-value pairs where the key can be an object instead of just a string/primitive.

```js
var m = new Map();

var x = { id: 1 }, y = { id: 2 };

m.set( x, "foo" );
m.set( y, "bar" );

m.get( x );                    // "foo"
m.get( y );                    // "bar"
m.size;                        // 2

var vals = [ ...m.values() ];
vals;                          // ["foo","bar"]

var keys = [ ...m.keys() ];
keys[0] === x;                 // true
keys[1] === y;                 // true

m.delete( y );
m.size;                        // 1

m.has( x );                    // true
m.has( y );                    // false

m.clear();
m.size;                        // 0

var m2 = new Map( m );
```

### WeakMaps

**WeakMaps** are maps where the key (object) is weakly held, so that GC is free to collect the entry if it's the last reference to an object.

```js
var m = new WeakMap();

var x = {id: 1}, y = {id: 2}, z = {id: 3}, w = {id: 4};

m.set( x, y );

x = null; // {id: 1} is GC-eligible
y = null; // {id: 2} is GC-eligible -- only because {id: 1} is

m.set( z, w );

w = null; // {id: 4} is not GC-eligible
```

### Sets

**Sets** are unique lists of values (of any type).

```js
var s = new Set();

var x = { id: 1 }, y = { id: 2 };

s.add( x );
s.add( y );
s.add( x );

s.size;     // 2

s.delete( y );
s.size;     // 1

s.has( x ); // true
s.has( y ); // false

s.clear();
s.size;     // 0
```

```js
var s = new Set( [1,2,3,4,"1",2,4,"5"] );
var uniques = [ ...s ];

uniques; // [1,2,3,4,"1","5"]
```

### WeakSets

**WeakSets** are sets where the value is weakly held, so that GC can remove the entry if it's the last reference to that object.

```js
var s = new WeakSet();

var x = {id: 1}, y = { id: 2 };

s.add( x );
s.add( y );

x = null; // x is GC-eligible
y = null; // y is GC-eligible
```

## API Additions

### `Array`

`Array.of()` replaces `Array()` as the preferred function-form constructor for arrays.

```js
var a = Array( 3 );
a.length;                     // 3
a[0];                         // undefined

var b = Array.of( 3 );
b.length;                     // 1
b[0];                         // 3

var c = Array.of( 1, 2, 3 );
c.length;                     // 3
c;                            // [1,2,3]
```

`Array.from()` can make an array from an iterable or array-like object.

```js
// duplicate an array
var arr = [1,2,3];

// old way
var arr2 = arr.slice();
arr2; // [1,2,3]

// ES6 way
var arr3 = Array.from( arr );
arr3; // [1,2,3]
```

```js
// array-like object
var arrLike = {
  length: 3,
  0: "foo",
  1: "bar"
};

// old way
var arr = Array.prototype.slice.call( arrLike );
arr; // ["foo","bar"]

// ES6 way
var arr2 = Array.from( arrLike );
arr2; // ["foo","bar"]
```

```js
// make an array of undefined values
// old way
var a = Array.apply( null, { length: 4 } );

// ES6 way
var c = Array.from( { length: 4 } );
```

```js
// 2nd argument is a mapping callback
var arrLike = {
  length: 4,
  2: "foo"
};

Array.from( arrLike, function mapper(val,idx) {
  if (typeof val == "string") {
    return val.toUpperCase();
  } else {
    return idx;
  }
} );
// [0,1,"FOO",3]
```

`Array#copyWithin()` copies a portion of an array to another location in the same array, overwriting whatever was there before.

The arguments are *target* (the index to copy to), *start* (the inclusive index to start the copying from), and optionally *end* (the exclusive index to stop copying). If any of the arguments are negative, they're taken to be relative from the end of the array.

```js
[1,2,3,4,5].copyWithin( 3, 0 );      // [1,2,3,1,2]
[1,2,3,4,5].copyWithin( 3, 0, 1 );   // [1,2,3,1,5]
[1,2,3,4,5].copyWithin( 0, -2 );     // [4,5,3,4,5]
[1,2,3,4,5].copyWithin( 0, -2, -1 ); // [4,2,3,4,5]
[1,2,3,4,5].copyWithin( 2, 1 );      // [1,2,2,3,4]
```

`Array#fill()` fills an existing array entirely (or partially) with a specified value.

```js
var a = Array( 4 ).fill( undefined );
a; // [undefined,undefined,undefined,undefined]

// takes optional start and end parameters
var b = [ null, null, null, null ].fill( 43, 1, 3 );
b; // [null,42,42,null]
```

`Array#find()` works basically the same as `some()`, except that once the callback returns a `true`/truthy value, the actual array value is returned.

```js
var a = [1,2,3,4,5];

a.some( function matcher(v) {
  return v == "2";
} ); // true

a.some ( function matcher(v) {
  return v == 7;
} ); // false

a.find( function matcher(v) {
  return v == "2";
} ); // 2

a.find( function matcher(v) {
  return v == 7;
} ); // undefined
```

`array#findIndex()` is similar to `indexOf()`, but uses a callback for the matching logic.

```js
var a = [1,2,3,4,5];

// indexOf() always uses === strict equality
a.indexOf("2"); // -1

a.findIndex( function matcher(v) {
  return v == "2";
} ); // 1
```

Don't use `findIndex(..) != -1` (the way it's always been done with `indexOf(..)`) to get a boolean from the search, because `some(..)` already yields the `true`/`false` you want. And don't do `a[ a.findIndex(..) ]` to get the matched value, because that's what `find(..)` accomplishes. Use `indexOf(..)` if you need the index of a strict match, or `findIndex(..)` if you need the index of a more customized match.

Arrays also include the iterator methods: `entries()`, `values()`, and `keys()`.

```js
var a = [1,2,3];

[...a.values()]; // [1,2,3]
[...a.keys()]; // [0,1,2]
[...a.entries()] // [ [0,1], [1,2], [2,3] ]

[...a[Symbol.iterator]()]; // [1,2,3]
```

### `Object`

`Object.is()` makes value comparisons in an even more strict fashion than the `===` comparison. Is the same, with two important exceptions.

```js
var = NaN, y = 0, z = -0;

x === x; // false
y === z; // true

Object.is( x, x ); // true
Object.is( y, z ); // false
```

`Object.getOwnPropertySymbols()` retrives only the symbol properties directly on an object.

```js
var o = {
  foo: 42,
  [ Symbol( "bar" ) ]: "hello world",
  baz: true
};

Object.getOwnPropertySymbols( o ); // [ Symbol(bar) ]
```

`Object.setPrototypeOf()` sets the `[[Prototype]]` of an object for the purposes of *behavior delegation*.

```js
var o1 = {
  foo() { console.log( "foo" ); }
};

// first way
var o2 = {
  // .. o2's definition ..
};
Object.setPrototypeOf( o2, o1 );

// second way
var o3 = Object.setPrototypeOf( {
  // .. o3's definition ..
}, o1 );

// delegates to o1.foo()
o2.foo(); // foo
o3.foo(); // foo
```

`Object.assign()` copies one object's properties into another. The first argument is the *target*, and any other arguments passed are the *sources*, which will be processed in listed order. For each source, its enumerable and own (e.g., not "inherited") keys, including symbols, are copied as if by plain `=` assignment. The target object is returned.

```js
var target = {},
	o1 = { a: 1 }, o2 = { b: 2 },
	o3 = { c: 3 }, o4 = { d: 4 };

// setup read-only property
Object.defineProperty( o3, "e", {
	value: 5,
	enumerable: true,
	writable: false,
	configurable: false
} );

// setup non-enumerable property
Object.defineProperty( o3, "f", {
	value: 6,
	enumerable: false
} );

o3[ Symbol( "g" ) ] = 7;

// setup non-enumerable symbol
Object.defineProperty( o3, Symbol( "h" ), {
	value: 8,
	enumerable: false
} );

Object.setPrototypeOf( o3, o4 );

Object.assign( target, o1, o2, o3 );

target.a;							// 1
target.b;							// 2
target.c;							// 3

Object.getOwnPropertyDescriptor( target, "e" );
// { value: 5, writable: true, enumerable: true,
//   configurable: true }

Object.getOwnPropertySymbols( target );
// [Symbol("g")]
// d, f, and Symbol("h") are omitted from copying because they are either non-enumerable or non-owned
```

```js
// using Object.assign() to set up a [[Prototype]] relationship
var o1 = {
  foo() { console.log( "foo" ); }
};

var o2 = Object.assign(
  Object.create( o1 ), {
    // .. o2's definition ..
  }
);

// delegates to o1.foo()
o2.foo(); // foo
```

### `Math`

Trigonometry:
* `cosh()`-Hyperbolic cosine
* `acosh()`-Hyperbolic arccosine
* `sinh()`-Hyperbolic sine
* `asinh()`-Hyperbolic arcsine
* `tanh()`-Hyperbolic tangent
* `atanh()`-Hyperbolic arctangent
* `hypot()`-The squareroot of the sum of the squares (i.e., the generalized Pythagorean theorem)

Arithmetic:
* `cbrt()`-Cube root
* `cls32()`-Count leading zeros in 32-bit binary representation
* `expm1()`-The same as `exp(x) - 1`
* `log2()`-Binary logarithm (log base 2)
* `log10()`-Log base 10
* `log1p()`-The same as `log(x + 1)`
* `imul()`-32-bit integer multiplication of two numbers

Meta:
* `sign()`-Returns the sign of the number
* `trunc()`-Returns only the integer part of a number
* `fround()`-Rounds to nearest 32-bit (single precision) floating-point value

### `Number`

`Number.EPSILON` is the minimum value between any two numbers: `2^-52`

```js
// used as a tolerance for imprecision in floating-point arithmetic
var x = 0.1, y = 0.2, z = 0.3;

x + y; // 0.30000000000000004

x + y == z; // false

Math.abs(x + y - z) < Number.EPSILON; // true
```

`Number.MAX_SAFE_INTEGER` is the highest integer that can "safely" be represented unambiguously in a JS number value: `2^53 - 1`.

`Number.MIN_SAFE_INTEGER` is the lowest integer that can "safely" be represented unambiguously in a JS number value: `-(2^53 - 1)`.

`Number.isNaN()` only returns true if value is NaN, where the global isNaN() returns true for any value that is not a number.

```js
var a = NaN, b = "NaN", c = 42;

isNaN(a); // true
isNaN(b); // true -- oops!
isNaN(c); // false

Number.isNaN(a); // true
Number.isNaN(b); // false -- fixed!
Number.isNaN(c); // false
```

`Number.isFinite()`.

```js
var a = NaN, b = Infinity, c = 42, d = "42";

Number.isFinite( a ); // false
Number.isFinite( b ); // false
Number.isFinite( c ); // true
Number.isFinite( d ); // false

// global isFinite() coerces the value
isFinite( d ); // true
```

`Number.isInteger()`.

```js
Number.isInteger( 4 );        // true
Number.isInteger( 4.2 );      // false
Number.isInteger( NaN );      // false
Number.isInteger( Infinity ); // false
```

### `String`

`String.raw()` obtains the raw string value of a template literal without processing of escape sequences.

```js
var str = "bc";

String.raw`\ta${str}d\xE9`; // "\tabcd\xE9", not "	abcdé"
```

`String#repeat()`.

```js
"foo".repeat( 3 ); // "foofoofoo"
```

String inspection functions:

```js
var palindrome = "step on no pets";

palindrome.startsWith( "step on" ); // true
palindrome.startsWith( "on", 5 ); // true

palindrome.endsWith( "no pets" ); // true
palindrome.endsWith( "no", 10 ); // true

palindrome.includes( "on" ); // true
palindrome.includes( "on", 6 ); // false
```
