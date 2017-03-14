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
