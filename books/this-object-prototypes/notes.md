# Notes for YDKJS: `this` & Object Prototypes


<!-- toc orderedList:0 depthFrom:2 depthTo:6 -->

* [What is `this`](#what-is-this)
* [Determining what object `this` points to, using the call-stack](#determining-what-object-this-points-to-using-the-call-stack)
  * [1. `new` Binding](#1-new-binding)
  * [2. Explicit Binding](#2-explicit-binding)
  * [3. Implicit Binding](#3-implicit-binding)
  * [4. Default Binding](#4-default-binding)
* [Binding Exceptions](#binding-exceptions)
  * [Safer `this`](#safer-this)
  * [Softening Binding](#softening-binding)
  * [Lexical `this`](#lexical-this)

<!-- tocstop -->


## What is `this`

`this` is neither a reference to the function itself, nor is it a reference to the function's *lexical* scope.

`this` is actually a binding that is made when a function is invoked, and *what* it references is determined entirely by the call-site where the function is called.

**Call-site**: The location in code where a function is called (not where it's declared). This is the previous function in the call-stack.

**Call-stack**: The stack of functions that have been called to get us to the current moment in execution.

```js
function baz() {
  // call-stack is: `baz`
  // so, our call-site is in the global scope

  console.log("baz");
  bar(); // <-- call-site for `bar`
}

function bar() {
  // call-stack is: `baz` -> `bar`
  // so, our call-site is in `baz`

  console.log("bar");
  foo(); // <-- call-site for `foo`
}

function foo() {
  // call-stack is: `baz` -> `bar` -> `foo`
  // so, our call-site is in `bar`

  console.log("foo");
}

baz(); // <-- call-site for `baz`
```

The best way to see the call-stack is to use a debugger.

## Determining what object `this` points to, using the call-stack

**Apply these rules in order**:

### 1. `new` Binding

When a function is invoked with `new` in front of it, the following things are done automatically:

1. a brand new object is created (aka, constructed) out of thin air
2. *the newly constructed object is `[[Prototype]]`-linked*
3. the newly constructed object is set as the `this` binding for that function call
4. unless the function returns its own alternate **object**, the `new`-invoked function call will *automatically* return the newly constructed object.

```js
function foo(a) {
  this.a = a;
}

var bar = new foo(2);
console.log(bar.a); // 2
```

### 2. Explicit Binding

```js
// using `.call` or `.apply`
function foo() {
  console.log(this.a);
}

var obj = {
  a: 2
};

// `.call` passes `obj` to `foo` as `this`
foo.call(obj); // 2

// `.apply` binds `this` in the same way
foo.apply(obj); // 2
```

```js
// using `.bind`
function foo(something) {
  console.log(this.a, something);
  return this.a + something;
}

var obj = {
  a: 2
};

/// `.bind` binds `obj` as `this` anytime `bar` is called
var bar = foo.bind(obj);

var b = bar(3); // 2 3
console.log(b); // 5
```

### 3. Implicit Binding

When there is a context object for a function reference, it's that object which should be used for the function call's `this` binding.

```js
function foo() {
  console.log(this.a);
}

var obj = {
  a: 2,
  foo: foo
};

obj.foo(); // 2
```

### 4. Default Binding

Any other type of call-site results in `this` being the global object - or `undefined` if `strict mode` is in effect.

```js
function foo() {
  console.log(this.a);
}

function bar() {
  "use strict";

  console.log(this.a);
}

var a = 2;

foo(); // 2
bar(); // TypeError: `this` is `undefined`
```

## Binding Exceptions

### Safer `this`

In cases where you want to "safely" ignore a `this` binding, a "DMZ" object is a good placeholder value that protects the `global` object from unintended side-effects.

```js
function foo(a,b) {
  console.log("a:" + a + ", b:" + b);
}

// our DMZ empty object
const ø = Object.create(null);

// spreading out array as parameters
foo.apply( ø, [2, 3] ); // a:2, b:3

// currying
var bar = foo.bind(ø, 2);
bar(3); // a:2, b:3
```

### Softening Binding

```js
// `softBind` function provides a different default for default binding
// while still allowing the function to be able to be manually `this` bound
if (!Function.prototype.softBind) {
  Function.prototype.softBind = function(obj) {
    var fn = this,
      curried = [].slice.call(arguments, 1),
      bound = function bound() {
        return fn.apply(
          (!this ||
            (typeof window !== "undefined" &&
              this === window) ||
            (typeof global !== "undefined" &&
              this === global)
          ) ? obj : this,
          curried.concat.apply(curried, arguments)
        );
      };
    bound.prototype = Object.create(fn.prototype);
    return bound;
  };
}
```

```js
// example usage of `softBind` function
function foo() {
  console.log("name: " + this.name);
}

var obj = { name: "obj" },
    obj2 = { name: "obj2" },
    obj3 = { name: "obj3" };

var fooObj = foo.softBind(obj);

fooObj();                 // name: obj

obj2.foo = foo.softBind(obj);
obj2.foo();               // name: obj2 <---- look!!!

fooObj.call(obj3);        // name: obj3 <---- look!!

setTimeout(obj2.foo, 10); // name: obj  <---- falls back to soft-binding
```

### Lexical `this`

Intead of the four standard binding rules, arrow functions use the lexical scope for `this` binding

```js
function foo() {
  // return an arrow function
  return (a) => {
    // `this` here is lexically adopted from  `foo()`
    console.log(this.a);
  };
}

var obj1 = {
  a: 2
};

var obj2 = {
  a: 3
};

var bar = foo.call(obj1);
bar.call(obj2); // 2, not 3!
```
