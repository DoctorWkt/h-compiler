all: h.pm

h.pm: h.eyp
	eyapp -C h.eyp

hello.s: hello.h h.pm
	./h.pm hello.h

hello: hello.s
	./as7 -o hello hello.s

clean:
	rm -f h.pm hello.s hello
