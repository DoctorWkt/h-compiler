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

putchar: 0
   lac putchar.c	" Get the character
   dac .char
   lac .fd1
   sys write; .char; 1  " and write it out
   jmp putchar i

getchar: 0
   lac .ipt		" Load the pointer to the next word in the buffer
   sad .eipt
     jmp 1f             " We've reached the end of the buffer, so read more
   dac 2f               " Save the pointer
   add .o400000		" Flip the msb and save into ipt
   dac .ipt
   ral                  " Move the msb into the link register
   lac 2f i             " Load the word from the buffer
   szl                  " Skip if this is the second character in the word
     lrss 9             " It's the first char, shift down the top character
   and .o177		" Keep the lowest 7 bits
   sna
     jmp getchar+1	" Skip a NUL characters and read another one
   jmp getchar i	" Return the character from the subroutine
1:
   lac .fd0		" Buffer is empty, read another 64 characters
   sys read; .iipt+1; 64
   sna
     jmp 1f             " No characters were read in
   tad .iipt		" Add the word count to the base of the buffer
   dac .eipt		" and store in the end buffer pointer
   lac .iipt		" Reset the ipt to the base of the buffer
   dac .ipt
   jmp getchar+1	" and loop back to get one character
1:
   lac .o4		" No character, return with ctrl-D
   jmp getchar i

.cnt: 0         	" Loop counter for printn
.d1: .fd1: 1		" Output file descriptor
.fd0: 0			" Input file descriptor
.char: 0
.newline: 10		" Used in printn
.o60: 060		" ASCII '0', used in printn
2: 0;0                  " Current input and output word pointers
.ipt: 0			" Current input buffer base
.eipt: 0		" Pointer to end of data read in input buffer
.iipt: .+1; .=.+64	" 64 word input buffer and pointer to it
.o4: 4			" ctrl-D, used in getchar
.o400000: 0400000	" Msb toggle bit, used in getchar
.o177: 0177		" ASCII mask, used in getchar
