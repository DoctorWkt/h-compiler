all: h.pm

h.pm: h.eyp
	eyapp -C h.eyp

hello.s: hello.h h.pm
	./h.pm hello.h

hello: hello.s
	./as7 -o hello hello.s

debug: hello
	./a7out -b 10000 hello

clean:
	rm -f h.pm hello.s hello
