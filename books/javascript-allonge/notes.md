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
* [Choice and Truthiness](#choice-and-truthiness)
* [Composing Data](#composing-data)
  * [Linear Recursion](#linear-recursion)
  * [Tail-call Optimization](#tail-call-optimization)
  * [Making Data Out of Functions](#making-data-out-of-functions)
  * [Recipes With Data](#recipes-with-data)
    * [mapWith](#mapwith)
    * [Flip](#flip)
    * [Object.assign](#objectassign)

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

## Choice and Truthiness

* Logical operators are based on truthiness and falsiness, not the strict values `true` and `false`.
  * "falsy" values: `false`, `null`, `undefined`, `NaN`, `0`, and `''`.
* `!` is a logical operator, it always returns `true` or `false`.
* The ternary operator (`?:`), `||`, and `&&` are control flow operators, they do not always return `true` or `false`, and they have short-cut semantics.
  * `&&` evaluates its left-hand expression.
    * If its left-hand expression evaluates to something falsy, `&&` returns the value of its left-hand expression without evaluating its right-hand expression.
    * If its left-hand expression evaluates to something truthy, `&&` evaluates and returns the value of the right-hand expression.
  * `||` evaluates its left-hand expression.
    * If its left-hand expression evaluates to something truthy, `||` returns the value of its left-hand expression without evaluating its right-hand expression.
    * If its left-hand expression evaluates to something falsy, `||` evaluates and returns the value of the right-hand expression.
* Function invocation uses eager evaluation, so if we need to roll our own control-flow semantics, we pass it functions, not expressions.

## Composing Data

### Linear Recursion

1. Divide the problem into smaller problems.
2. If a smaller problem is solvable, solve the small problem.
3. If a smaller problem is not solvable, divide that problem.
4. When all small problems have been solved, compose the solutions into one big solution.

```js
// example recursive function to flatten an array
const flatten = ([first, ...rest]) => {
  if (first === undefined) {
    return [];
  }
  else if (!Array.isArray(first)) {
    return [first, ...flatten(rest)];
  }
  else {
    return [...flatten(first), ...flatten(rest)];
  }
}

flatten(["foo",[3,4,[]]]); // ["foo",3,4]
```

### Tail-call Optimization

Non-optimized factorial function
```js
const factorial = (n) =>
  n == 1
    ? n
    : n * factorial(n - 1);

factorial(1); // 1
factorial(5); // 120
```

Optimized, and including a default argument
```js
const factorial = (n, work = 1) =>
  n === 1
    ? work
    : factorial(n - 1, n * work);

factorial(1); // 1
factorial(5); // 120
```

### Making Data Out of Functions

Linked list implemented entirely with functions
```js
const K = (x) => (y) => x;
const I = (x) => (x);
const V = (x) => (y) => (z) => z(x)(y);

const pairFirst = K,
      pairRest = K(I),
      pair = V;

const EMPTYLIST = (whenEmpty, unlessEmpty) => whenEmpty();

const node = (x) => (y) => (whenEmpty, unlessEmpty) => unlessEmpty(pair(x)(y));

const first = (list) => list(
  () => "ERROR: Can't take the first of an empty list",
  (aPair) => aPair(pairFirst)
);

const rest = (list) => list(
  () => "ERROR: Can't take the rest of an empty list",
  (aPair) => aPair(pairRest)
);

const length = (list) => list(
  () => 0,
  (aPair) => 1 + length(aPair(pairRest))
);

const print = (list) => list(
  () => "",
  (aPair) => `${aPair(pairFirst)} ${print(aPair(pairRest))}`
);

const reverse = (list, delayed = EMPTYLIST) => list(
  () => delayed,
  (aPair) => reverse(aPair(pairRest), node(aPair(pairFirst))(delayed))
);

const mapWith = (fn, list, delayed = EMPTYLIST) => list(
  () => reverse(delayed),
  (aPair) => mapWith(fn, aPair(pairRest), node(fn(aPair(pairFirst)))(delayed))
);
```

Takeaways:
1. Instead of directly  manipulating part of an entity, pass it a function and have it call the function with the part you want.
2. And instead of testing some property of an entity and making a choice of your own with `?:` (or `if`), pass the entity the work you want done for each case and let it test itself.

### Recipes With Data

#### mapWith

**mapWith** differs from `map` in two ways. It reverses the arguments, taking the function first and the list second. It also "curries" the function: Instead of taking  two arguments, it takes one argument and retuns a function that takes another argument.

```js
const mapWith = (fn) => (list) => list.map(fn);

const squaresOf = mapWith(n => n * n);

squaresOf([1,2,3,4,5]); // [1,4,9,16,25]
```

#### Flip

**Flip** switches the arguments of a function. This can either be curried or uncurried.
```js
const flip = (fn) =>
  function(first, second) {
    if (arguments.length === 2) {
      return fn(second, first);
    }
    else {
      return function(second) {
        return fn(second, first);
      };
    };
  };

const subtract = (x,y) => x-y;
subtract(2,1); // 1

const flippedSubtract = flip(subtract);
flippedSubtract(1,2); // 1

const subtractOne = flip(subtract)(1);
subtractOne(2); // 1
```

#### Object.assign

**Object.assign** is a standard function. It can be used to copy an object  by extending an empty object:

```js
Object.assign({}, {
  apples: 12,
  oranges: 12
});
// { apples: 12, oranges: 12 }
```

It can also extend one object with another:

```js
const inventory = {
  apples: 12,
  oranges: 12
};

const shipment = {
  bananas: 54,
  pears: 24
};

// note: this mutates inventory
Object.assign(inventory, shipment);
// { apples: 12,
//   oranges: 12,
//   bananas: 54,
//   pears: 24 }
```
