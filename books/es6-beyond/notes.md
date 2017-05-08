# Notes from ES6 & Beyond


<!-- toc orderedList:0 depthFrom:2 depthTo:6 -->

* [ES? Now & Future](#es-now-future)
* [Syntax](#syntax)
  * [Block Scoped Declarations](#block-scoped-declarations)
  * [Spread/Rest](#spreadrest)
  * [Default Parameter Values](#default-parameter-values)
  * [Destructuring](#destructuring)

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
