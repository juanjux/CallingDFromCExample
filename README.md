# CallingDFromCExample

A simple example generating a lib.so from D language code and using it in C.

You need a [D compiler](https://dlang.org/download.html); either dmd, gcd or ldc2. If you use gcd or ldc2 update the Makefile DC variable.
No third party libraries are needed.

Then just run "make" and run ./binary.

This example links against the runtime and uses the GC so the C code needs to call the exported initialize() function. This (both the call and the 
runtime+GC) can be avoided in this example by using printf() and snprintf() to print or concatenate the strings in the D side and marking functions as @nogc (tested).
