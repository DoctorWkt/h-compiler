all: h.pm

# Build the compiler
h.pm: h.eyp
	eyapp -C h.eyp

hello.s: hello.h h.pm
	./h.pm hello.h

# Build a single program; used for testing
hello: hello.s hrt.s
	./as7 -o hello hrt.s hello.s

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

clean:
	rm -f h.pm hello.s n.out
