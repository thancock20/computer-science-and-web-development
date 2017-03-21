# Notes From CS50

<!-- toc orderedList:0 depthFrom:2 depthTo:6 -->

* [Week 0](#week-0)
* [Week 1](#week-1)
  * [Data Types](#data-types)
  * [Variables](#variables)
  * [Arithmetic Operators](#arithmetic-operators)
  * [Boolean Expressions](#boolean-expressions)
  * [Conditionals](#conditionals)
  * [Loops](#loops)
* [Week 2](#week-2)
  * [Functions](#functions)
  * [Variables and Scope](#variables-and-scope)
  * [Arrays](#arrays)
  * [Command Line Arguments](#command-line-arguments)
  * [Magic Numbers](#magic-numbers)
* [Week 3](#week-3)
  * [Computational Complexity](#computational-complexity)
  * [Bubble Sort](#bubble-sort)
  * [Selection Sort](#selection-sort)
  * [Insertion Sort](#insertion-sort)
  * [Merge Sort](#merge-sort)
  * [Linear Search](#linear-search)
  * [Binary Search](#binary-search)
* [Week 4](#week-4)
  * [Hexadecimal](#hexadecimal)
  * [Pointers](#pointers)
  * [Dynamic Memory Allocation](#dynamic-memory-allocation)
  * [Structures](#structures)
  * [Defining Custom Types](#defining-custom-types)
  * [Recursion](#recursion)
  * [Call Stack](#call-stack)

<!-- tocstop -->

## Week 0

[Lecture Notes](http://docs.cs50.net/2016/fall/notes/0/week0.html)

## Week 1

[Lecture Notes](http://docs.cs50.net/2016/fall/notes/1/week1.html)

### Data Types

* `int`
  * The `int` data type is used for variables that will store integers.
  * Integers always take up 4 bytes of memory (32 bits). This means the range of values they can store is necessarily limited to 32 bits worth of information.
* `unsigned int`
  * `unsigned` is a *qualifier* that can be applied to certain types (including `int`), which effectively doubles the positive range of variables of that type, at the cost of disallowing any negative values.
* `char`
  * The `char` data type is used for variables that will store single characters.
  * Characters always take up 1 byte of memory (8 bits). This means the range of values they can store is necessarily limited to 8 bits worth of information.
  * Thanks to ASCII, we've developed a mapping of characters like A, B, C, etc... to numeric values in the positive side of this range.
* `float`
  * The `float` data type is used for variables that will store floating-point values, also known as *real numbers*
  * Floating point values always take up 4 bytes of memory (32 bits).
  * It's a little complicated to describe the range of a `float`, but suffice it to say with 32 bits of precision, some of which might be used for an integer part, we are limited in how *precise* we can be.
* `double`
  * The `double` data type is used for variables that will store floating-point values, also known as `real numbers`.
  * The difference is that doubles are *double precision*. They always take up 8 bytes of memory (64 bits).
  * With an additional 32 bits of precision relative to a `float`, doubles allow us to specify more precise real numbers.
* `void`
  * Is a type, but not a *data type*.
  * Functions can have a `void` return type, which just means they don't return a value.
  * The parameter list of a function can also be `void`. It simply means the function takes no parameters.

### Variables

* Creating a variable
  * To bring a variable into existence, you need simply specify the data type of the variable and give it a name.
  ```c
  int number;
  char letter;
  ```
  * If you wish to create multiple variables of the same type, you specify the type name *once*, and then list as many variables of that type as you want.
  ```c
  int height, width;
  float sqrt2, sqrt3, pi;
  ```
  * In general, it's good practice to only *declare* variables when you need them.
* Using a variable
  * After a variable has been *declared*, it's no longer necessary to specify that variable's type. (In fact, doing so has some unintended consequences!)
  ```c
  int number;     // declaration
  number = 17;    // assignment
  char letter;    // declaration
  letter = 'H';   // assignment
  ```
  * If you are simultaneously declaring and setting the value of a variable (sometimes called *initializing*), you can consolidate this to one step.
  ```c
  int number = 17;    // initialization
  char letter = 'H';  // initialization
  ```

### Arithmetic Operators

* In C we can add (+), subtract (-), multiply (*) and divide (/) numbers, as expected.
```c
int x = y + 1;
x = x * 5;
```
* We also have the modulus operator (%), which gives us the remainder when the number on the left of the operator is divided by the number on the right.
```c
int m = 13 % 4; // m is now 1
```
* C also provides a shorthand way to apply an arithmetic operator to a single variable.
```c
x = x * 5;
x *= 5;
```
* This trick works with all five basic arithmetic operators. C provides a further shorthand for incrementing or decrementing a variable by 1:
```c
x++;
x--;
```

### Boolean Expressions

* Boolean expressions are used in C for comparing values.
* All Boolean expressions in C evaluate to one of two possible values---`true` or `false`.
* We can use the result of evaluating a Boolean expression in other programming constructs such as deciding which branch in a *conditional* to take, or determining whether a *loop* should continue to run.
* In C, *every* nonzero value is equivalent to `true`, and zero is `false`.
* Two main types of Boolean expressions:
  * Logical Operators
    * Logical AND (`&&`) is true if and only if both operands are true, otherwise false.

    | x     | y     | (x && y) |
    |:------|:------|:---------|
    | true  | true  | true     |
    | true  | false | false    |
    | false | true  | false    |
    | false | false | false    |

    * Logical OR (`||`) is true if and only if at least one operand is true, otherwise false.

    | x     | y     | (x && y) |
    |:------|:------|:---------|
    | true  | true  | true     |
    | true  | false | true     |
    | false | true  | true     |
    | false | false | false    |

    * logical NOT (`!`) inverts the value of the operand.

    | x     | !x    |
    |:------|:------|
    | true  | false |
    | false | true  |

  * Relational Operators
    * Less  than (`x < y`)
    * Less than or equal to (`x <= y`)
    * Greater than (`x > y`)
    * Greater than or equal to (`x >= y`)
    * Equality (`x == y`)
    * Inequality (`x != y`)

### Conditionals

```c
// If the boolean-expression evaluates to `true`, all lines of code between the curly braces will execute in order from top-to-bottom
// If the boolean-expression evaluates to `false`, those lines of code will not execute.

if (boolean-expression)

{

}
```

```c
// If the boolean-expression evaluates to `true`, all lines of code between the first set of curly braces will execute in order from top-to-bottom.
// If the boolean-expression evaluates to `false`, all lines of code between the second set of curly braces will execute in order from top-to-bottom.

if (boolean-expression)
{

}
else
{

}
```
```c
// Conditional statement that permits enumeration of discrete cases, instead of relying on Boolean expressions.

int x = GetInt();
switch(x)
{
  case 1:
    printf("One!\n");
    // It's important to break between each case, or you will fall through each case
    break;
  case 2:
    printf("Two!\n");
    break;
  case 3:
    printf("Three!\n");
    break;
  default:
    printf("Sorry!\n");
}
```

```c
// These two snippets of code act identically
// this ...
int x;
if (expr)
{
  x = 5;
}
else
{
  x = 6;
}

// ... and this ...
int x = (expr) ? 5 : 6;
```

### Loops

```c
// If the boolean-expression evaluates to true, all lines of code between the curly braces will execute repeatedly, in order from top-to-bottom, until boolean-expression evaluates to false.

while (boolean-expression)
{

}
```

```c
// This loop will execute all lines of code between the curly braces once, and then, if the boolean-expression evaluates to true, will go back and repeat the process until boolean-expression evaluates to false.

do
{

}
while (boolean-expression);
```

```c
// Repeats the body of the loop 10 times

for (int i = 0; i < 10; i++)
{

}
```

## Week 2

[Lecture Notes](http://docs.cs50.net/2016/fall/notes/2/week2.html)

### Functions

```c
// Function declaration
// Should be above main function
int add_two_ints(int x, int y);

// Function definition
// Usually below main function
int add_two_ints(int x, int y)
{
  return x + y;
}
```

### Variables and Scope

```c
// Variable in the global scope
int x = 0;

int main(void)
{
  // Variable in the local to main scope
  int x = 0;
}
```

### Arrays

```c
// instantiation syntax
int truthtable[3] = { 0, 1, 1 };

// individual element syntax
bool truthtable[3];
truthtable[0] = 0;
truthtable[1] = 1;
truthtable[2] = 1;
```

### Command Line Arguments

```c
// Program with no command line arguments
int main(void)
{

}

// Program with command line arguments
int main(int argc, string argv[])
{
  // argc is argument count
  // argv is argument vector
  // argv[0] is always name of program
}
//
```

### Magic Numbers

```c
// In order to define symbolic constant
// Preprocessor replaces COUNT with 52 throughout file
#define COUNT 52
```

## Week 3

[Lecture Notes](http://docs.cs50.net/2016/fall/notes/3/week3.html)

### Computational Complexity

* In order to make the most effective use of our computational resources, it's important that we have the skill set to analyze the complexity of algorithms, so we know what resources those algorithms require.
* Being able to analyze an algorithm allows us to have an idea of how well it scales as we throw larger and larger data sets at it.
* When we talk about the complexity of an algorithm, we generally refer to the **worst-case scenario**. (We refer to this as O).
* We sometimes also care about the **best-case scenario** (also known as Ω).
* In CS50, we'll leave rigorous analysis aside and focus more on reasoning complexity with common sense.
* What is a data set?
  * Whatever makes the most sense in context.
* We can measure an algorithm based on how it handles these inputs. Let's call this measure *f(n)*.
* We don't actually care about what *f(n)* is precisely. Rather, we care only about its **tendency**, which is dictated by its highest-order term.

|                    |                   |
|:-------------------|:------------------|
| *O(1)*             | constant time     |
| *O(log n)*         | logarithmic time  |
| *O(n)*             | linear time       |
| *O(n log n)*       | linearithmic time |
| *O(n<sup>2</sup>)* | quadratic time    |
| *O(n<sup>c</sup>)* | polynomial time   |
| *O(c<sup>n</sup>)* | exponential time  |
| *O(n!)*            | factorial time    |
| *O(∞)*             | infinite time     |

* *O(1)* - Always takes a single operation in the worst case.
  ```c
  int four_for_you(int array[1000])
  {
    return 4;
  }

  int add_two_nums(int a, int b)
  {
    return a + b;
  }
  ```
* *O(n)* - Always takes *n* operations in the worst case.

### Bubble Sort

In bubble sort, the idea of the algorithm is to move higher valued elements generally towards the right and lower value elements generally towards the left.

**In pseudocode:**
* Set swap counter to a non-zero value
* Repeat until the swap counter is 0:
  * Reset swap counter to 0
  * Look at each adjacent pair
    * If two adjacent elements are not in order, swap them and add one to the swap counter

**Worst-case scenario**: ***O(n<sup>2</sup>)*** - The array is in reverse order; we have to "bubble" each of the *n* elements all the way across the array, and since we can only fully one element into position per pass, we must do this *n* times.

**Best-case scenario**: ***Ω(n)*** - The array is already perfectly sorted, and we make no swaps on the first pass.

### Selection Sort

In selection sort, the idea of the algorithm is to find the smallest sorted element and add it to the end of the sorted list.

**In pseudocode**
* Repeat until no unsorted elements remain:
  * Search the unsorted part of the data to find the smallest value
  * Swap the smallest found value with the first element of the unsorted part

**Worst-case scenario**: ***O(n<sup>2</sup>)*** - We have to iterate over each of the *n* elements of the array (to find the smallest unsorted element) and we must repeat this process *n* times, since only one element gets sorted each pass.

**Best-case scenario**: ***Ω(n<sup>2</sup>)*** - Exactly the same! There's no way to guarantee the array is sorted until we go through this process for all the elements.

### Insertion Sort

In insertion sort, the idea of the algorithm is to build your sorted array in place, shifting elements out of the way if necessary to make room as you go.

**In pseudocode:**
* Call the first element of the array "sorted."
* Repeat until all the elements are sorted:
  * Look at the next unsorted element. Insert into the "sorted" portion by shifting the requisite number of elements.

**Worst-case scenario**: ***O(n<sup>2</sup>)*** - The array is in reverse order; we have to shift each of the *n* elements *n* positions each time we make an insertion.

**Best-case scenario**: ***Ω(n)*** - The array is already perfectly sorted, and we simply keep moving the line between "unsorted" and "sorted" as we examine each element.

### Merge Sort

In merge sort, the idea of the algorithm is to sort smaller arrays and then combine those arrays together (merge them) in sorted order.

**In pseudocode:**
* Sort the left half of the array (assuming *n > 1*)
* Sort the right half of the array (assuming *n > 1*)
* Merge the two halves together

**Worst-case scenario**: ***O(n log n)*** - We have to split *n* elements up and then recombine them, effectively doubling the sorted subarrays as we build them up. (combining sorted 1-element arrays into 2-element array, combining 2-element arrays into 4-element arrays, etc.)

**Best-case scenario**: ***Ω(n log n)*** - The array is already perfectly sorted. But we still have to split and recombine it back together with this algorithm.

### Linear Search

In linear search, the idea of the algorithm is to iterate across the array from left to right, searching for a specified element.

**In pseudocode:**
* Repeat, starting at the first element:
  * If the element is what you're looking for (the target), stop.
  * Otherwise, move to the next element.

**Worst-case scenario**: ***O(n)*** - We have to look through the entire array of *n* elements, either because the target element is the last element of the array or doesn't exist in the array at all.

**Best-case scenario**: ***Ω(1)*** - The target element is the first element of the array, and so we can stop looking immediately after we start.

### Binary Search

In binary search, the idea of the algorithm is to divide and conquer, reducing the search area by half each time, trying to find a target number. In order to the leverage this power, however, **our array must first be sorted**, else we cannot make assumptions about the array's contents.

**In pseudocode:**
* Repeat until the (sub)array is of size 0:
  * Calculate the middle point of the current (sub)array.
  * If the target is at the middle, stop.
  * Otherwise, if the target is less than what's at the middle, repeat, changing the end point to be just left of the middle.
  * Otherwise, if the target is greater than what's at the middle, repeat, changing the start point to be just to the right of the middle.

**Worst-case scenario**: ***O(log n)*** - We have to divide a list of *n* elements in half repeatedly to find the target element, either because the target element will be found at the end of the last division or doesn't exist in the array at all.

**Best-case scenario**: ***Ω(1)*** - The target element is at the midpoint of the full array, and so we can stop looking immediately after we start.

## Week 4

[Lecture Notes](http://docs.cs50.net/2016/fall/notes/4/week4.html)

### Hexadecimal

* Most Western cultures use the decimal system, aka *base-10*, to represent numeric data.
```
0 1 2 3 4 5 6 7 8 9
```
* Computers use the binary system, aka *base-2*, to represent numeric (and indeed all) data.
```
0 1
```
* As computer scientists, it's useful to be able to express data the same way the computer does.
* The problem, of course, is that trying to parse a huge chain of 0s and 1s can be quite difficult.
* The **hexadecimal system**, aka *base-16*, is a much more concise way to express the data on a computer's system.
```
0 1 2 3 4 5 6 7 8 9 A B C D E F
```
* Hexadecimal makes this mapping easy because a group of four binary digits (bits) has 16 different combinations, and each of those combinations maps to a single hexadecimal digit.

| Decimal | Binary | Hexadecimal |
|:--------|:-------|:------------|
| 0       | 0000   | 0x0         |
| 1       | 0001   | 0x1         |
| 2       | 0010   | 0x2         |
| 3       | 0011   | 0x3         |
| 4       | 0100   | 0x4         |
| 5       | 0101   | 0x5         |
| 6       | 0110   | 0x6         |
| 7       | 0111   | 0x7         |
| 8       | 1000   | 0x8         |
| 9       | 1001   | 0x9         |
| 10      | 1010   | 0xA         |
| 11      | 1011   | 0xB         |
| 12      | 1100   | 0xC         |
| 13      | 1101   | 0xD         |
| 14      | 1110   | 0xE         |
| 15      | 1111   | 0xF         |

* Just like binary has place values (1, 2, 4, 8...) and decimal does too (1, 10, 100, 1000...), so does hexadecimal.

| 16<sup>2</sup> | 16<sup>1</sup> | 16<sup>0</sup> | Equals |
|:---------------|:---------------|:---------------|:-------|
| 3 (3 * 256)    | 9 (9 * 16)     | 7 (7 * 1)      | 919    |
| A (10 * 256)   | D (13 * 16)    | C (12 * 1)     | 2780   |

* To convert a binary number to hexadecimal, group four bits together from right to left. Pad the leftmost group with extra 0 bits at the front if necessary. Then use the chart above to convert those bits to something a bit more concise.
```
   01000110101000101011100100111101

0100 0110 1010 0010 1011 1001 0011 1101

  4    6    A    2    B    9    3    D

                0x46A2B93D
```

### Pointers

* Pointers provide an alternative way to pass data between functions.
  * Recall that up to this point, we have passed all data **by value**, with one exception (arrays).
  * When we pass data by value, we only pass a copy of that data.
* If we use pointers instead, we have the power to pass the actual variable itself.
  * That means that a change that is made in one function *can* impact what happens in a different function.
  * Previously, this wasn't possible!
* Before we dive into what pointers are and how to work with them, it's worth going back to basics and have a look at our computer's memory.
* Every file on your computer lives on your disk drive, be it a hard disk drive (HDD) or a solid-state drive (SSD).
* Disk drives are just storage space; we can't directly work there. Manipulation and use of data can only take place in RAM, so we have to move data there.
* Memory is basically a huge array of 8-bit wide bytes.
  * 512MB, 1GB, 2GB, 4GB...

| Data Type | Size (in bytes) |
|:----------|:----------------|
| int       | 4               |
| char      | 1               |
| float     | 4               |
| double    | 8               |
| long long | 8               |
| string    | ???             |

* Back to this idea of memory as a big array of byte-sized cells.
* Recall from our discussion of arrays that they not only are useful for storage of information but also for so-called **random access*
  * We can access individual elements of the array by indicating which index location we want.
* Similarly, each location in memory has an **address**.
* There's only one critical thing to remember as we start working with pointers:
  * ***POINTERS ARE JUST ADDRESSES***
* A **pointer**, then, is a data item whose
  * *value* is a memory address
  * *type* describes the data located at that memory address
* As such, pointers allow data structures and/or variables to be shared among functions.
* Pointers make a computer environment more like the real world.
* The simplest pointer available to us in C is the NULL pointer. This pointer points to nothing (a fact which can actually come in handy!)
* When you create a pointer and you don't set its value immediately, you should **always** set the value of the pointer to NULL.
* You can check whether a pointer is NULL using the equality operator (**==**).
* Another easy way to create a pointer is simply to **extract** the address of an already existing variable. We can do this with the address extraction operator (**&**).
* If *x* is an int-type variable, then *&x* is a pointer-to-int whose value is the address of *x*.
* if *arr* is an array of doubles, then *&arr[i]* is a pointer-to-double whose value is the address of the *i*<sup>th</sup> element of *arr*.
  * An array's name, then, is actually just a pointer to its first element.
* The main purpose of a pointer is to allow us to modify or inspect the location to which it points. We do this by **dereferencing** the pointer.
* If we have a pointer-to-char called *pc*, then **pc* is the data that lives at the memory address stored inside the variable *pc*.
* Used in this context, `*` is known as the **dereference operator**.
* It "goes to the reference" and accesses the data at that memory location, allowing you to manipulate it at will.
* What happens if we try to dereference a pointer whose value is NULL?
  * **Segmentation fault**
* Surprisingly, this is actually good behavior! It defends against accidental dangerous manipulation of unknown pointers.
  * That's why you should set your pointers to NULL immediately if you aren't setting them to a known, desired value.

### Dynamic Memory Allocation

* We can use pointers to get access to a block of **dynamically-allocated memory** at runtime.
* Dynamically allocated memory comes from a pool of memory known as the **heap**.
* Prior to this point, all memory we've been working with has been coming from a pool of memory known as the **stack**.
* We get this dynamically-allocated memory by making a call to the C standart library function `malloc()`, by passing as its parameter the number of bytes requested.
* After obtaining memory for you (if it can), `malloc()` will return a pointer to that memory.
* If `malloc()` **can't** give you memory it'll return NULL.

```c
// statically obtain an integer
int x;

// dynamically obtain an integer
int *px = malloc(sizeof(int));

// array of floats on the stack
float stack_array[x];

// array of floats on the heap
float *heap_array = malloc(x * sizeof(float));
```

* Here's the trouble: Dynamically-allocated memory is not automatically returned to the system for later use when the function in which it's created finishes execution.
* Failing to return memory back to the system when you're finished with it results in a **memory leak** which can compromise your system's performance.
* When you finish working with dynamically-allocated memory, you must `free()` it.

```c
char *word = malloc(50 * sizeof(char));

// do stuff with word

// now we're done working with that block
free(word);
```

* Three golden rules:
    1. Every block of memory that you `malloc()` must subsequently be `free()`d.
    2. Only memory that you `malloc()` should be `free()`d.
    3. Do not `free()` a block of memory more than once.

### Structures

* Structures provide a way to unify several variables of different types into a single, new variable type which can be assigned its own type name.
* We use structures (structs) to group together elements of a variety of data types that have a logical connection.
* Think of a structure like a "super-variable".

```c
struct car
{
  int year;
  char model[10];
  char plate[7];
  int odometer;
  double engine_size;
};
```

* Once we have defined a structure, which we typically do in separate .h files or atop our programs outside of any functions, we have effectively created a new type.
* That means we can create variables of that type using familiar syntax.
* We can also access the various **fields** (also known as **members**) of the structure using the dot operator (`.`)

```c
// variable declaration
struct car mycar;

// field accessing
mycar.year = 2011;
mycar.plate = "CS50";
mycar.odometer = 50505;
```

* Structures, like variables of other data types, do not need to be created on the stack. We can dynamically allocate structures at run time if our program requires it.
* In order to access the fields of our structures in that situation, we first need to dereference the pointer to the structure, and then we can access its fields.

```c
//variable declaration
struct car *mycar = malloc(sizeof(struct car));

// field accessing
(*mycar).year = 2011;
(*mycar).plate = "CS50";
(*mycar).odometer = 50505;
```

* This is a little annoying. And so as you might expect, there's a shorter way!
* The arrow operator (`->`) makes this process easier. It's an operator that does two things back-to-back:
  * First, it **dereferences** the pointer on the left side of the operator.
  * Second, it **accesses** the field on the right side of the operator.

```c
// variable declaration
struct car *mycar = malloc(sizeof(struct car));

// field accessing
mycar->year = 2011;
mycar->plate = "CS50";
mycar->odometer = 50505;
```

### Defining Custom Types

* The C keyword `typedef` provides a way to create a shorthand or rewritten name for data types.
* The basic idea is to first define a type in the normal way, then alias it to something else.

```c
typedef <old name> <new name>;

typedef unsigned char byte;

typedef char* string;
```

```c
typedef struct car
{
  int year;
  char model[10];
  char plate[7];
  int odometer;
  double engine_size;
}
car_t;

// variable declaration
car_t mycar;
```

### Recursion

* We might describe an implementation of an algorithm as being particularly "elegant" if it solves a problem in a way that is both interesting and easy to visualize.
* The technique of **recursion** is a very common way to implement such an "elegant" solution.
* The definition of a recursive function is one that, as part of its execution, invokes itself.
* Every recursive function has two cases that could apply, given any input.
  * The *base case*, which when triggered will terminate the recursive process.
  * The *recursive case*, which is where the recursion will actually occur.

```c
// factorial function
int fact(int n)
{
  if (n == 1)
    return 1;
  else
    return n * fact(n-1);
}
```

* In general, but not always, recursive functions replace loops in non-recursive function.

```c
int fact2(int n)
{
  int product = 1;
  while (n > 0)
  {
    product *= n;
    n--;
  }
  return product;
}
```

* It's also possible to have more than one base or recursive case, if the program might recurse or terminate in different ways, depending on the input being passed in.

### Call Stack

* When you call a function, the system sets aside space in memory for that function to do its necessary work. We frequently call such chunks of memory **stack frames** or **function frames**.
* More than one function's stack frame may exist in memory at a given time. if `main()` calls `move()`, when then calls `direction()`, all three funcitons have open frames.
* These frames are arranged in a **stack**. The frame for the most recently called function is always on the top of the stack.
* When a new function is called, a new frame is **pushed** onto the top of the stack and becomes the active frame.
* When a function finishes its work, its frame is **popped** off of the stack, and the frame immediately below it becomes the new, active, function on the top of the stack. This function picks up immediately where it left off.
