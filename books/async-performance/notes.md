# Notes for Async & Performance


<!-- toc orderedList:0 depthFrom:2 depthTo:6 -->

* [Asynchrony: Now & Later](#asynchrony-now-later)
* [Callbacks](#callbacks)
* [Promises](#promises)
* [Generators](#generators)
  * [Multiple Iterators](#multiple-iterators)
  * [Generator Iterator](#generator-iterator)
  * [Generator Delegation](#generator-delegation)

<!-- tocstop -->

## Asynchrony: Now & Later

A JavaScript program is (practically) always broken up into two or more chunks, where the first chunk runs now and the next chunk runs later, in response to an event. Even though the program is executed chunk-by-chunk, all of them share the same access to the program scope and state, so each modification to state is made on top of the previous state.

Whenever there are events to run, the event loop runs until the queue is empty. Each iteration of the event loop is a "tick." User interaction, IO, and timers enqueue events on the event queue.

At any given moment, only one event can be processed from the queue at a time. While an event is executing, it can directly or indirectly cause one or more subsequent events.

Concurrency is when two or more chains of events interleave over time, such that from a high-level perspective, they appear to be running simultaneously (even though at any given moment only one event is being processed).

It's often necessary to do some form of interaction coordination between these concurrent "processes" (as distinct from operating system processes), for instance to ensure ordering or to prevent "race conditions." These "processes" can also cooperate by breaking themselves into smaller chunks and to allow other "process" interleaving.

```js
// if the processes don't interact, nodeterminism is perfectly acceptable
var res = {};

function foo(results) {
  res.foo = results;
}

function bar(results) {
  res.bar = results;
}

// ajax(..) is some arbitrary Ajax function given by a library
ajax( "http://some.url.1", foo );
ajax( "http://some.url.2", bar );
```

```js
// coordinating ordering interaction
var res = [];

function response(data) {
  if (data.url == "http://some.url.1") {
    res[0] = data;
  }
  else if (data.url == "http://some.url.2") {
    res[1] = data;
  }
}

// ajax(..) is some arbitrary Ajax function given by a library
ajax( "http://some.url.1", response );
ajax( "http://some.url.2", response );
```

```js
// using a "gate" to wait for both processes to finish
var a, b;

function foo(x) {
  a = x * 2;
  if (a && b) { // gate
    baz();
  }
}

function bar(y) {
  b = y * 2;
  if (a && b) { // gate
    baz();
  }
}

function baz() {
  console.log( a + b );
}

// ajax(..) is some arbitrary Ajax function given by a library
ajax( "http://some.url.1", foo );
ajax( "http://some.url.2", bar );
```

```js
// using a "latch" to only use the first process
var a;

function foo(x) {
  if (a == undefined) { // latch
    a = x * 2;
    baz();
  }
}

function bar(x) {
  if (a == undefined) { // latch
    a = x / 2;
    baz();
  }
}

function baz() {
  console.log( a );
}

// ajax(..) is some arbitrary Ajax function given by a library
ajax( "http://some.url.1", foo );
ajax( "http://some.url.2", bar );
```

## Callbacks

Callbacks are the fundamental unit of asynchrony in JS. But they're not enough for the evolving landscape of async programming as JS matures.

First, our brains plan things out in sequential, blocking, single-threaded semantic ways, but callbacks express asynchronous flow in a rather nonlinear, nonsequential way, which makes reasoning properly about such code much harder. Bad to reason about code is bad code that leads to bad bugs.

We need a way to express asynchrony in a more synchronous, sequential, blocking manner, just like our brains do.

Second, and more importantly, callbacks suffer from *inversion of control* in that they implicitly give control over to another party (often a third-party utility not in your control!) to invoke the *continuation* of your program. This control transfer leads us to a troubling list of trust issues, such as whether the callback is called more times than we expect.

Inventing ad hoc logic to solve these trust issues is possible, but it's more difficult than it should be, and it produces clunkier and harder to maintain code, as well as code that is likely insufficiently protected from these hazards until you get visibly bitten by the bugs.

We need a generalized solution to **all of the trust issues**, one that can be reused for as many callbacks as we create without all the extra boilerplate overhead.

We need something better than callbacks. They've served us well to this point, but the *future* of JavaScript demands more sophisticated and capable async patterns. The subsequent chapters in this book will dive into those emerging evolutions.

## Promises

```js
// Promise constructor
var p = new Promise( function(resolve, reject) {
  // resolve(..) to resolve/fulfill the promise
  // reject(..) to reject the promise
} );
```

```js
// Promise.reject(..) is shortcut for creating already-rejected promise
// these two promises are equivalent
var p1 = new Promise( function(resolve, reject) {
  reject( "Oops" );
} );

var p2 = Promise.reject( "Oops" );
```

```js
// Promise.resolve(..) creates an already-fulfilled promise
// and also unwraps thenable values and adopts the final resolution
// either fulfillment or rejection
var fulfilledTh = {
  then: function(cb) { cb( 42 ); }
};
var rejectedTh = {
  then: function(cb, errCb) {
    errCb( "Oops" );
  }
};

var p1 = Promise.resolve( fulfilledTh );
var p2 = Promise.resolve( rejectedTh );

// p1 will be a fulfilled promise
// p2 will be a rejected promise
```

```js
// a promise instance has a then method
p.then( fulfilled, rejected );

// if no rejected callback, then the error is rethrown
p.then( fulfilled );

// if null fulfilled callback, then message is passed along
p.then( null, rejected );

// catch method is equivalent to null fulfilled
p.catch( rejected );
```

`Promise.all([..])`: A "gate" for promises. All promises in the array must be fulfilled for the return promise to fulfill. Returns array of fulfillment values, or the first promise rejection value.

`Promise.race([..])`: A "latch" for promises. The first promise to resolve (fulfillment or rejection) becomes the resolution of the returned promise.

```js
var p1 = Promise.resolve( 42 );
var p2 = Promise.resolve( "Hello World" );
var p3 = Promise.reject( "Oops" );

Promise.race( [p1,p2,p3] )
.then( function(msg) {
  console.log( msg ); // 42
} );

Promise.all( [p1,p2,p3] )
.catch( function(err) {
  console.log( err ); // "Oops"
} );

Promise.all( [p1,p2] )
.then( function(msgs) {
  console.log( msgs ); // [42, "Hello World"]
} );
```

## Generators

Generators are a new ES6 function type that does not run-to-completion like normal functions. Instead, the generator can be paused in mid-completion (entirely preserving its state), and it can later be resumed from where it left off.

This pause/resume interchange is cooperative rather than preemptive, which means that the generator has the sole capability to pause itself, using the yield keyword, and yet the *iterator* that controls the generator has the sole capability (via `next(..)`) to resume the generator.

```js
var x = 1;

function* foo() { // function* marks a generator
  x++;
  yield;          // pause!
  console.log( "x: ", x );
}

function bar() {
  x++;
}

// construct an iterator `it` to control the generator
var it = foo();

// start `foo()` here!
it.next();
x;         // 2
bar();
x;         // 3
it.next(); // x: 3
```

The `yield` / `next(..)` duality is not just a control mechanism, it's actually a two-way message passing mechanism. A `yield ..` expression essentially pauses waiting for a value, and the next `next(..)` call passes a value (or implicit `undefined`) back to that paused `yield` expression.

```js
function* foo(x) {
  var y = x * (yield "Hello"); // <-- yield a value!
  return y;
}

var it = foo( 6 );

var res = it.next(); // first `next()`, don't pass anything
res.value;           // "Hello"

res = it.next( 7 );  // pass `7` to waiting `yield`
res.value;           // 42
```

The key benefit of generators related to async flow control is that the code inside a generator expresses a sequence of steps for the task in a naturally sync/sequential fashion. The trick is that we essentially hide potential asynchrony behind the `yield` keyword -- moving the asynchrony to the code where the generator's *iterator* is controlled.

In other words, generators preserve a sequential, synchronous, blocking code pattern for async code, which lets our brains reason about the code much more naturally, addressing one of the two key drawbacks of callback-based async.

### Multiple Iterators

You can have multiple instances of the same generator running at the same time, and they can even interact.

```js
function* foo() {
  var x = yield 2;
  z++;
  var y = yield (x * z);
  console.log( x, y, z );
}

var z = 1;

var it1 = foo();
var it2 = foo();

var val1 = it1.next().value;        // 2 <-- yield 2
var val2 = it2.next().value;        // 2 <-- yield 2

val1 = it1.next( val2 * 10 ).value; // 40 <-- x:20, z:2
val2 = it2.next( val1 * 5 ).value;  // 6000 <-- x:200, z:3

it1.next( val2 / 2 );               // 20 300 3 <-- y:300
it2.next( val1 / 4 );               // 200 10 3 <-- y:10
```

### Generator Iterator

Running a generator function produces an *iterable* that can be used with a `for..of` loop.

```js
function* something() {
  var nextVal;

  while(true) {
    if (nextVal === undefined) {
      nextVal = 1;
    }
    else {
      nextVal = (3 * nextVal) + 6;
    }
  }

  yield nextVal;
}

for (var v of something()) {
  console.log( v );

  // don't let the loop run forever!
  if (v > 500) {
    break;
  }
}
// 1 9 33 105 321 969
```

### Generator Delegation

```js
function* foo() {
	console.log( "inside `*foo()`:", yield "B" );

	console.log( "inside `*foo()`:", yield "C" );

	return "D";
}

function* bar() {
	console.log( "inside `*bar()`:", yield "A" );

	// `yield`-delegation!
	console.log( "inside `*bar()`:", yield* foo() );

	console.log( "inside `*bar()`:", yield "E" );

	return "F";
}

var it = bar();

console.log( "outside:", it.next().value );
// outside: A

console.log( "outside:", it.next( 1 ).value );
// inside `*bar()`: 1
// outside: B

console.log( "outside:", it.next( 2 ).value );
// inside `*foo()`: 2
// outside: C

console.log( "outside:", it.next( 3 ).value );
// inside `*foo()`: 3
// inside `*bar()`: D
// outside: E

console.log( "outside:", it.next( 4 ).value );
// inside `*bar()`: 4
// outside: F
```
