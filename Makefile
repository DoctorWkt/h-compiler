all: h.pm

# Build the compiler
h.pm: h.eyp
	eyapp -C h.eyp

hello.s: hello.h h.pm
	./h.pm hello.h

# Build a single program; used for testing
hello: hello.s hrt.s
	./as7 -o hello hello.s hrt.s

# Debug the program under test
debug: hello
	./a7out -b 10000 hello

# Run the program under test
run: hello
	./a7out hello

# Run the entire test suite, no optimisations
test: h.pm
	(cd tests; ./runtests -nopt)

# Run the entire test suite with optimisations
otest: h.pm
	(cd tests; ./runtests)

roff.s: h.pm roff.c
	./h.pm roff.c

# Build the PDP-7 roff binary
roff: roff.s
	./as7 -n -o roff roff.s hrt.s

# Run the roff binary on sample input
rtest: roff
	./a7out roff < tests/cat.1 | less

clean:
	rm -f h.pm hello.s hello roff.s roff n.out
