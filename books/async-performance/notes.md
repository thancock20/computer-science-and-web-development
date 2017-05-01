# Notes for Async & Performance


<!-- toc orderedList:0 depthFrom:2 depthTo:6 -->

* [Asynchrony: Now & Later](#asynchrony-now-later)

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
  if (a == undefined) {
    a = x * 2;
    baz();
  }
}

function bar(x) {
  if (a == undefined) {
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
