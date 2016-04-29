printn: 0		" Print printn_n in octal
   lac printn.n
   lmq
   -6
   dac .cnt		" Set up a loop for 6 times
1:
   clls 3               " Shift an octal digit into AC
   tad .o60		" Add AC to ASCII '0'
   dac .char            " and print out the digit
   lac .fd1
   sys write; .char; 1
   isz .cnt		" Any more characters to print out?
     jmp 1b		" Yes, loop back
   lac .fd1		" Print out a space
   sys write; .newline; 1
   jmp printn i

.cnt: 0         	" Loop counter for printn
.d1: .fd1: 1		" Output file descriptor
.char: 0
.newline: 10		" Used in printn
.o60: 060		" ASCII '0', used in printn
