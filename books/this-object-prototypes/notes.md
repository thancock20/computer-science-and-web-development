# Notes for YDKJS: `this` & Object Prototypes


<!-- toc orderedList:0 depthFrom:2 depthTo:6 -->

* [What is `this`](#what-is-this)

<!-- tocstop -->


## What is `this`

`this` is neither a reference to the function itself, nor is it a reference to the function's *lexical* scope.

`this` is actually a binding that is made when a function is invoded, and *what* it references is determined entirely by the call-site where the function is called.
