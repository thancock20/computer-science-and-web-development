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
* [Object Syntax](#object-syntax)
* [Built-in Objects](#built-in-objects)
* [Object Contents](#object-contents)
  * [Computed Property Names](#computed-property-names)
  * [Duplicating Objects](#duplicating-objects)
  * [Property Descriptors](#property-descriptors)
    * [Writable](#writable)
    * [Configurable](#configurable)
    * [Enumerable](#enumerable)

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

## Object Syntax

```js
// Object Literal - preferred
var myObj = {
  key: value
};
```

```js
// Constructed Object - uncommon
var myObj = new Object();
myObj.key = value;
```

## Built-in Objects

**Built-in Object**: An object sub-type that is part of the JavaScript language. Created using a constructor function.

* `String`
* `Number`
* `Boolean`
* `Object`
* `Function`
* `Array`
* `Date`
* `RegExp`
* `Error`

How the built-in objects relate to primitive values:

1. `string`, `number`, and `boolean` primitives are automatically coerced to the object version when needed (e.g. when `"string".length()` is called). So, there is almost never a need to explicitly create the Object form.
2. `null` and `undefined` only exist as primitives. There are no Object forms.
3. `Date` only exists as a constructed object. They have no literal form.
4. `Object`, `Array`, `Function`, and `RegExp` are always objects whether the literal or constructed for is used. **Only use the constructed form if you need the extra options.**
5. `Error` objects are rarely created explicitly in code (with `new Error(..)`), but usually created automatically when exceptions are thrown.

## Object Contents

```js
// Accessing values in an Object using the key/property name
var myObject = {
  a: 2
};

myObject.a;    // 2

myObject["a"]; // 2
```

```js
// Property names are always strings...
var myObject = {
  a: 2
};

// ...Can be stored in a variable
var idx = "a";
myObject[idx] = 2;

// ...Watch out for coercion
myObject[true] = "foo";
myObject[3] = "bar";
myObject[myObject] = "baz";

myObject["true"];            // "foo"
myObject["3"];               // "bar"
myObject["[object Object]"]; // "baz"
```

### Computed Property Names

```js
// An expression, surrounded by a `[]` pair, can be used in the key-name
// position of an object-literal declaration
var prefix = "foo";

var myObject = {
  [prefix + "bar"]: "hello",
  [`${prefix}baz`]: "world"
};

myObject["foobar"]; // hello
myObject["foobaz"]; // world
```

### Duplicating Objects

```js
function anotherFunction() { /*..*/ }

var anotherObject = {
  c: true
};

var anotherArray = [];

var myObject = {
  a: 2,
  b: anotherObject,     // reference, not a copy!
  c: anotherArray,      // another reference!
  d: anotherFunction    // and again!
};

anotherArray.push(anotherObject, myObject);

// Object.assign - first parameter is target object
// other parameters are sources
var newObj = Object.assign({}, myObject);

newObj.a;                      // 2
newObj.b === anotherObject;    // true
newObj.c === anotherArray;     // true
newObj.c === anotherFunction   // true
```

### Property Descriptors

```js
var myObject = {
  a: 2
};

Object.getOwnPropertyDescriptor(myObject, "a");
// {
//   value: 2,
//   writable: true,
//   enumerable: true,
//   configurable: true
// }
```

#### Writable

```js
var myObject = {};

Object.defineProperty(myObject, "a", {
  value: 2,
  writable: false, // not writable!
  configurable: true,
  enumerable: true
});

myObject.a = 3; // Will throw TypeError if in strict mode

myObject.a; // 2
```

#### Configurable

```js
var myObject = {
  a: 2
};

myObject.a = 3;
myObject.a;            // 3

Object.defineProperty(myObject, "a", {
  value: 4,
  writable: true,
  configurable: false, // not configurable!
  enumerable: true
});

myObject.a;            // 4
myObject.a = 5;
myObject.a;            // 5

Object.defineProperty(myObject, "a", {
  value:6,
  writable: true,
  configurable: true,
  enumerable: true
}); // TypeError - regardless of strict mode
```

Two notes about `configurable: false`:
1. `writable` can be changed to `true` from `false` without error, but not back to `true` if already `false`.
2. Prevents the ability to use the `delete` property to remove an existing property.

#### Enumerable

This characteristic controls if a property shows up in certain object-property enumerations, such as the `for..in` loop. (See below).
