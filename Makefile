all: h.pm

h.pm: h.eyp
	eyapp -C h.eyp

hello.s: hello.h h.pm
	./h.pm hello.h

clean:
	rm -f h.pm hello.s
