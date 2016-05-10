all: wktroff

roff.s: ../h.pm roff.c
	../h.pm roff.c

# Build the simple PDP-7 roff binary
roff: roff.s ../as7 ../hrt.s
	../as7 -o roff ../hrt.s roff.s

wktroff.s: ../h.pm wktroff.c
	../h.pm wktroff.c

# Build the more complex PDP-7 roff binary
wktroff: wktroff.s ../as7 ../hrt.s
	../as7 -o wktroff ../hrt.s wktroff.s

# Run the roff binary on sample input
rtest: wktroff ../a7out
	../a7out wktroff < cat.1 | less

clean:
	rm -f h.pm roff.s roff wktroff.s wktroff
