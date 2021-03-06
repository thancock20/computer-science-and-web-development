# Notes for Javascript Allongé, the "Six" Edition


<!-- toc orderedList:0 depthFrom:2 depthTo:6 -->

* [Basic Functions](#basic-functions)
  * [Higher-order Functions](#higher-order-functions)
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
* [Objects and State](#objects-and-state)
  * [Encapsulating State with Closures](#encapsulating-state-with-closures)
  * [Composition](#composition)
  * [Recipes with Objects and State](#recipes-with-objects-and-state)
    * [Memoize](#memoize)
    * [getWith](#getwith)
    * [pluckWith](#pluckwith)
* [Collections](#collections)
  * [Iteration and Iterables](#iteration-and-iterables)
  * [Operations on Iterables](#operations-on-iterables)
    * [`mapWith`, `filterWith`, and `untilWith`](#mapwith-filterwith-and-untilwith)
    * [`first` and `rest`](#first-and-rest)
    * [`from`](#from)
  * [Generators](#generators)
    * [Iterable Operations Rewritten as Generators](#iterable-operations-rewritten-as-generators)
  * [Lazy Collections](#lazy-collections)
  * [Eager Collections](#eager-collections)
* [Metaobjects](#metaobjects)
  * [Mixins](#mixins)
  * [Forwarding](#forwarding)
  * [Delegation](#delegation)
  * [Prototypes](#prototypes)
* [Constructors and Classes](#constructors-and-classes)
  * [Recipes with Constructors and Classes](#recipes-with-constructors-and-classes)
    * [Bound](#bound)
    * [Send](#send)
    * [Invoke](#invoke)
    * [Instance Eval](#instance-eval)
    * [Fluent](#fluent)
    * [FluentClass](#fluentclass)
* [Higher-order Functions and Methods, Classes, and Objects](#higher-order-functions-and-methods-classes-and-objects)
  * [Higher-order Functions and Methods](#higher-order-functions-and-methods)
  * [Higher-order Functions and Classes](#higher-order-functions-and-classes)
  * [Higher-order Functions and Objects](#higher-order-functions-and-objects)
* [Composing Class Behavior](#composing-class-behavior)
  * [Functional Mixins](#functional-mixins)
  * [Emulating Multiple Inheritance](#emulating-multiple-inheritance)
  * [Preventing Property Conflicts with Symbols](#preventing-property-conflicts-with-symbols)
    * [Decoupling Mixins with Symbols](#decoupling-mixins-with-symbols)
    * [Using Symbols to Reduce Coupled Properties](#using-symbols-to-reduce-coupled-properties)

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

### Higher-order Functions

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
      return fn.call(this, second, first);
    }
    else {
      return function(second) {
        return fn.call(this, second, first);
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

## Objects and State

### Encapsulating State with Closures

Stack implementation that uses encapsulation:
```js
const Stack = () => {
  // state variables hidden in closure
  const array = [];
  let index = -1;

  return {
    push(value) { return array[index += 1] = value },
    pop() {
      const value = array[index];

      array[index] = undefined;
      if (index >= 0) {
        index -= 1;
      }
      return value
    },
    isEmpty() { return index < 0 }
  };
};

const stack = Stack();
stack.isEmpty();          // true
stack.push('Hello');      // 'Hello';
stack.push('JavaScript'); // 'JavaScript'
stack.isEmpty();          // false
stack.pop();              // 'JavaScript'
stack.pop();              // 'Hello'
stack.isEmpty();          // true
```

### Composition

Here's an abstract "model" that supports undo and redo composed from a pair of stacks and an object:
```js
// helper function
//
// For production use, consider what to do about
// deep copies and own keys
const shallowCopy = (source) => {
  const dest = {};

  for (let key in source) {
    dest[key] = source[key]
  }
  return dest
};

const Stack = () => {
  const array = [];
  let index = -1;

  return {
    push (value) {
      array[index += 1] = value
    },
    pop () {
      let value = array[index];
      if (index >= 0) {
        index -= 1
      }
      return value
    },
    isEmpty () {
      return index < 0
    }
  }
}

const Model = function (initialAttributes) {
  const redoStack = Stack();
  let attributes = shallowCopy(initialAttributes || {});

  const undoStack = Stack(),
      obj = {
        set: (attrsToSet) => {
          undoStack.push(shallowCopy(attributes));
          if (!redoStack.isEmpty()) {
            redoStack.length = 0;
          }
          for (let key in (attrsToSet || {})) {
            attributes[key] = attrsToSet[key]
          }
          return obj
        },
        undo: () => {
          if (!undoStack.isEmpty()) {
            redoStack.push(shallowCopy(attributes));
            attributes = undoStack.pop()
          }
          return obj
        },
        redo: () => {
          if (!redoStack.isEmpty()) {
            undoStack.push(shallowCopy(attributes));
            attributes = redoStack.pop()
          }
          return obj
        },
        get: (key) => attributes[key],
        has: (key) => attributes.hasOwnProperty(key),
        attributes: () => shallowCopy(attributes)
      };
    return obj
  };

const model = Model();
model.set({"Doctor": "de Grasse"});
model.get("Doctor");                // "de Grasse"
model.set({"Doctor": "Who"});
model.get("Doctor");                // "Who"
model.undo();
model.get("Doctor");                // "de Grasse"
```

### Recipes with Objects and State

#### Memoize

**Memoize** takes a function and returns a new function that "memoizes" its results so that it never has to recalculate the same value twice. It only works for functions that are "idempotent", meaning functions that always return the same result given the same argument(s).

```js
const memoized = (fn, keymaker = JSON.stringify) => {
  const lookupTable = {};

  return function (...args) {
    const key = keymaker.apply(this, args);

    return lookupTable[key] || (lookupTable[key] = fn.apply(this, args));
  };
};

const fibonacci = (n) =>
  n < 2
    ? n
    : fibonacci(n-2) + fibonacci(n-1);

s = (new Date()).getTime();
fibonacci(45);
( (new Date()).getTime() - s ) / 1000; // 16.994

const fastFibonacci = memoized(
  (n) =>
    n < 2
      ? n
      : fastFibonacci(n-2) + fastFibonacci(n-1)
);

s = (new Date()).getTime();
fastFibonacci(45);
( (new Date()).getTime() - s ) / 1000; // 0.001
```

#### getWith

**getWith** takes the name of an attribute and returns a function that extracts the value of that attribute from an object.

```js
const getWith = (attr) => (object) => object[attr];

const inventory = {
  apples: 0,
  oranges: 144,
  eggs: 36
};

getWith('oranges')(inventory); // 144

const inventories = [
  { apples: 0, oranges: 144, eggs: 36 },
  { apples: 240, oranges: 54, eggs: 12 },
  { apples: 24, oranges: 12, eggs: 42 }
];

mapWith(getWith('oranges'))(inventories); // [ 144, 54, 12 ]
```

#### pluckWith

**pluckWith** is the combination of mapWith and getWith from above.

```js
const pluckWith = (attr) => mapWith(getWith(attr));

// or even better
const pluckWith = compose(mapWith, getWith);

const inventories = [
  { apples: 0, oranges: 144, eggs: 36 },
  { apples: 240, oranges: 54, eggs: 12 },
  { apples: 24, oranges: 12, eggs: 42 }
];

pluckWith('eggs')(inventories); // [ 36, 23, 42 ]
```

## Collections

### Iteration and Iterables

```js
// Stack with an iterator function:
const Stack1 = () =>
  ({
    array:[],
    index: -1,
    push (value) {
      return this.array[this.index += 1] = value;
    },
    pop () {
      const value = this.array[this.index];

      this.array[this.index] = undefined;
      if (this.index >= 0) {
        this.index -= 1
      }
      return value
    },
    isEmpty () {
      return this.index < 0
    },
    iterator () { // iterator function
      let iterationIndex = this.index;

      return () => {
        if (iterationIndex > this.index) {
          iterationIndex = this.index;
        }
        if (iterationIndex < 0) {
          return {done: true};
        }
        else {
          return {done: false, value: this.array[iterationIndex--]}
        }
      }
    }
  });

const stack = Stack1();

stack.push("Greetings");
stack.push("to");
stack.push("you!")

const iter = stack.iterator();
iter().value // "you!"
iter().value // "to"

// function that folds over any object,
// provided that it implements an `.iterator` method:
const collectionSum = (collection) => {
  const iterator = collection.iterator();

  let eachIteration,
      sum = 0;

  while ((eachIteration = iterator(), !eachIteration.done)) {
    sum += eachIteration.value;
  }
  return sum
}

const stack = Stack1();

stack.push(1);
stack.push(2);
stack.push(3);

collectionSum(stack); // 6
```

```js
// Stack with an iterator object:
const Stack2 = () =>
  ({
    array: [],
    index: -1,
    push(value) {
      return this.array[this.index += 1] = value;
    },
    pop() {
      const value = this.array[this.index];

      this.array[this.index] = undefined;
      if  (this.index >= 0) {
        this.index -= 1;
      }
      return value;
    },
    isEmpty() {
      return this.index < 0;
    },
    [Symbol.iterator]() { // this function returns an object
      let iterationIndex = this.index;

      return { // the iterator object
        next: () => {
          if (iterationIndex > this.index) {
            iterationIndex = this.index;
          }
          if (iterationIndex < 0) {
            return {done: true};
          }
          else {
            return {done: false, value: this.array[iterationIndex--]}
          }
        }
      }
    }
  });

const collectionSum = (collection) => {
  const iterator = collection[Symbol.iterator]();

  let eachIteration, sum = 0;

  while ((eachIteration = iterator.next(), !eachIteration.done)) {
    sum += eachIteration.value;
  }
  return sum;
};

const stack = Stack2();

stack.push(2000);
stack.push(10);
stack.push(7);

collectionSum(stack); // 2017

// the [Symbol.iterator] method makes the stack object an iterable as well
const iterableSum = (iterable) => {
  let sum = 0;

  // iterables work with for..of loops
  for (const num of iterable) {
    sum += num;
  }
  return sum;
}

iterableSum(stack); // 2017

// and with the spread operator
[...stack]; // [ 7, 10, 2000 ]
```

### Operations on Iterables

#### `mapWith`, `filterWith`, and `untilWith`

All return an iterable.
```js
const mapWith = (fn, collection) =>
  ({
    [Symbol.iterator]() {
      const iterator = collection[Symbol.iterator]();

      return {
        next() {
          const {done, value} = iterator.next();

          return ({done, value: done ? undefined : fn(value)});
        }
      }
    }
  });

const filterWith = (fn, iterable) =>
  ({
    [Symbol.iterator] () {
      const iterator = iterable[Symbol.iterator]();

      return {
        next() {
          do {
            var {done, value} = iterator.next();
          } while (!done && !fn(value));
          return {done, value};
        }
      }
    }
  });

const untilWith = (fn, iterable) =>
  ({
    [Symbol.iterator] () {
      const iterator = iterable[Symbol.iterator]();

      return{
        next() {
          let {done, value} = iterator.next();

          done = done || fn(value);

          return ({done, value: done ?  undefined : value});
        }
      }
    }
  });

const Numbers = {
  [Symbol.iterator] () {
    let n = 0;

    return {
      next: () => ({done: false, value: n++})
    }
  }
};

const Squares = mapWith((x) => x * x, Numbers);
const EndWithOne = filterWith((x) => x % 10 === 1, Squares);
const UpTo1000 = untilWith((x) => (x > 1000), EndWithOne);

[...UpTo1000]; // [ 1, 81, 121, 361, 441, 841, 961 ]
```

#### `first` and `rest`

```js
const first = (iterable) =>
  iterable[Symbol.iterator]().next().value;

const rest = (iterable) =>
  ({
    [Symbol.iterator]() {
      const iterator = iterable[Symbol.iterator]();

      iterator.next();
      return iterator;
    }
  });

  first(UpTo1000); // 1
  [...rest(UpTo1000)]; // [ 81, 121, 361, 441, 841, 961 ]
  ```

  #### `from`

  ```js
  Stack2.from = function (iterable) {
    const stack = this();

    for (let element of iterable) {
      stack.push(element);
    }
    return stack;
  };

  const stack = Stack2.from([1,2,3,4,5]);
  [...stack]; // [ 5, 4, 3, 2, 1 ]
  ```

  ### Generators

  ```js
const Stack3 = () =>
  ({
    array: [],
    index: -1,
    push(value) {
      return this.array[this.index += 1] = value;
    },
    pop() {
      const value = this.array[this.index];

      this.array[this.index] = undefined;
      if  (this.index >= 0) {
        this.index -= 1;
      }
      return value;
    },
    isEmpty() {
      return this.index < 0;
    },
    *[Symbol.iterator]() { // Generator returns an iterable
      for (let i = this.index; i >= 0; i--) {
        yield this.array[i];
      }
    }
  });

const stack = Stack3();

stack.push(1);
stack.push(2);
stack.push(3);

[...stack]; // [ 3, 2, 1 ]
```

#### Iterable Operations Rewritten as Generators

```js
function * mapWith(fn, iterable) {
  for (const element of iterable) {
    yield fn(element);
  }
}

function * mapAllWith(fn, iterable) {
  for (const element of iterable) {
    yield * fn(element);
  }
}

function * filterWith (fn, iterable) {
  for (const element of iterable) {
    if (!!fn(element)) yield element;
  }
}

function * compact(iterable) {
  for (const element of iterable) {
    if (element != null) yield element;
  }
}

function * untilWith (fn, iterable) {
  for (const element of iterable) {
    if (fn(element)) break;
    yield element;
  }
}

const  first = (iterable) =>
  iterable[Symbol.iterator]().next().value;

function * rest (iterable) {
  const iterator = iterable[Symbol.iterator]();

  iterator.next();
  yield * iterator;
}

function * zip (...iterables) {
  const iterators = iterables.map(i => i[Symbol.iterator]());

  while (true) {
    const pairs = iterators.map(j => j.next()),
          dones = pairs.map(p => p.done),
          values = pairs.map(p => p.value);

    if (dones.indexOf(true) >= 0) break;
    yield values;
  }
};

function * zipWith (zipper, ...iterables) {
  const iterators = iterables.map(i => i[Symbol.iterator]());

  while (true) {
    const pairs = iterators.map(j => j.next()),
          dones = pairs.map(p => p.done),
          values = pairs.map(p => p.value);

    if (dones.indexOf(true) >= 0) break;
    yield zipper(...values);
  }
};

const reduceWith = (fn, seed, iterable) => {
  let accumulator = seed;

  for (const element of iterable) {
    accumulator = fn(accumulator, element);
  }
  return accumulator;
}

function memoize(generator) {
  const memos = {},
        iterators = {};

  return function * (...args) {
    const key = JSON.stringify(args);
    let i = 0;

    if (memos[key] == null) {
      memos[key] = [];
      iterators[key] = generator(...args);
    }

    while (true) {
      if (i < memos[key].length) {
        yield memos[key][i++];
      }
      else {
        const { done, value } = iterators[key].next();

        if (done) {
          return;
        } else {
          yield memos[key][i++] = value;
        }
      }
    }
  }
}
```

### Lazy Collections

```js
const LazyCollection = {
  map(fn) {
    return Object.assign({
      [Symbol.iterator]: () => {
        const iterator = this[Symbol.iterator]();

        return {
          next: () => {
            const {
              done, value
            } = iterator.next();

            return ({
              done, value: done ? undefined : fn(value)
            });
          }
        }
      }
    }, LazyCollection);
  },

  reduce(fn, seed) {
    const iterator = this[Symbol.iterator]();
    let iterationResult,
        accumulator = seed;

    while ((iterationResult = iterator.next(), !iterationResult.done)) {
      accumulator = fn(accumulator, iterationResult.value);
    }
    return accumulator;
  },

  filter(fn) {
    return Object.assign({
      [Symbol.iterator]: () => {
        const iterator = this[Symbol.iterator]();

        return {
          next: () => {
            do {
              var {
                done, value
              } = iterator.next();
            } while (!done && !fn(value));
            return {
              done, value
            };
          }
        }
      }
    }, LazyCollection);
  },

  find(fn) {
    for (let element of this) {
      if (fn(element)) return element;
    }
  },

  until(fn) {
    return Object.assign({
      [Symbol.iterator]: () => {
        const iterator = this[Symbol.iterator]();

        return {
          next: () => {
            let {
              done, value
            } = iterator.next();

            done = done || fn(value);

            return ({
              done, value: done ? undefined : value
            });
          }
        }
      }
    }, LazyCollection);
  },

  first() {
    return this[Symbol.iterator]().next().value;
  },

  rest() {
    return Object.assign({
      [Symbol.iterator]: () => {
        const iterator = this[Symbol.iterator]();

        iterator.next();
        return iterator;
      }
    }, LazyCollection);
  },

  take(numberToTake) {
    return Object.assign({
      [Symbol.iterator]: () => {
        const iterator = this[Symbol.iterator]();
        let remainingElements = numberToTake;

        return {
          next: () => {
            let {
              done, value
            } = iterator.next();

            done = done || remainingElements-- <= 0;

            return ({
              done, value: done ? undefined : value
            });
          }
        }
      }
    }, LazyCollection);
  }
};
```

Example using stack:
```js
const Stack = () =>
  Object.assign({
    array: [],
    index: -1,
    push(value) {
      return this.array[this.index += 1] = value;
    },
    pop() {
      const value = this.array[this.index];

      this.array[this.index] = undefined;
      if  (this.index >= 0) {
        this.index -= 1;
      }
      return value;
    },
    isEmpty() {
      return this.index < 0;
    },
    *[Symbol.iterator]() { // this function returns an object
      for (let i = this.index; i >= 0; i--) {
        yield this.array[i];
      }
    }
  }, LazyCollection);

Stack.from = function(iterable) {
  const stack = this();

  for (let element of iterable) {
    stack.push(element);
  }
  return  stack;
};

Stack.from([1,2,3,4,5,6,7,8,9,10])
  .map((x) => x * x)
  .filter((x) => x % 2 == 0)
  .first(); // 100
```

### Eager Collections

```js
const EagerCollection = (gatherable) => ({
  map(fn) {
    const original = this;

    return gatherable.from(
      (function* () {
        for (let element of original) {
          yield fn(element);
        }
      })()
    );
  },

  reduce(fn, seed) {
    let accumulator = seed;

    for (let element of this) {
      accumulator = fn(accumulator, element);
    }
    return accumulator;
  },

  filter(fn) {
    const original = this;

    return gatherable.from(
      (function* () {
        for (let element of original) {
          if (fn(element)) yield element;
        }
      })()
    );
  },

  find(fn) {
    for (let element of this) {
      if (fn(element)) return element;
    }
  },

  until(fn) {
    const original = this;

    return gatherable.from(
      (function* () {
        for (let element of original) {
          if (fn(element)) break;
          yield element;
        }
      })()
    );
  },

  first() {
    return this[Symbol.iterator]().next().value;
  },

  rest() {
    const iteration = this[Symbol.iterator]();

    iteration.next();
    return gatherable.from(
      (function* () {
        yield * iteration;
      })()
    );
  },

  take(numberToTake) {
    const original = this;
    let numberRemaining = numberToTake;

    return gatherable.from(
      (function* () {
        for (let element of original) {
          if (numberRemaining-- <= 0) break;
          yield element;
        }
      })()
    );
  }
});
```

## Metaobjects

### Mixins

```js
// Separate domain properties:
const sam = {
  firstName: 'Sam',
  lastName: 'Lowry'
};

// from behavior:
const Person = {
  fullName() {
    return this.firstName + " " + this.lastName;
  },

  rename(first, last) {
    this.firstName = first;
    this.lastName = last;
    return this;
  }
};

// Then use Object.assign to mix the behavior in:
Object.assign(sam, Person);

sam.rename; // [Function]

// Methods are "copied" by reference:
sam.fullName === Person.fullName; // true
sam.rename === Person.rename; // true

// Methods are run in the context of the "properties" object:
sam.rename("Joe", "Blow");
sam.firstName;  // 'Joe'
sam.lastName;   // 'Blow'
sam.fullName(); // 'Sam Peckinpah'
```

### Forwarding

```js
// Function to create forwarding:
function forward(receiver, metaobject, ...methods) {
  methods.forEach(function (methodName) {
    receiver[methodName] = (...args) => metaobject[methodName](...args);
  });

  return receiver;
};

// Same property and method functions:
let sam = {
  firstName: 'Sam',
  lastName: 'Lowry'
};

const Person = {
  fullName() {
    return this.firstName + " " + this.lastName;
  },

  rename(first, last) {
    this.firstName = first;
    this.lastName = last;
    return this;
  }
};

// Set up forwarding:
sam = forward(sam, Person, 'fullName', 'rename');

sam.rename; // [Function]

// Methods are forwarded, and therefore not equal:
sam.fullName === Person.fullName; // false
sam.rename === Person.rename; // false

// Methods are run in the context of their original metaobject:
sam.rename('Joe', 'Blow');
sam.firstName;  // 'Sam'
sam.lastName;   // 'Lowry'
sam.fullName(); // 'Joe Blow'
```

### Delegation

```js
// Function to create delegation:
function delegate(receiver, metaobject, ...methods) {
  methods.forEach(function (methodName) {
    receiver[methodName] = (...args) => metaobject[methodName].apply(receiver, args);
  });

  return receiver;
};

// Same property and method functions:
let sam = {
  firstName: 'Sam',
  lastName: 'Lowry'
};

const Person = {
  fullName() {
    return this.firstName + " " + this.lastName;
  },

  rename(first, last) {
    this.firstName = first;
    this.lastName = last;
    return this;
  }
};

// Set up delegation:
sam = delegate(sam, Person, 'fullName', 'rename');

sam.rename; // [Function]

// Methods are delegated, and therefore not equal:
sam.fullName === Person.fullName; // false
sam.rename === Person.rename; // false

// Methods are run in the context of the "properties" object:
sam.rename('Joe', 'Blow');
sam.firstName;  // 'Joe'
sam.lastName;   // 'Blow'
sam.fullName(); // 'Joe Blow'
```

Another version that delegates to one of the receiver's own properties:

```js
// Function to create delegation to own property:
function delegateToOwn(receiver, propertyName, ...methods) {
  methods.forEach(function (methodName) {
    receiver[methodName] = function() {
      const metaobject = receiver[propertyName];
      return metaobject[methodName].apply(receiver,  arguments);
    };
  });

  return receiver;
};

// Property and method functions:
const Person = {
  fullName() {
    return this.firstName + " " + this.lastName;
  },

  rename(first, last) {
    this.firstName = first;
    this.lastName = last;
    return this;
  }
};

let sam = {
  delegateFrom: Person, // Property holds reference to delegated object
  firstName: 'Sam',
  lastName: 'Lowry'
};

// Set up delegation:
sam = delegateToOwn(sam, 'delegateFrom', 'fullName', 'rename');

sam.rename; // [Function]

// Methods are delegated, and therefore not equal:
sam.fullName === Person.fullName; // false
sam.rename === Person.rename; // false

// Methods are run in the context of the "properties" object:
sam.rename('Joe', 'Blow');
sam.firstName;  // 'Joe'
sam.lastName;   // 'Blow'
sam.fullName(); // 'Joe Blow'

// Delegated to metaobject can be changed:
const Dog = {
  fullName: () => 'Spot',
  rename: Person.rename
};
sam.delegateFrom = Dog;

sam.rename; // [Function]

sam.rename('John', 'Doe');
sam.firstName;  // 'John'
sam.lastName;   // 'Doe'
sam.fullName(); // 'Spot'
```

### Prototypes

```js
// Behavior object:
const Person = {
  fullName: function() {
    return this.firstName + " " + this.lastName;
  },

  rename: function(first, last) {
    this.firstName = first;
    this.lastName = last;
    return this;
  }
};

// Set prototype using Object.create:
const sam = Object.create(Person);
sam.firstName = 'Sam';
sam.lastName = 'Lowry';

sam.rename; // [Function]

// Methods are by reference:
sam.fullName === Person.fullName; // true
sam.rename === Person.rename; // true

// Methods are run in context of the "properties" object:
sam.rename("Joe", "Blow");
sam.firstName; // 'Joe'
sam.lastName; // 'Blow'
sam.fullName(); // 'Joe Blow'
```

## Constructors and Classes

* The `new` keyword turns any function into a *constructor* for creating *instances*.
* All functions have a *prototype* element.
* Instances behave as if the elemnt of their constructor's prototype are their element.
* The `class` keyword acts as *syntactic sugar* for writing constructor functions.
* Classes created with the `class` keyword are actually constructor functions with optionally chained prototypes.
* Classes should be used in moderation, the syntax deliberately limits the flexiblity and class hierarchies can lead to overly coupled code.

```js
// Constructor function creates the properties object:
const Person = function (first, last) {
  Object.assign(this, {
    firstName: first,
    lastName: last
  })
};

// Prototype of constructor is the behavior object:
Object.assign(Person.prototype, {
  fullName: function() {
    return this.firstName + " " + this.lastName;
  },

  rename: function(first, last) {
    this.firstName = first;
    this.lastName = last;
    return this;
  }
});

// Use new keyword to create new instance of constructor:
const sam = new Person('Sam', 'Lowry');

sam.rename; // [Function]

// Methods are delegated:
sam.fullName === Person.prototype.fullName; // true
sam.rename === Person.prototype.rename; // true

// Methods are run in the context of the instance object:
sam.rename("Joe", "Blow");
sam.firstName; // 'Joe'
sam.lastName; // 'Blow'
sam.fullName(); // 'Joe Blow'
```

```js
// Class syntax creates constructor function and prototype methods:
class Person {
  constructor (first, last) {
    this.rename(first, last);
  }

  fullName () {
    return this.firstName + " " + this.lastName;
  }

  rename (first, last) {
    this.firstName = first;
    this.lastName = last;
    return this;
  }
};

// Use new keyword to create new instance of class:
const sam = new Person('Sam', 'Lowry');

sam.rename; // [Function]

// Methods are delegated:
sam.fullName === Person.prototype.fullName; // true
sam.rename === Person.prototype.rename; // true

// Methods are run in the context of the instance object:
sam.rename("Joe", "Blow");
sam.firstName; // 'Joe'
sam.lastName; // 'Blow'
sam.fullName(); // 'Joe Blow'
```

### Recipes with Constructors and Classes

#### Bound

**Bound** gets a bound method from an object by name.
```js
const mapWith = (fn) => (list) => list.map(fn);

const bound = (messageName, ...args) =>
  (args === [])
    ? instance => instance[messageName].bind(instance)
    : instance => Function.prototype.bind.apply(
                    instance[messageName], [instance].concat(args)
                  );

class InventoryRecord {
  constructor (apples, oranges, eggs) {
    this.record = {
      apples,
      oranges,
      eggs
    };
  }
  apples() {
    return this.record.apples;
  }
  oranges() {
    return this.record.oranges;
  }
  eggs() {
    return this.record.eggs;
  }
}

const inventories = [
  new InventoryRecord( 0, 144, 36 ),
  new InventoryRecord( 240, 54, 12 ),
  new InventoryRecord( 24, 12, 42 )
];

mapWith(bound('eggs'))(inventories).map(boundmethod => boundmethod());  // [ 36, 12 42 ]
```

#### Send

**Send** invokes a function that's a member of an object.
```js
const send = (methodName, ...args) =>
  (instance) => instance[methodName].apply(instance, args);

mapWith(send('apples'))(inventories); // [ 0, 240, 24 ]
```

#### Invoke

**Invoke** applies a function to an instance. For use as a combinator.
```js
const invoke = (fn, ...args) =>
  instance => fn.apply(instance, args);

const data = [
  { 0: 'zero',
    1: 'one',
    2: 'two',
    length: 3 },
  { 0: 'none',
    length: 1 }
];

mapWith(invoke([].slice, 0))(data); // [ [ 'zero', 'one', 'two' ], [ 'none' ] ]
```

#### Instance Eval

**Instance Eval** is `invoke` written "the other way around".
```js
const instanceEval = instance =>
  (fn, ...args) => fn.apply(instance, args);
```

#### Fluent

**Fluent** is a method decorator, that returns the object itself to allow chaining:
```js
const fluent = (methodBody) =>
  function(...args) {
    methodBody.apply(this, args);
    return this;
  }

const Cake = function() {};

Object.assign(Cake.prototype, {
  setFlavor: fluent(function(flavor) {
    this.flavor = flavor;
  }),
  setLayers: fluent(function(layers) {
    this.layers = layers;
  }),
  bake: fluent(function() {
    console.log(`Baking the ${this.layers} layer ${this.flavor} flavored cake!`);
  })
});

const cake = new Cake()
  .setFlavor('chocolate')
  .setLayers(3)
  .bake(); // 'Baking the 3 layer chocolate flavored cake!'

cake; // Cake { flavor: 'chocolate', layers: 3 }
```

#### FluentClass

**FluentClass** applies the fluent decorator on class methods.
```js
const fluent = (methodBody) =>
  function(...args) {
    methodBody.apply(this, args);
    return this;
  }

const fluentClass = (clazz, ...methodNames) => { // clazz, because class is a reserved word
  for (let methodName of methodNames) {
    clazz.prototype[methodName] = fluent(clazz.prototype[methodName]);
  }
  return clazz;
}

class Cake {
  setFlavor(flavor) {
    this.flavor = flavor;
  }
  setLayers(layers) {
    this.layers = layers;
  }
  bake() {
    console.log(`Baking the ${this.layers} layer ${this.flavor} flavored cake!`);
  }
}

fluentClass(Cake, 'setFlavor', 'setLayers', 'bake');

const cake = new Cake()
  .setFlavor('chocolate')
  .setLayers(3)
  .bake(); // 'Baking the 3 layer chocolate flavored cake!'

cake; // Cake { flavor: 'chocolate', layers: 3 }
```

## Higher-order Functions and Methods, Classes, and Objects

### Higher-order Functions and Methods

In order to make sure higher order functions work with methods of objects we have to use the `function` keyword so that `this` is bound, and then invoke our decorated function using `.call` so that we can pass `this` along.

```js
const compose = (a, b) =>
  function(x) {
    return a.call(this, b.call(this, x));
  }

const not = (fn) =>
  function(x) {
    !fn.call(this, x);
  }
```

### Higher-order Functions and Classes

**FactoryFactory** is an adaptor that turns a function called by `new` into a function that can be composed or decorated.

```js
const FactoryFactory = (clazz) =>
  (...args) =>
    new clazz(...args);

class Circle {
  constructor(radius) {
    this.radius = radius;
  }

  diameter() {
    return Math.PI * 2 * this.radius;
  }

  scaleBy(factor) {
    return new Circle(factor * this.radius);
  }
}

const CircleFactory = FactoryFactory(Circle);

CircleFactory(5).diameter(); // 31.41592653589793

[1,2,3,4,5].map(FactoryFactory(Circle));
// [ Circle { radius: 1 },
// Circle { radius: 2 },
// Circle { radius: 3 },
// Circle { radius: 4 },
// Circle { radius: 5 } ]
```

### Higher-order Functions and Objects

**Dictionary** is a function that turns collections (objects and arrays) into functions that can be composed or decorated.

```js
const Dictionary = (data) => (key) => data[key];

const personToDrink = {
  Bob: 'Ristretto',
  Carol: 'Cappuccino',
  Ted: 'Allongé',
  Alice: 'Cappuccino'
};

['Bob', 'Ted', 'Carol', 'Alice'].map(Dictionary(personToDrink));
// [ 'Ristretto', 'Allongé', 'Cappuccino', 'Cappuccino' ]
```

**IterableDictionary** turns a collection into a function that is also iterable if its underlying data object is iterable.

```js
const IterableDictionary = (data) => {
  const proxy = (key) => data[key];
  proxy[Symbol.iterator] = function* (...args) {
    yield * data[Symbol.iterator](...args);
  }
  return proxy;
};

const people = IterableDictionary(['Bob', 'Ted', 'Carol', 'Alice']);
const drinks = IterableDictionary(personToDrink);

for (let name of people) {
  console.log(`${name} prefers to drink ${drinks(name)}`);
}
// Bob prefers to drink Ristretto
// Ted prefers to drink Allongé
// Carol prefers to drink Cappuccino
// Alice prefers to drink Cappuccino

for (let [name, drink] of Object.entries(personToDrink)) {
  console.log(`${name} prefers to drink ${drinks(name)}`);
}
// Bob prefers to drink Ristretto
// Carol prefers to drink Cappuccino
// Ted prefers to drink Allongé
// Alice prefers to drink Cappuccino
```

## Composing Class Behavior

### Functional Mixins

The charm of the object mixin pattern is its simplicity: It really just needs an object literal and `Object.assign`.

However, behavior defined with the mixin pattern is *slightly* different than behavior defined with the `class` keyword. Two examples of these differences are  enumerability and mixin properties (such as constants and mixin methods like `[Symbol.hasInstance]`).

Functional mixins provide an opportunity to implement such functionality, at the cost of some complexity in the `FunctionalMixin` function that creates functional mixins.

As a general rule, it's best to have things behave as similarly as possible in domain code, and this sometimes does involve some extra complexity in the infrastructure code. But that is more of a guideline than a hard-and-fast rule, and for this reason there is a place for both the object mixin pattern *and* functional mixins in JavaScript.

```js
function FunctionalMixin(behavior, sharedBehavior = {}) {
  const instanceKeys = Reflect.ownKeys(behavior);
  const sharedKeys = Reflect.ownKeys(sharedBehavior);
  const typeTag = Symbol("isA");

  function mixin(target) {
    for (let property of instanceKeys)
      if (!target[property])
        Object.defineProperty(target, property, {
          value: behavior[property],
          writable: true
        })
    target[typeTag] = true;
    return target;
  }

  for (let property of sharedKeys)
    Object.defineProperty(mixin, property, {
      value: sharedBehavior[property],
      enumerable: sharedBehavior.propertyIsEnumerable(property)
    });
  Object.defineProperty(mixin, Symbol.hasInstance, { value: (instance) => !!instance[typeTag] });
  return mixin;
}

class Todo {
  constructor(name) {
    this.name = name || 'Untitled';
    this.done = false;
  }

  do() {
    this.done = true;
    return this;
  }

  undo() {
    this.done = false;
    return this;
  }
}

const Colored = FunctionalMixin({
  setColorRGB({r, g, b}) {
    this.colorCode = {r, g, b};
    return this;
  },

  getColorRGB() {
    return this.colorCode;
  }
},
{
  RED: { r: 255, g: 0, b: 0 },
  GREEN: { r: 0, g: 255, b: 0 },
  BLUE: { r: 0, g: 0, b: 255 }
});

Colored(Todo.prototype);

new Todo('test').setColorRGB({r: 1, g: 2, b: 3});

const urgent = new Todo("finish blog post");
urgent.setColorRGB(Colored.RED);
urgent.getColorRGB(); // { r: 255, g: 0, b: 0 }

// Mixin methods are not enumerable, just like prototype methods:
for (let property in urgent) console.log(property);
// name
// done
// colorCode

urgent instanceof Todo; // true
urgent instanceof Colored; // true
```

### Emulating Multiple Inheritance

**SubclassFactory** emulates multiple inheritance by mixing behavior from a "subclass" in the extended class.

```js
function FunctionalMixin(behavior, sharedBehavior = {}) {
  const instanceKeys = Reflect.ownKeys(behavior);
  const sharedKeys = Reflect.ownKeys(sharedBehavior);
  const typeTag = Symbol("isA");

  function mixin(target) {
    for (let property of instanceKeys)
      if (!target[property])
        Object.defineProperty(target, property, {
          value: behavior[property],
          writable: true
        })
    target[typeTag] = true;
    return target;
  }

  for (let property of sharedKeys)
    Object.defineProperty(mixin, property, {
      value: sharedBehavior[property],
      enumerable: sharedBehavior.propertyIsEnumerable(property)
    });
  Object.defineProperty(mixin, Symbol.hasInstance, { value: (instance) => !!instance[typeTag] });
  return mixin;
}

const SubClassFactory = (behavior) => {
  let mixBehaviorInto = FunctionalMixin(behavior);

  return (superclazz) => mixBehaviorInto(class extends superclazz {});
}

class Todo {
  constructor(name) {
    this.name = name || 'Untitled';
    this.done = false;
  }

  do() {
    this.done = true;
    return this;
  }

  undo() {
    this.done = false;
    return this;
  }

  toHTML() {
    return this.name; // highly insecure
  }
}

const ColoredAsWellAs = SubClassFactory({
  setColorRGB({r, g, b}) {
    this.colorCode = {r, g, b};
    return this;
  },

  getColorRGB() {
    return this.colorCode;
  }
});

let yellow = {r: 'FF', g: 'FF', b: '00'},
    red    = {r: 'FF', g: '00', b: '00'},
    green  = {r: '00', g: 'FF', b: '00'},
    grey   = {r: '80', g: '80', b: '80'};

let oneDayInMilliseconds = 1000 * 60 * 60 * 24;

class TimeSensitiveTodo extends ColoredAsWellAs(Todo) {
  constructor(name, deadline) {
    super(name);
    this.deadline = deadline;
  }

  getColorRGB() {
    let slack = this.deadline - Date.now();

    if (this.done) {
      return grey;
    }
    else if (slack <= 0) {
      return red;
    }
    else if (slack <= oneDayInMilliseconds) {
      return yellow;
    }
    else return green;
  }

  toHTML() {
    let rgb = this.getColorRGB();

    return `<span style="color: #${rgb.r}${rgb.g}${rgb.b};">${super.toHTML()}</span>;`
  }
}

let task = new TimeSensitiveTodo('Finish Javascript Allonge', Date.now() + oneDayInMilliseconds);

task.toHTML(); // '<span style="color: #FFFF00;">Finish Javascript Allonge</span>;'
```

### Preventing Property Conflicts with Symbols

#### Decoupling Mixins with Symbols

```js
// IsBibliophile and IsAuthor both have a 'books' property
// but there is no conflict because they are symbols:
class Person {
  constructor (first, last) {
    this.rename(first, last);
  }
  fullName () {
    return this.firstName + " " + this.lastName;
  }
  rename (first, last) {
    this.firstName = first;
    this.lastName = last;
    return this;
  }
};

const IsBibliophile = (function() {
  const books = Symbol();

  return {
    addToCollection(name) {
      this.collection().push(name);
      return this;
    },
    collection() {
      return this[books] ||  (this[books] = []);
    }
  };
})();

const IsAuthor = (function() {
  const books = Symbol();

  return {
    addBook(name) {
      this.books().push(name);
      return this;
    },
    books() {
      return this[books] || (this[books] = []);
    }
  };
})();

class BookLovingAuthor extends Person { };

Object.assign(BookLovingAuthor.prototype, IsBibliophile, IsAuthor);

const isaac = new BookLovingAuthor('Isaac', 'Asimov')
  .addBook('I Robot')
  .addToCollection('The Mysterious Affair at Styles');

isaac.collection(); // [ 'The Mysterious Affair at Styles' ]
isaac.books();      // [ 'I Robot' ]
```

#### Using Symbols to Reduce Coupled Properties

```js
class Person {
  constructor (first, last) {
    this.rename(first, last);
  }
  fullName () {
    return this.firstName + " " + this.lastName;
  }
  rename (first, last) {
    this.firstName = first;
    this.lastName = last;
    return this;
  }
};

const Bibliophile = (function() {
  // using a symbol in a closure creates a "private" property
  // that discourages direct access to it:
  const books = Symbol("books");

  return class Bibliophile extends Person {
    constructor (first, last) {
      super(first, last);
      this[books] = [];
    }
    addToCollection (name) {
      this[books].push(name);
      return this;
    }
    hasInCollection (name) {
      return this[books].indexOf(name) >= 0;
    }
  }
})();

const bezos = new Bibliophile('Jeff', 'Bezos')
  .addToCollection("The Everything Store: Jeff Bezos and the Age of Amazon");

bezos.hasInCollection("Matthew and the Wellington Boots"); // false
bezos.hasInCollection("The Everything Store: Jeff Bezos and the Age of Amazon"); // true
```
