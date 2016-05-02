all: h.pm

h.pm: h.eyp
	eyapp -C h.eyp

hello.s: hello.h h.pm
	./h.pm hello.h

hello: hello.s hrt.s
	./as7 -o hello hello.s hrt.s

debug: hello
	./a7out -b 10000 hello

run: hello
	./a7out hello

test: h.pm
	(cd tests; ./runtests)

otest: h.pm
	(cd tests; ./runtests -O)

roff.s: h.pm roff.c
	./h.pm roff.c

roff: roff.s
	./as7 -n -o roff roff.s hrt.s

clean:
	rm -f h.pm hello.s hello roff.s roff n.out
