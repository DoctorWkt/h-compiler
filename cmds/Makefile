all: cat

../h.pm:
	echo Please make ../h.pm

cat: ../h.pm ../as7 ../hrt.s cat.h
	../h.pm cat.h
	../as7 -o cat ../hrt.s cat.s
	rm cat.s

cp: ../h.pm ../as7 ../hrt.s cp.h
	../h.pm cp.h
	../as7 -o cp ../hrt.s cp.s
	rm cp.s

getuid: ../h.pm ../as7 ../hrt.s getuid.h
	../h.pm getuid.h
	../as7 -o getuid ../hrt.s getuid.s
	rm getuid.s

creat: ../h.pm ../as7 ../hrt.s creat.h
	../h.pm creat.h
	../as7 -o creat ../hrt.s creat.s
	rm creat.s

rm: ../h.pm ../as7 ../hrt.s rm.h
	../h.pm rm.h
	../as7 -o rm ../hrt.s rm.s
	rm rm.s

mv: ../h.pm ../as7 ../hrt.s mv.h
	../h.pm mv.h
	../as7 -o mv ../hrt.s mv.s
	rm mv.s

time: ../h.pm ../as7 ../hrt.s time.h
	../h.pm time.h
	../as7 -o time ../hrt.s time.s
	rm time.s

clean:
	rm -f cat cp getuid creat rm mv time *.s
