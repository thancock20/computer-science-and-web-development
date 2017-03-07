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
* [Iteration](#iteration)
* [Immutability](#immutability)
  * [Getters & Setters](#getters-setters)
* [Faking "Classes" with Mixins](#faking-classes-with-mixins)
* [Prototypes](#prototypes)
  * ["Prototypal" Inheritance](#prototypal-inheritance)
* [Behavior Delegation](#behavior-delegation)

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

```js
var myObject = {};

Object.defineProperty(
  myObject,
  "a",
  // make `a` enumerable, as normal
  {enumerable: true, value: 2}
);

Object.defineProperty(
  myObject,
  "b",
  // make `b` NON-enumerable
  {enumerable: false, value: 3}
);

myObject.b;                           // 3
("b" in myObject);                    // true
myObject.hasOwnProperty("b");         //true

// for..in loop gets object keys
for (var k in myObject) {
  console.log(k, myObject[k]);
}                                     // "a" 2

myObject.propertyisEnumerable("a");   // true
myObject.propertyisEnumerable("b");   // false

Object.keys(myObject);                // ["a"]
Object.getOwnPropertyNames(myObject); // ["a", "b"]
```

## Iteration

```js
// for loop uses indexes to get values from array
var myArray = [1, 2, 3];

for (var i = 0; i < myArray.length; i++) {
  console.log(myArrar[i]);
} // 1 2 3
```

```js
  // forEach(..) iterates over all values in an array,
  // and ignores any callback return values
  var myArray = [1, 2, 3];

  myArray.forEach(function(value) {
    console.log(value);
  });
  // 1
  // 2
  // 3
```

```js
// every(..) keeps iterating until the end
// or the callback returns a falsy value
function isBigEnough(value) {
  return value >= 10;
}

[12, 5, 8, 130, 44].every(isBigEnough);   // false
[12, 54, 18, 130, 44].every(isBigEnough); // true
```

```js
// some(..) keeps iterating until the end
// or the callback returns a truthy value
function isBiggerThan10(value) {
  return value > 10;
}

[2, 5, 8, 1, 4].some(isBiggerThan10);  // false
[12, 5, 8, 1, 4].some(isBiggerThan10); // true
```

```js
// for..of loop iterates over values in an array
var myArray = [1, 2, 3];

for (var value of myArray) {
  console.log(value);
}
// 1
// 2
// 3
```

It's best to use `for..in` loops on Objects, and `for..of` loops on Arrays, because Objects are only iterable if they have defined a custom iterator

```js
var myObject = {
  a: 2,
  b: 3
};

Object.defineProperty( myObject, Symbol.iterator, {
  enumerable: false,
  writable: false,
  configurable: true,
  value: function() {
    var o = this;
    var idx = 0;
    var ks = Object.keys( o );
    return {
      next: function() {
        return {
          value: o[ks[idx++]],
          done: (idx > ks.length)
        };
      }
    };
  }
});

// iterate `myObject` manually
var it = myObject[Symbol.iterator]();
it.next(); // { value:2, done:false }
it.next(); // { value:3, done:false }
it.next(); // { value:undefined, done:true }

// iterate `myObject` with `for..of`
for (var v of myObject) {
    console.log( v );
}
// 2
// 3
```

## Immutability

**Four different nuanced ways to make an object immutable**:
1. Combine `writable:false` and `configurable:false` to create a *constant* as an object property.
2. `Object.preventExtensions(..)` prevents an object from having new properties added to it, but otherwise leaves the rest of the object's properties alone.
3. `Object.seal(..)` essentially calls `Object.preventExtensions(..)` on the object, but also marks all of its existing properties as `configurable:false`. So, no more properties can be added to it and the existing properties cannot be reconfigured or deleted.
4. `Object.freeze(..)` essentially calls `Object.seal(..)` on the object, but also marks all the properties as `writable:false`, so that their values cannot be changed.

### Getters & Setters

```js
var myObject = {
  // define a getter for `a`
  get a() {
    return this._a_;
  },

  // define a setter for `a`
  set a(val) {
    this._a_ = val * 2;
  }
};

myObject.a = 2;

myObject.a;  // 4
```

## Faking "Classes" with Mixins

Classes are a design pattern. Many languages provide syntax which enables natural class-oriented software design. JS also has a similar syntax, but it behaves **very differently** from what you're used to with classes in those other languages.

**Classes mean copies.**

When traditional classes are instantiated, a copy of behavior from class to instance occurs. When classes are inherited, a copy of behavior from parent to child also occurs.

Polymorphism (having different functions at multiple levels of an inheritance chain with the same name) may seem like it implies a referential relative link from child back to parent, but it's still just a result of copy behavior.

JavaScript **does not automatically** create copies (as classes imply) between objects.

The mixin pattern (both explicit and implicit) is often used to *sort of* emulate class copy behavior, but this usually leads to ugly and brittle syntax like explicit pseudo-polymorphism, `(OtherObj.methodName.call(this, ...))`, which often results in harder to understand and maintain code.

Explicit mixins are also not exactly the same as class *copy*, since objects (and functions!) only have shared references duplicated, not the objects/functions duplicated themselves. Not paying attention to such nuance is the source of a variety of gotchas.

In general, faking classes in JS often sets more landmines for future coding than solving present *real* problems.

```js
// vastly simplified `mixin(..)` example:
// libraries often call the utility `extend(..)`
function mixin( sourceObj, targetObj ) {
  for (var key in sourceObj) {
    // only copy if not already present
    if (!(key in targetObj)) {
      targetObj[key] = sourceObj[key];
    }
  }

  return targetObj;
}

var Vehicle = {
  engines: 1,

  ignition: function() {
    console.log( "Turning on my engine." );
  },

  drive: function() {
    this.ignition();
    console.log( "Steering and moving forward!" );
  }
};

var Car = mixin( Vehicle, {
  wheels: 4,

  drive: function() {
    Vehicle.drive.call( this );
    console.log( "Rolling on all " + this.wheels + " wheels!" );
  }
} );
```

## Prototypes

When attempting a property access on an object that doesn't have that property, the object's internal `[[Prototype]]` linkage defines where the `[[Get]]` operation should look next. This cascading linkage from object to object essentially defines a "prototype chain" (somewhat similar to a nested scope chain) of objects to traverse for property resolution.

```js
var anotherObject = {
  a: 2
};

// create an object linked to `anotherObject`
var myObject = Object.create(anotherObject);

// works in lookups
myObject.a;        // 2

// also in for...in loops
for (var k in myObject) {
  console.log("found: " + k);
}                  // found: a

// and with the in operator
("a" in myObject); // true
```

All normal objects have the built-in `Object.prototype` as the top of the prototype chain (like the global scope in scope look-up), where property resolution will stop if not found anywhere prior in the chain. `toString()`, `valueOf()`, and several other common utilities exist on this `Object.prototype` object, explaining how all objects in the language are able to access them.

Three scenarios for the `myObject.foo = "bar"` assignment when `foo` is **not** already on `myObject` directly, but **is** at a higher level of `myObject`'s `[[Prototype]]` chain:

1. If a normal data accessor property named `foo` is found anywhere higher on the `[[Prototype]]` chain, **and it's not marked as read-only (`writable:false`)** then a new property called `foo` is added directly to `myObject`, resulting in a **shadowed property**.
2. If a `foo` is found higher on the `[[Prototype]]` chain, but it's marked as **read-only (`writable:false`)**, then both the setting of that existing property as well as the creation of the shadowed property on `myObject` **are disallowed**. If the code is running in `strict mode`, an error will be thrown. Otherwise, the setting of the property value will silently be ignored. Either way, **no shadowing occurs**.
3. If a `foo` is found higher on the `[[Prototype]]` chain and it's a setter, then the setter will always be called. No `foo` will be added to (aka, shadowed on) `myObject`, nor will the `foo` setter be redefined.

### "Prototypal" Inheritance

The most common way to get two objects linked to each other is using the `new` keyword with a function call, which among its four steps, it creates a new object linked to another object.

The "another object" that the new object is linked to happens to be the object referenced by the arbitrarily named `.prototype` property of the function called with `new.` Functions called with `new` are often called "constructors", despite the fact that they are not actually instantiating a class as *constructors* do in traditional class-oriented languages.

While these JavaScript mechanisms can seem to resemble "class instantiation" and "class inheritance" from traditional class-oriented languages, the key distinction is that in JavaScript, no copies are made. Rather, objects end up linked to each other via an internal `[[Prototype]]` chain.

For a variety of reasons, not the least of which is terminology precedent, "inheritance" (and "prototypal inheritance") and all the other OO terms just do not make sense when considering how JavaScript *actually* works (not just applied to our forced mental models).

Instead, "delegation" is a more appropriate term, because these relationships are not copies but delegation **links.**

```js
// Typical prototype style code
function Foo(name) {
    this.name = name;
}

Foo.prototype.myName = function() {
    return this.name;
};

function Bar(name,label) {
    Foo.call( this, name );
    this.label = label;
}

// here, we make a new `Bar.prototype`
// linked to `Foo.prototype`
Bar.prototype = Object.create( Foo.prototype );

Bar.prototype.myLabel = function() {
    return this.label;
};

var a = new Bar( "a", "obj a" );

a.myName(); // "a"
a.myLabel(); // "obj a"
```

## Behavior Delegation

Classes and inheritance are a design pattern you can *choose*, or *not choose*, in your software architecture. Most developers take for granted that classes are the only (proper) way to organize code, but there's another less-commonly talked about pattern that's actually quite powerful: **behavior delegation**.

Behavior delegation suggests objects as peers of each other, which delegate amongst themselves, rather than parent and child class relationships. JavaScript's `[[Prototype]]` mechanism is, by its very designed nature, a behavior delegation mechanism. That means we can either choose to struggle to implement class mechanics on top of JS, or we can just embrace the natural state of `[[Prototype]]` as a delegation mechanism.

When you design code with objects only, not only does it simplify the syntax you use, but it can actually lead to simpler code architecture design.

**OLOO** (objects-linked-to-other-objects) is a code style which creates and relates objects directly without the abstraction of classes. OLOO quite naturally implements `[[Prototype]]`-based behavior delegation.

```js
// Example OLOO style code
var Task = {
  setID: function(ID) { this.id = ID; },
  outputID: function() { console.log( this.id ); }
};

// make `XYZ` delegate to `Task`
var XYZ = Object.create( Task );

XYZ.prepareTask = function(ID, Label) {
  this.setID( ID );
  this.label = Label;
};

XYZ.outputTaskDetails = function() {
  this.outputID();
  console.log( this.label );
};
```

```js
// Same as above with ES6 concise methods

// Task is declared same as before
var Task = {
  setID(ID) { this.id = ID; },
  outputID() { console.log( this.id; ) }
};

// XYZ is also an object literal
var XYZ = {
  prepareTask(ID, Label) {
    this.setId( ID );
    this.label = Label;
  },
  outputTaskDetails() {
    this.outputID();
    console.log( this.label );
  }
};

// NOW, link `XYZ` to delegate to `Task`
Object.setPrototypeOf( XYZ, Task );
```
