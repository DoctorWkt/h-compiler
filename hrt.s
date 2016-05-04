init:
   lac 017777 i         " Divide the # argument words by 4
   lrss 2
   dac main.argc	" Save the number of arguments
   lac 017777
   tad .d1		" Get the pointer to the first argument
1: dac .targv i		" Save it in the argv array
   isz .targv
   tad .d4
   sad .himem		" Stop when we hit location 017777
     jmp 2f
   jmp 1b
2:
   jms main		" Call main() and then exit
   sys exit

.open: 0		" Call the open system call
   lac open.how
   dac 2f
   lac open.buf
   dac 1f
   sys open; 1:0; 2:0
   jmp .open i

.read: 0		" Call the read system call
   lac read.cnt
   dac 2f
   lac read.buf
   dac 1f
   lac read.fd
   sys read; 1:0; 2:0
   jmp .read i

.write: 0		" Call the write system call
   lac write.cnt
   dac 2f
   lac write.buf
   dac 1f
   lac write.fd
   sys write; 1:0; 2:0
   jmp .write i

.close: 0		" Call the close system call
   lac close.fd
   sys close
   jmp .close i

.exit: 0		" Call the exit system call
   sys exit

.getuid: 0		" Call the getuid system call
   sys getuid
   jmp .getuid i

.creat: 0		" Call the creat system call
   lac creat.buf
   dac 1f
   sys creat; 1:0
   jmp .creat i

.seek: 0		" Call the seek system call
   lac seek.how
   dac 2f
   lac seek.offset
   dac 1f
   lac seek.fd
   sys seek; 1:0; 2:0
   jmp .seek i

.link: 0
   lac link.dir
   dac 1f
   lac link.src
   dac 2f
   lac link.dst
   dac 3f
   sys link; 1:0; 2:0; 3:0
   jmp .link i

.unlink: 0
   lac unlink.buf
   dac 1f
   sys unlink; 1:0
   jmp .unlink i

.setuid: 0
   lac setuid.uid
   sys setuid
   jmp .setuid i

.rename: 0
   lac rename.old
   dac 1f
   lac rename.new
   dac 2f
   sys rename; 1:0; 2:0
   jmp .rename i

.time: 0
   sys time
   lacq
   jmp .time i

.chdir: 0
   lac chdir.old
   dac 1f
   sys chdir; 1:0
   jmp .chdir i

.chmod: 0
   lac chmod.file
   dac 1f
   lac chmod.mode
   sys chmod; 1:0
   jmp .chmod i

.chown: 0
   lac chown.file
   dac 1f
   lac chown.uid
   sys chown; 1:0
   jmp .chown i

.fork: 0
   sys fork
     jmp 1f
   cla			" Clear the child's AC
1: jmp fork i

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
.d4: 4			" Used to skip arguments
.himem: 017777		" Highest available memory address
close.fd: 0
main.argc: 0		" Number of arguments
open.how: 0
open.buf: 0
open.fd: 0
printn.n: 0
putchar.c: 0
read.cnt: 0
read.buf: 0
read.fd: 0
write.cnt: 0
write.buf: 0
write.fd: 0
creat.buf: 0
seek.how: 0
seek.offset: 0
seek.fd: 0
link.dir: 0
link.src: 0
link.dst: 0
unlink.buf: 0
setuid.uid: 0
rename.old: 0
rename.new: 0
chdir.old: 0
chmod.file: 0
chmod.mode: 0
chown.file: 0
chown.uid: 0
.targv: .+2		" Temporary pointer to argument pointers
main.argv: .+1		" Pointer to argument pointers
   0
   0
   0
   0
   0
   0
   0
   0

