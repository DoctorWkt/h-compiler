"H" language Compiler
=====================

This is a one-pass compiler for a C-like language which I've written to
target Unix on the PDP-7. The language still looks vaguely like C, but there
are some important differences. Even though the language allows char and int,
there is only really int. This means that the '*' decoration on declarations
does nothing, and neither does 'void'. They are just syntactic sugar to make
it a bit more like C. There is also no recursion.

To build the compiler and run the virtual machine to execute the assembly code,
you need to have Perl, the Parse::Yapp and Data::Dumper packages installed.
You can then run "make test". This builds the compiler (h.eyp -> h.pm), and
runs the test suite of programs in the VM. The VM executable is called a7out.

Read the h_intro.html file for an introduction to the H language and then
look at the example files in test/t*.h.

This is all heavily under development. Expect it to not work as expected :)
The change log follows below.

Cheers, Warren

Sat Apr 30 21:18:41 AEST 2016
-----------------------------
I've got most things working except the < > <= and >= relational operators.
Not bad for a few days work. There are sure to be bugs.
