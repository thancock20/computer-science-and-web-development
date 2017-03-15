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
