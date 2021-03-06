"H" language Compiler
=====================

This is a one-pass compiler for a C-like language which I've written to
target Unix on the PDP-7. The language still looks vaguely like C, but there
are some important differences. Even though the language allows char and int,
there is only really int. Also, the '*' decoration on variable declarations
does nothing. These are just syntactic sugar to make it a bit more like C.
There is also limited recursion.

To build the compiler and run the virtual machine to execute the assembly code,
you need to have Perl, the Parse::Yapp and Data::Dumper packages installed.
You can then run "make test". This builds the compiler (h.eyp -> h.pm), and
runs the test suite of programs in the VM. The VM executable is called a7out.

"make otest" runs the test suite with compiler optimisations on (which is
now the default).

Read the h_intro.html file for an introduction to the H language and then
look at the example files in test/t*.h. Also look at roff/wktroff.c which is
both a C and H program. "make rtest" in the roff folder builds and runs roff
with a sample input file.

This is all heavily under development. Expect it to not work as expected :)
The change log follows below.

Cheers, Warren

Sun May 15 21:52:26 AEST 2016
-----------------------------
After some chat with Robert Swierczek about ways to implement recursion,
I've found a way to implement a limited form of recursion. It costs
somewhat in terms of speed and code size, but the programmer gets to
enable it as required.

Thu May 12 16:09:53 AEST 2016
-----------------------------
I've got an improved roff to compile and run. This version has most of
the functionality of the 1971 GECOS roff. I've also added local arrays
to the compiler.

Thu May  5 13:25:34 AEST 2016
-----------------------------
I've added && and ||, comparisons as expressions, made function arguments
into expressions, and I've added support for most of the PDP-7 Unix
system calls.

Tue May  3 16:43:23 AEST 2016
-----------------------------
I've finally got roff to compile and execute. There is now a roff.c
source file which compiles as C code and also as H code. Do "make rtest"
to build roff and run it with some sample input.

Sat Apr 30 21:18:41 AEST 2016
-----------------------------
I've got most things working except the < > <= and >= relational operators.
Not bad for a few days work. There are sure to be bugs.

Sat Apr 30 10:54:48 AEST 2016
-----------------------------
Started work on things, nothing works as yet.
