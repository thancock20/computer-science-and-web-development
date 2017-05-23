# Notes for Javascript Allongé, the "Six" Edition


<!-- toc orderedList:0 depthFrom:2 depthTo:6 -->

* [Basic Functions](#basic-functions)
  * [Definitions](#definitions)
  * [Recipes with Basic Functions](#recipes-with-basic-functions)
    * [Partial Application](#partial-application)
    * [Unary](#unary)
    * [Tap](#tap)
    * [Maybe](#maybe)
    * [Once](#once)
    * [Left-Variadic Functions](#left-variadic-functions)
    * [Left-Variadic Destructuring](#left-variadic-destructuring)
    * [Variadic Compose](#variadic-compose)
    * [Pipeline](#pipeline)

<!-- tocstop -->

## Basic Functions

* Functions are values that can be part of expressions, returned from other functions, and so forth.
* Functions are *reference values*.
* Functions are applied to arguments.
* The arguments are passed by sharing, which is also called "pass by value."
* Fat arrow functions have expressions or blocks as their bodies.
* `function` keyword functions always have blocks as their bodies.
* Function bodies have zero or more statements.
* Expression bodies evaluate to the value of the expression.
* Block bodies evaluate to whatever is returned with the `return` keyword, or to `undefined`.
* JavaScript uses `const` to bind values to names within block scope.
* JavaScript uses function declarations to bind functions to names within function scope. Function declarations are "hoisted."
* Function application creates a scope.
* Blocks also create scopes if `const` statements are within them.
* Scopes are nested and free variable references closed over.
* Variables can shadow variables in an enclosing scope.

### Definitions

**Higher-order function:** A function that either takes functions as arguments, or returns a function, or both.

**Combinator:** A higher-order pure function that takes only functions as arguments and returns a function.

```js
// example combinator: compose function
const compose = (a, b) =>
  (c) => a(b(c))

// let's say we have:
const addOne = (number) => number + 1;
const doubleOf = (number) => number * 2;

// with compose, anywhere you would write:
const doubleOfAddOne = (number) => doubleOf(addOne(number));

// you could also write:
const doubleOfAddOne = compose(doubleOf, addOne);
```

**Function decorator:** A higher-order function that takes one function as an argument, returns another function, and the returned function is  a variation of the argument  function.

```js
// ridiculously simple decorator:
const not = (fn) => (x) => !fn(x)

// now instead of:
const nothing = (x) => !something(x);

// you could write:
const nothing = not(something);
```

### Recipes with Basic Functions

#### Partial Application

```js
const callFirst = (fn, larg) =>
  function(...rest) {
    return fn.call(this, larg, ...rest);
  }

const callLast = (fn, rarg) =>
  function(...rest) {
    return fn.call(this, ...rest, rarg);
  }

const greet = (me, you) =>
  `Hello, ${you}, my name is ${me}`;

const heliosSaysHello = callFirst(greet, 'Helios');

heliosSaysHello('Eartha'); // 'Hello, Eartha, my name is Helios'

const sayHelloToCeline = callLast(greet, 'Celine');

sayHelloToCeline('Eartha'); // 'Hello, Celine, my name is Eartha'
```

```js
// partial application with more than one argument
const callLeft = (fn, ...args) =>
  (...remainingArgs) =>
    fn(...args, ...remainingArgs);

const callRight = (fn, ...args) =>
  (...remainingArgs) =>
    fn(...remainingArgs, ...args);
```

#### Unary

**Unary** takes any function and turns it into a function taking exactly one argument.

```js
const unary = (fn) =>
  fn.length === 1
    ? fn
    : function (something) {
      return fn.call(this, something)
    }

// good for passing functions to map
['1', '2', '3'].map(parseInt); // [1, NaN, NaN] -- because index is assumed to be radix

// this works:
['1', '2', '3'].map(unary(parseInt));
```

#### Tap

**Tap** takes a value and returns  a function that always returns the value, but if you pass it a function, it executes the function for side-effects.

```js
const tap = (value, fn) => {
  const curried = (fn) => (
    typeof(fn) === 'function' && fn(value),
    value
  );

  return fn === undefined
    ? curried
    : curried(fn);
}

// now we can write (curried):
tap('espresso')((it) => {
  console.log(`Our drink is '${it}'`)
});
// Our drink is 'espresso'
// 'espresso'

// or (uncurried):
tap('espresso', (it) => {
  console.log(`Our drink is '${it}'`)
});
// Our drink is 'espresso'
// 'espresso'
```

#### Maybe

**Maybe** is a function decorator that will only run the function if none  of the arguments are `null` or `undefined`.

```js
const maybe = (fn) =>
  function (...args) {
    if args.length === 0 {
      return
    }
    else {
      for (let arg of args) {
        if (arg == null) return;
      }
      return fn.apply(this, args)
    }
  }

maybe((a, b, c) => a + b + c)(1, 2, 3); // 6
maybe((a, b, c) => a + b + c)(1, null, 3); // undefined
maybe((a, b, c) => a + b + c)(1, undefined, 3); // undefined

// works nicely with instance methods:
function Model() {};
Model.prototype.setSomething = maybe(function (value) {
  this.something = value;
});
```

#### Once

**Once** is a decorator that ensures a function can only be called once, and thereafter will return `undefined` whenever it is called.

```js
const once = (fn) => {
  let done = false;

  return function () {
    return done ? void 0 : ((done = true), fn.apply(this, arguments));
  }
}

const askedOnBlindDate = once(() => "sure, why not?");

askedOnBlindDate() // 'sure, why not?'
askedOnBlindDate() // undefined
askedOnBlindDate() // undefined
```

#### Left-Variadic Functions

A **variadic function** is a function that is designed to accept a variable number of arguments.

A **right-variadic function** has one or more fixed arguments, and the rest are gathered into the rightmost argument. This is easy in ES6:

```js
const firstAndButFirst = (first, ...butFirst) => [first, butFirst];

firstAndButFirst('why', 'hello', 'there', 'little', 'droid');
// ['why', ['hello', 'there', 'little', 'droid']]
```

A **left-variadic  function** has one or more fixed arguments, and the rest are gathered into the leftmost argument. This needs to be done with a decorator:

```js
const leftVariadic = (fn) => {
  if (fn.length < 1) {
    return fn;
  }
  else {
    return function(...args) {
      const gathered = args.slice(0, args.length - fn.length + 1),
            spread = args.slice(args.length - fn.length + 1);

      return fn.apply(
        this, [gathered].concat.(spread)
      );
    }
  }
};

const butLastAndLast = leftVariadic((butLast, last) => [butLast, last]);

butLastAndLast('why', 'hello', 'there', 'little', 'droid');
// [['why', 'hello', 'there', 'little'], 'droid']
```

#### Left-Variadic Destructuring

Right-variadic destructuring (rest operator):
```js
const [first, ...butFirst] = ['why', 'hello', 'there', 'little', 'droid'];

first; // 'why'
butFirst; // ['hello', 'there', 'little', 'droid']
```

Left-variadic  destructuring (function):
```js
const leftGather = (outputArrayLength) => {
  return function(inputArray) {
    return [inputArray.slice(0, inputArray.length - outputArrayLength + 1)].concat(
      inputArray.slice(inputArray.length - outputArrayLength + 1)
    )
  }
};

const [butLast = last] = leftGather(2)(['why', 'hello', 'there', 'little', 'droid']);

butLast; // ['why', 'hello', 'there', 'little']
last;  // 'droid'
```

#### Variadic Compose

```js
const compose = (...fns) =>
  (value) =>
    fns.reverse().reduce((acc, fn) => fn(acc), value);

// compose(a, b)(value) === a(b(value))
// compose(a, b, c)(value) === a(b(c(value))
// compose(a, b, c, d)(value) === a(b(c(d(value))))
```

#### Pipeline

`compose` is extremely handy, but one thing it doesn't communicate well is the order of operations. Sometimes it makes more sense to compose functions in data flow order. For this, we can use the `pipeline` function.

```js
const pipeline = (...fns) =>
  (value) =>
    fns.reduce((acc, fn) => fn(acc), value);

// pipeline(a, b)(value) === b(a(value));
```
