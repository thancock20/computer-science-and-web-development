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
* [Week 5](#week-5)
  * [File Pointers](#file-pointers)
  * [Singly-Linked Lists](#singly-linked-lists)
  * [Doubly-Linked Lists](#doubly-linked-lists)
  * [Stacks](#stacks)
  * [Queues](#queues)
  * [Hash Tables](#hash-tables)
  * [Tries](#tries)
* [Week 6](#week-6)
  * [Internet Primer](#internet-primer)
  * [Internet Protocol (IP)](#internet-protocol-ip)
  * [Transmission Control Protocol (TCP)](#transmission-control-protocol-tcp)
  * [Hypertext Transfer Protocol](#hypertext-transfer-protocol)
* [Week 7](#week-7)
* [Week 8](#week-8)

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

## Week 5

[Lecture Notes](http://docs.cs50.net/2016/fall/notes/5/week5.html)

### File Pointers

* The ability to read data from and write data to files is the primary means of storing **persistent data**, data that does not disappear when your program stops running.
* The abstraction of files that C provides is implemented in a data structure known as a `FILE`.
  * Almost universally when working with files, we will be using pointers to them, `FILE*`.
* The file manipulation functions all live in `stdio.h`.
  * All of them accept `FILE*` as one of their parameters, except for the function `fopen()`, which is used to get a file pointer in the first place.
* Some of the most common file input/output (I/O) functions that we'll be working with are:
  * `fopen()`
    * Opens a file and returns a file pointer to it.
    * Always check the return value to make sure you don't get back `NULL`.
    ```c
    // syntax
    FILE *ptr = fopen(<filename>, <operation>);

    // example
    FILE *ptr1 = fopen("file3.txt", "a");
    ```
  * `fclose()`
    * Closes the file pointed to by the given file pointer.
    ```c
    // syntax
    fclose(<file pointer>);

    // example
    fclose(ptr1);
    ```
  * `fgetc()`
    * Reads and returns the next character from the file pointed to.
    * Note: The operation of the file pointer passed in as a parameter must be `"r"` for read, or you will suffer an error.
    ```c
    // syntax
    char ch = fgetc(<file pointer>);

    // example
    char ch = fgetc(ptr1);
    ```
    * The ability to get single characters from files, if wrapped in a loop, means we could read all the characters, one-by-one, essentially.
    ```c
    char ch;
    while ((ch = fgetc(ptr)) != EOF)
      printf("%c", ch);
    ```
    * We might put this in a file called `cat.c`, after the Linux command "cat" which essentially does just this.
  * `fputc()`
    * Writes or appends the specified character to the pointed-to file.
    * Note: The operation of the file pointer passed in as a parameter must be `"w"` for write or `"a"` for append, or  you will suffer an error.
    ```c
    // syntax
    fputc(<character>, <file pointer>);

    // example
    fputc('A', ptr1);
    ```
    * Now we can read characters from files and write characters to them. Let's extend our previous example to copy one file to another, instead of printing to the screen.
    ```c
    char ch;
    while ((ch = fgetc(ptr)) != EOF)
      fputc(ch, ptr1);
    ```
    * We might put this in a file called `cp.c`, after the Linux command "cp" which essentially does just this.
  * `fread()`
    * Reads `<qty>` units of size `<size>` from the file pointed to and stores them in memory in a buffer (usually an array) pointed to by `<buffer>`.
    * Note: The operation of the file pointer passed in as a parameter must be `"r"` for read, or you will suffer an error.
    ```c
    //syntax
    fread(<buffer>, <size>, <qty>, <file pointer>);

    // simple example
    int arr[10];
    fread(arr, sizeof(int), 10, ptr1);

    // more complex example
    double *arr2 = malloc(sizeof(double) * 80);
    fread(arr2, sizeof(double), 80, ptr1);

    // works like char c = fgetc(ptr1)
    char c;
    fread(&c, sizeof(char), 1, ptr1);
    ```
  * `fwrite()`
    * Writes `<qty>` units of size `<size>` to the file pointed to by reading them from a buffer (usually an array) pointed to by `<buffer>`.
    * Note: The operation of the file pointer passed in as a parameter must be `"w"` for write or `"a"` for append, or you will suffer an error.
    ```c
    // syntax
    fwrite(<buffer>, <size>, <qty>, <file pointer>);
    ```
* Lots of other useful functions abound in `stdio.h` for you to work with. Here are some of the ones you may find useful!

| Function  | Description                                                     |
|:----------|:----------------------------------------------------------------|
| fgets()   | Reads a full string from a file.                                |
| fputs()   | Writes a full string to a file.                                 |
| fprintf() | Writes a formatted string to a file.                            |
| fseek()   | Allows you to rewind or fast-forward within a file.             |
| ftell()   | Tells you at what (byte) position you are at within a file.     |
| feof()    | Tells you whether you've read to the end of a file.             |
| ferror()  | Indicates whether an error has occurred in working with a file. |

### Singly-Linked Lists

* So far we've only had one kind of data structure for representing collections of like values.
  * Structs, recall, give us "containers" for holding variables of different data types, typically.
* Arrays are great for element lookup, but unless we want to insert at the very end of the array, inserting elements is quite costly---remember insertion sort?
* Arrays also suffer from a great inflexibility---what happens if we need a larger array than we thought?
* Through clever use of pointers, dynamic memory allocation, and structs, we can put the pieces together to develop a new kind of data structure that gives us the ability to grow and shrink a collection of like values to fit our needs.
* We call this combination of elements, when used in this way, a **linked list**.
* A linked list **node** is a special kind of struct with two members:
  * Data of some type (int, char, float..)
  * A pointer to another node of the same type
* In this way, a set of nodes together can be thought of as forming a chain of elements that we can follow from beginning to end.
```c
typedef struct sllist
{
  VALUE val;
  struct sllist *next;
}
sllnode;
```
* In order to work with linked lists effectively, there are a number of operations that we need to understand:
  * Create a linked list when it doesn't already exist.
    ```c
    sllnode* create(VALUE val);
    ```
    * Steps involved:
      1. Dynamically allocate space for a new sllnode.
      2. Check to make sure we didn't run out of memory.
      3. Initialize the node's val field.
      4. initialize the node's next field.
      5. Return a pointer to the newly created sllnode.
  * Search through a linked list to find an element.
    ```c
    bool find(sllnode *head, VALUE val);
    ```
    * Steps involved:
      1. Create a traversal pointer pointing to the list's head.
      2. If the current node's val field is what we're looking for, report success.
      3. If not, set the traversal pointer to the next pointer in the list and go back to step 2.
      4. If you've reached the end of the list, report failure.
  * Insert a new node into the linked list.
    ```c
    sllnode* insert(sllnode *head, VALUE val);
    ```
    * Steps involved:
      1. Dynamically allocate space for a new sllnode.
      2. Check to make sure we didn't run out of memory.
      3. Populate and insert the node at the beginning of the linked list.
      4. Return a pointer to the new head of the linked list.
  * Delete a single element from a linked list.
    * Tricky, because previous node needs to be kept track of.
  * Delete an entire linked list.
    ```c
    void destroy(sllnode *head);
    ```
    * Steps involved:
      1. If you've reached a null pointer, stop.
      2. Delete the rest of the list.
      3. Free the current node.

### Doubly-Linked Lists

* Singly-linked lists really extend our ability to collect and organize data, but they suffer from a crucial limitation.
  * We can only ever move in one direction through the list.
* Consider the implication that would have for trying to delete a node.
* A doubly-linked list, by contrast, allows us to move forward and backward through the list, all by simply adding one extra pointer to our struct definition.

```c
typedef struct dllist
{
  VALUE val;
  struct dllist *prev;
  struct dllist *next;
}
dllnode;
```
* In order to work with linked lists effectively, there are a number of operations that we need to understand:
  * Create a linked list when it doesn't already exist.
    * Pretty much the same as singly-linked list.
  * Search through a linked list to find an element.
    * Pretty much the same as singly-linked list.
  * Insert a new node into the linked list.
    ```c
    dllnode* insert(dllnode *head, VALUE val);
    ```
    * Steps involved:
      1. Dynamically allocate space for a new dllnode.
      2. Check to make sure we didn't run out of memory.
      3. Populate and insert the node at the beginning of the linked list.
      4. **Fix the prev pointer of the old head of the linked list.**
      5. Return a pointer to the new head of the linked list.
  * Delete a single element from a linked list.
    ```c
    void delete(dllnode *target);
    ```
    * Steps involved:
      1. Fix the pointers of the surrounding nodes to "skip over" target.
      2. Free target.
  * Delete an entire linked list.
    * Pretty much the same as singly-linked list.
* Linked lissts, of both the singly- and doubly-linked varieties, support extremely efficient *insertion* and *deletion* of elements.
  * In fact, these operations can be done in **constant time**.
* What's the downside? Remember how we had to find an element? We've lost the ability to randomly-access list elements.
  * Accessing a desired element may now take **linear time**.

### Stacks

* A stack is a special type of structure that can be used to maintain data in an organized way.
* This data structure is commonly implemented in one of two ways: as an **array** or as a **linked list**.
* In either case, the important rule is that when data is added to the stack, it sits "on top," and so if an element needs to be removed, the most recently added element is the only element that can legally be removed.
  * *Last in, first out (LIFO)*
* There are only two operations that may legally be performed on a stack.
  * **Push**: Add a new element to the top of the stack.
  * **Pop**: Remove the most recently-added element from the top of the stack.
* Array-based implementation:
  ```c
  // definition
  typedef struct _stack
  {
    VALUE array[CAPACITY];
    int top;
  }
  stack;

  // initialization
  stack s;
  s.top = 0;
  ```
  * Push:
    ```c
    void push(stack *s, VALUE data);

    push(&s, 29);
    ```
    * In the general case, `push()` needs to:
      1. Accept a pointer to the stack.
      2. Accept data of type VALUE to be added to the stack.
      3. Add that data to the stack at the top of the stack.
      4. Change the location of the top of the stack.
  * Pop:
    ```c
    VALUE pop(stack *s);

    int x = pop(&s);
    ```
    * In the general case. `pop()` needs to:
      1. Accept a pointer to the stack.
      2. Change the location of the top of the stack.
      3. Return the value that was removed from the stack.
* Linked list-based implementation:
  ```c
  typedef struct _stack
  {
    VALUE val;
    struct _stack *next;
  }
  stack;
  ```
  * Just make sure to always maintain a pointer to the head of the linked list!
  * Push:
    ```c
    void push(stack *list, VALUE data);

    push (list, 10);
    ```
    1. Dynamically allocate a new node.
    2. Set its next pointer to point to the current head of the list.
    3. Move the head pointer to the newly-created node.
  * Pop:
    ```c
    VALUE pop(stack *list);

    int x = pop(list);
    ```
    1. Traverse the linked list to its second element (if it exists).
    2. Free the head of the list.
    3. Move the head pointer to the (former) second element.

### Queues

* A queue is a special type of structure that can be used to maintain data in an organized way.
* This data structure is commonly implemented in one of two ways: as an **array** or as a **linked list**.
* In either case, the important rule is that when data is added to the queue, it is tacked onto the end, and so if an element needs to be removed, the element at the front is the only element that can legally be removed.
  * *First in, first out (FIFO)*
* There are only two operations that may legally be performed on a queue.
  * **Enqueue**: Add a new element to the end of the queue.
  * **Dequeue**: Remove the oldest element from the front of the queue.
* Array-based implementation
  ```c
  // definition
  typedef struct _queue
  {
    VALUE array[CAPACITY];
    int front;
    int size;
  }
  queue;

  // initialization
  queue q;
  ```
  * Enqueue:
    ```c
    void enqueue(queue *q, VALUE data);

    enqueue(&q, 29);
    ```
    * In the general case, `enqueue()` needs to:
        1. Accept a pointer to the queue.
        2. Accept data of type VALUE to be added to the queue.
        3. Add that data to the queue at the end of the queue.
        4. Change the size of the queue.
  * Dequeue:
    ```c
    VALUE dequeue(queue *q);

    int x = dequeue(&q);
    ```
    * In the general case, `dequeue()` needs to:
      1. Accept a pointer to the queue.
      2. Change the location of the front of the queue.
      3. Decrease the size of the queue.
      4. Return the value that was removed from the queue.
* Linked list-based implementaion
  ```c
  // definition
  typedef struct _queue
  {
    VALUE val;
    struct _queue *prev;
    struct _queue *next;
  }
  queue;
  ```
  * Just make sure to always maintain pointers to the head **and** tail of the linked list! (probably global)
  * Enqueue:
    ```c
    void enqueue(queue *tail, VALUE data);

    enqueue(tail, 10);
    ```
    1. Dynamically allocate a new node;
    2. Set its next pointer to NULL, set its prev pointer to the tail;
    3. Set the tail's next pointer to the new node;
    4. Move the tail pointer to the newly-created node.
  * Dequeue:
    ```c
    VALUE dequeue(queue *head);

    int x = dequeue(head);
    ```
    1. Traverse the linked list to its second element (if it exists);
    2. Free the head of the list;
    3. Move the head pointer to the (former) second element;
    4. Make that node's prev pointer point to NULL.

### Hash Tables

* Hash tables combine the random access ability of an array with the dynamism of a linked list.
* This means (assuming we define our has table well):
  * Insertion can start to tend toward θ(1)
  * Deletion can start to tend toward θ(1)
  * Lookup can start to tend toward θ(1)
* We're gaining the advantages of both types of data structure, while mitigating the disadvantages.
* To get this performance upgrade, we create a new structure whereby when we insert data into the structure, the data itself gives us a clue about where we will find the data, should we need to later look it up.
* The trade off is that hash tables are not great at ordering or sorting data, but if we don't care about that, then we're good to go!
* A hash table amounts to a combination of two things with which we're quite familiar.
  1. A **hash function**, which returns a nonnegative integer value called a *hash code*.
  2. An **array** capable of storing data of the type we wish to place into the data structure.
* The idea is that we run our data through the hash function, and then store the data in the element of the array represented by the returned hash code.
* How to define a hash function? Really no limit to the number of possible hash functions.
* A good hash function should:
  * Use only the data being hashed
  * Use all of the data being hashed
  * Be deterministic
  * Uniformly distribute data
  * Generate very different hash codes for very similar data
```c
// example possible hash function
unsigned int hash(char *str)
{
  int sum = 0;
  for (int j = 0; str[j] != '\0'; j++)
  {
    sum += str[j];
  }
  return sum % HASH_MAX;
}
```
* Best to use hash function found on the Internet. (and be sure to cite the source)
* A **collision** occurs when two pieces of data, when run through the hash function, yield the same hash code.
* Presumably we want to store *both* pieces of data in the hash table, wo we shouldn't simply overwrite the data that happened to be placed in there first.
* We need to find a way to get both elements into the hash table while trying to preserve quick insertion and lookup.
* Resolving collisions: *Linear probing*
  * In this method, if we have a collision, we try to place the data in the next consecutive element in the array (wrapping arround to the beginning if necessary) until we find a vacancy.
  * That way, if we don't find what we're looking for in the first location, at least hopefully the element is somewhere nearby.
  * Linear probing is subject to a problem called **clustering**. Once there's a miss, two adjacent cells will contain data, making it more likely in the future that the cluster will grow.
  * Even if we switch to another probing technique, we're still limited. We can only store as much data as we have location in our array.
* Resolving collisions: *Chaining*
  * Let's start to pull it all together.
  * What if instead of each element of the array holding just one piece of data, it held multiple pieces of data?
  * If each element of the array is a pointer to the head of a linked list, then multiple pieces of data can yield the same hash code and we'll be able to store it all!
  * We've eliminated clustering.
  * We know from experience with linked lists that insertion (and creation, if necessary) into a linked list is an O(1) operation.
  * For lookup, we only need to search through what is hopefully a small list, since we're distributing what would otherwise be one huge list across *n* lists.

### Tries

* We have a seen a few data structures that handle the mapping of key-value pairs.
  * Arrays: The key is the element index, the value is the data at that location.
  * Hash tables: The key is the hash code of the data, the value is a linked list of data hashing to that hash code.
* What about a slightly different kind of data structure where the key is guaranteed to be unique, and the value could be as simple as a Boolean that tells you whether the data exists in the structure?
* Tries combine structures and pointers together to store data in an interesting way.
* The data to be searched for in the trie is now a roadmap.
  * If you can follow the map from beginning to end, the data exists in the trie.
  * If you can't, it doesn't.
* Unlike with a hash table, there are no collisions, and no two pieces of data (unless they are identical) have the same path.
* Let's map key-value pairs where the keys are four-digit years (YYYY) and the values are names of universities founded during those years.
* In a trie, the paths from a central **root** node to a **leaf** node (where the schools names would be), would be labeled with digits of the year.
* Each node on the path from root to leaf could have 10 pointers emanating from it, one for each digit.
```c
typedef struct _trie
{
  char university[20];
  struct _trie *paths[10];
}
trie;
```
* To insert an element into the trie, simply build the correct path from the root to the leaf.
* To search for an element in the trie, use successive digits to navigate from the root, and if you can make it to the end without hitting a dead end (a NULL pointer), you've found it.

## Week 6

[Lecture Notes](http://docs.cs50.net/2016/fall/notes/6/week6.html)

### Internet Primer

* We've reached the point where we begin the transition away from the command-line oriented world of C and start considering the web-based world.
* Before we dive headlong into that world, it's a good idea to have a basic understanding of how humans and computers interact over the internet.
* **IP Address**
  * In order for your machine to uniquely identify itself on the Internet, it needs an address.
    * This way, it can send information out and also receive information back to the correct location.
  * The addressing scheme used by computers is known as IP addressing.
  * As originally developed, the IP addressing scheme would effectively allocate a unique 32-bit address to each device hopting to connect to teh internet.
  * Instead of representing these 32-bit addresses as hexadecmal, we represent them as four clusters of 8-bits using decimal notation.
  ```
  w.x.y.z
  ```
  * Each of w, x, y, and z can be a nonnegative value in the range [0,255].
  * If each IP address is 32 bits, that means there are roughly 4 billion addresses to give out.
  * The population of the world is somewhere in excess of 7 billion, and most folks in the western world have more than 1 device capable of Internet connectivity.
    * Some workarounds have allowed us to deal with this problem (for now).
  * In recent years, we've been slowly phasing out this old scheme (IPv4) and replacing it with a newer scheme (IPv6) that assigns computers 128-bit addresses, instead of 32-bit addresses.
    ```
    s:t:u:v:w:x:y:z
    ```
    * Each of s, t, u, v, w, x, y, and z is represented by 1 to 4 hexadecimal digits in the range [0, ffff].
* **DHCP**
  * How do we get an IP address in the first place though? Surely we can't just choose any one we want. What if the one we want is already taken?
  * Somewhere between your computer and the Internet at large exists a *Dynamic Host Configuration Protocol* (DHCP) server, whose role is to assign IP addresses to devices.
  * Prior to the widespread promulgation of DHCP, the task of assigning IP addresses fell to a system administrator, who would need to manually assign such addresses.
* **DNS**
  * Odds are, you've never actually tried to visit a website by typing its IP address into your browser.
  * The Domain Name System (DNS) exists to help us translate IP addresses to more memorable names that are more human-comprehensible.
  * In this way, DNS is somewhat like the yellow pages of the web.
  * Much like there is no yellow pages of the world, there is really no DNS record of the entire internet.
  * Rather, large DNS server systems (like Google's own) are more like aggregators, collecting smaller sets of DNS information and pooling them together, updating frequently.
  * In that way, large DNS servers are like libraries that stock many different sets of local yellow page books. In order to have the most up-to-date phone numbers for businesses, libraries must update the books they have on hand.
  * DNS record sets are thus fairly decentralized.
* **Access Points**
  * One of the ways we've dealt with the IPv4 addressing problem is to start assigning multiple people to the same IP address.
  * The IP address is assigned to a *router*, whose job it is to act as a traffic cop that allows data requests from all of the devices on your local network (your home or business, e.g.) to be processed through a single IP address.
  * Modern home networks consist of access points that combine a router, a modem, a switch, and other technologies together into a single device.
  * Modern business networks or large-scale wide-are networks (WANs) still frequently have these as separate devices to allow the size of their network to scale more easily.
* This isn't a course on networking, so this is far from the whole story, but it's enough to get us started.
* At home or at work we have local, small networks, and these networks are woven together to create a large, interconnected network---an Internet.
  * If you think about each of these small networks being isolated communities with only a single road in or out, the picture becomes a bit clearer.

### Internet Protocol (IP)

* As discussed previously, "the Internet" is really an *interconnected network* comprised of smaller netwoks woven together and agreeing to communicate with one another.
* How do these networks know how to communicate with on another? This is the responsibility of the Internet Protocol (IP).
* Instead of being connected to every other network, each network is connected to a limited number of routers (each of which is connected to other routers), and each router has instructions built into it on how to move information toward its destination.
* This information is stored in a routing table, inside of the router.
* Any slowdown caused by sending a large amount of data would have a ripple effect that would throttle the network for all the other users.
* As such, another crucial part of IP is splitting data into *packets*.
* IP is also known as a *connectionless* protocol. There is not necessarily a defined path from the sender to the receiver, and vice versa.
* This means that in response to traffic that might be "clogging" up one particular path through the Internet, some packets can be "re-routed" around the traffic jam to follow the monst optimal path, based on the current state of the network.
* The routing table then probably consists of more information than just "where do I send this packet from here," but also "what is the cost of using that particular route?"
* Another side effect of being connectionless is that delivery cannot be guaranteed, since the path from sender to receiver is not guaranteed to be consistent.

### Transmission Control Protocol (TCP)

* If IP is thought of as the protocol for getting information from a sending machine to a receiving machine, then Transmission Control Protocol (TCP) can be thought of as directing the transmitted packet to the correct program on the receiving machine.
* As you might imagine, it is important to be able to identify both *where* the receiver is and *what* the packet is for, so TCP and IP are almost an inseparable pair: TCP/IP.
* Each program/utility/service on a machine is assigned a *port number*. Coupled with an IP address, we can now uniquely identify a specific program on a specific machine.
* The other thing that TCP is crucial for is *guaranteeing delivery* of packets, which IP alone does not do.
* TCP does this by including information about how many packets the receiver should expect to get, and in what order, and transmitting that information alongside the data.
* Some ports are so commonly used that they have been standardized across all computers.
  * FTP (file transfer) uses port **21**.
  * SMTP (e-mail) uses port **25**.
  * DNS uses port **53**.
  * HTTP (web browsing) uses port **80**.
  * HTTPS (secure web browsing) uses port **443**.
* Steps of the TCP/IP process
  1. When a program goes to send data, TCP breaks it into smaller chunks and communicates those packets to the computer's network software, adding a TCP layer onto the packet.
  2. IP routes the individual packets from sender to receiver; this info is part of the IP layer surrounding the packet.
  3. When the destination computer gets the packet, TCP looks at the header to see which program it belongs to; and since the routes packets take may differ, TCP also must present those packets to the destination program in the proper order.
* If at any point along the way a router delivering information using the Internet Protocol *dropped* the packet, TCP would use additional information inside the headers to request that the sender pass along the extra packet so it could complete assembly.
* After the packets arrived, TCP ensures they are organized in the correct order and can then be reassembled into the intended unit of data and delivered to the correct service.

### Hypertext Transfer Protocol

* In addition to protocols that dictate how informations is communicated from machine to machine and application to application (IP and TCP, respectively), it is frequently the case that the applicaiton itself has a system of rules for how to interpret the data that was sent.
* HTTP is one example of an *application layer protocol*, which specifically dictates the format by which clients *request* web pages from a server, and the format via which servers *return* information to clients.
* Other application layer protocols include:
  * File Transfer Protocol (FTP)
  * Simple Mail Transfer Protocol (SMTP)
  * Data Distribution Service (DDS)
  * Remote Desktop Protocol (RDP)
  * Extensible Message and Presence Protocol (XMPP)
* A line of the form `method request-target http-version` is a simple example of an *HTTP request line*, a crucial part of an overall HTTP request that client may make to a server.
* The host name (domain name of the server)is also included as a separate line of the overall HTTP request.
* Taken together, the host name and the request target from the request line specify a specific resource being sought.
* Based on whether the resource exists and whether the server is empowered to deliver that resource pusuant to the client's request, a number of *status codes* can result.
* A status code is part of the first line that a server will use to respond to an HTTP request. `http-version status`.

| Class        | Code | Text                  | Comments                                                                      |
|:-------------|:-----|:----------------------|:------------------------------------------------------------------------------|
| Success      | 200  | OK                    | All is well, valid request and response.                                      |
| Redirection  | 301  | Moved Permanently     | Page is now at a new location, automatic redirects built in to most browsers. |
|              | 302  | Found                 | Page is now at a new location *temporarily*.                                  |
| Client Error | 401  | Unauthorized          | Page typically requires login credentials.                                    |
|              | 403  | Forbidden             | Server will not allow this request.                                           |
|              | 404  | Not Found             | Server cannot find what was asked for.                                        |
| Server Error | 500  | Internal Server Error | Generic server failure in responding to the otherwise-valid request.          |

## Week 7

[Lecture Notes](http://docs.cs50.net/2016/fall/notes/7/week7.html)

[Notebook](http://cdn.cs50.net/2016/fall/lectures/7/notes7.html)

## Week 8

[Lecture Notes](http://docs.cs50.net/2016/fall/notes/8/week8.html)
