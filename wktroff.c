/* Warren's version of Doug McIlroy's RATFOR roff, in C and H.
 * (c) 2016 Warren Toomey, GPL3.
 */
#ifndef H_LANG
#define EOFILE EOF
#include <stdio.h>
#include <stdlib.h>

void printn(int x)
{
    printf("%06o\n", x);
}

#else
#define EOFILE	4		// end of file indicator
#define puts Puts
#endif


#define Char		int
#define HUGE		1000
#define INSIZE		300	// size of input buffer
#define MAXLINE		100
#define MAXOUT		300
#define PAGELEN		66
#define PAGEWIDTH	60
#define ULMASK		0400	// Underline bit mask
#define BOLDMASK	0200	// Bold bit mask
#define ASCIIMASK	0177	// Mask for ASCII characters
#define EXTRASPACE	01000	// Value to indicate an extra space
#define MAXTABS		20	// Maximum tabs in the table

Char inbuf[INSIZE];		// input line buffer
Char outbuf[MAXOUT];		//  lines to be filled collect here
Char header[MAXLINE];		//  top of page title
Char footer[MAXLINE];		//  bottom of page title
Char tempbuf[10];		// use by itoa()
int tablist[] = {
    8, 16, 24, 32, 40, 48, 56, 64, 72, 80,
    88, 96, 104, 112, 120, 128, 136, 144, 152, 160
};

int direction = 1;		// direction to spread spaces, 1 or -1
int bottom;			// last live line on page, = plval-m3val-m4val
int boval=0;			// number of lines to embolden
int ceval = 0;			// number of lines to center
int curpag = 0;			// current output page number
int fill = 1;			// fill the line? 1 is yes
int inval = 0;			// current indent
int justify = 1;		// justify lines? 1 is yes
int lineno = 0;			// next line to be printed
int lival = 0;			// number of lines to treat literally
int lsval = 1;			// current line spacing
int m1val = 3;			// margin before and including header
int m2val = 2;			// margin after header
int m3val = 2;			// margin after last text line
int m4val = 3;			// bottom margin, including footer
int ntabs = 20;			// number of tabs in the list
int newpag = 1;			// next output page number
Char *outp;			// last Char position in outbuf
int outlen;			// current length of output line
int plval = PAGELEN;		// page length in lines
int rmval = PAGEWIDTH;		// current right margin
int tival = 0;			// current temporary indent
int ulval = 0;			// number of lines to underline
Char hypchar='\0';		// character to identy hyphenation points
int hyplen= 0;			// word length up to & including hypchar


void main();
void command();
void text(Char * inbuf, Char * outbuf);
void put(Char * buf);
void spread(Char * buf, int nextra);
int getval(Char * buf, int defval, int minval, int maxval);
void do_ta(Char * buf);
void gettl(Char * buf, Char * ttl);
Char getlin(Char * buf, int maxlen, int fd);
void brkline();
void space(int n);
void pfoot();
void phead();
void puttl(Char * t, int pageno);
Char *partitle(Char * t, Char sep, Char * pgnum);
void skip(int n);
int ctoi(Char * in);
int Strlen(Char * c);
int Wordlen(Char * c);
int is_underl(Char ch);
void Strcpy(Char * dst, Char * src);
void Wordcopy(Char * dst, Char * src, int n);
Char *itoa(int n);
int titlen(Char * t, Char c, int k);
int min(int a, int b);
void Puts(Char * c);

void main()
{
    // Initialise some values
    bottom = plval - m3val - m4val;
    header[0] = '\0';
    footer[0] = '\0';
    outp = outbuf;
    outlen = 0;

    // For each input line
    while (getlin(inbuf, INSIZE, 0) != EOFILE) {

	// Deal with a command when it's not a literal line
	if (*inbuf == '.' && lival==0)
	    command();
	else {
	    text(inbuf, outbuf); // or add it to the outbuf buffer
	    if (lival) lival--;	// That's another literal line done
	}
    }
    if (lineno > 0)		// Flush the last page if needed
	space(HUGE);
#ifdef H_LANG
    exit();
#else
    exit(0);
#endif
}

// Process a command on an input line
void command()
{
    int cmd = inbuf[1] << 9 | inbuf[2];
    int spval;
    Char *cptr = inbuf + 3;		// points past the command

    if (cmd == 0146151) {		// 'fi', set fill mode
	brkline();
	fill = 1;
    } else if (cmd == 0156146) {	// 'nf', disable fill mode
	brkline();
	fill = 0;
    } else if (cmd == 0152165) {	// 'ju', set justify mode
	justify = 1;
    } else if (cmd == 0156152) {	// 'nj', disable justify mode
	justify = 0;
    } else if (cmd == 0142162)		// 'br', break current line
	brkline();
    else if (cmd == 0154163)		// 'ls'
	lsval = getval(cptr, 1, 1, HUGE);
    else if (cmd == 0142160) {		// 'bp'
	if (lineno > 0)
	    space(HUGE);
	curpag = getval(cptr, curpag + 1, -HUGE, HUGE);
	newpag = curpag;
    } else if (cmd == 0163160) {	// 'sp'
	spval = getval(cptr, 1, 0, HUGE);
	space(spval);
    } else if (cmd == 0151156) {	// 'in', set the indent value
	inval = getval(cptr, 0, 0, rmval);
	tival = inval;
    } else if (cmd == 0162155)		// 'rm', set the right margin
	rmval = getval(cptr, PAGEWIDTH, tival + 1, HUGE);
    else if (cmd == 0164151) {		// 'ti', set a temporary indent
	brkline();
	tival = getval(cptr, 0, 0, rmval);
    } else if (cmd == 0143145) {	// 'ce', centre lines
	brkline();
	ceval = getval(cptr, 1, 0, HUGE);
    } else if (cmd == 0165154) {	// 'ul', underline lines
	ulval = getval(cptr, 1, 1, HUGE);
    } else if (cmd == 0142157) {	// 'bo', embolden lines
	boval = getval(cptr, 1, 1, HUGE);
    } else if (cmd == 0150145) {	// 'he'
	gettl(cptr, header);
    } else if (cmd == 0146157) {	// 'fo'
	gettl(cptr, footer);
    } else if (cmd == 0160154) {	// 'pl', set page length value
	plval = getval(cptr, PAGELEN,
		       m1val + m2val + m3val + m4val + 1, HUGE);
	bottom = plval - m3val - m4val;
    } else if (cmd == 0164141)		// 'ta', set tab values
	do_ta(cptr);
      else if (cmd == 0154151)		// 'li', set literal count
	lival = getval(cptr, 1, 0, HUGE);
      else if (cmd == 0150143) {	// 'hc', set hyphenation character
	// Skip whitespace
	while (*cptr == ' ' || *cptr == '\t') cptr++;
	hypchar= *cptr;
      }
	
}

// Deal with a new input line of text. We may print multiple
// output lines in the process, or we may not print anything
void text(Char * inbuf, Char * outbuf)
{
    Char *inp = inbuf;		// Start at the beginning of the input buffer
    int linelen = rmval - tival; // Working length of the line
    int i, len, nextra;
    int tabposn, tabentry = 0;
    int spacecount;
    Char *x;

    // Underline non-space characters, embolden all characters as required
    while (*inp) {
        if (ulval) {
	    if (is_underl(*inp))
		// Mark the underlined characters with the ULMASK
		*inp = *inp | ULMASK;
	}
        if (boval) {
		*inp = *inp | BOLDMASK;
  	}
	inp++;
    }

    if (ulval) ulval--;
    if (boval) boval--;
    inp = inbuf;		// Reset for next piece of code

    while (*inp) {		// While the input buffer has something
	// Skip spaces
	if (*inp == ' ') {
	    inp++;
	    continue;
	}

	// Expand tabs
	if (*inp == '\t') {
	    // Get the next tab position
	    tabposn = tablist[tabentry++];
	    if (tabentry == MAXTABS)
		tabentry--;

	    // Work out how many extra spaces to add, and add them
	    // We include tival so that it's absolute from column 1
	    spacecount = tabposn - outlen - tival;
	    for (i = 1; i < spacecount; i++) {
		*outp = ' ';
		outp++;
		outlen++;
	    }
	    inp++;
	    continue;
	}

	// We are at the beginning of a word. Get its length
	len = Wordlen(inp);

	// Work out how many extra characters are needed on the output line
	// Subtract 1 if we already have something, to account for a space char
	nextra = linelen - outlen;
	if (outlen) nextra--;

	// Special case: the word is larger than the linelen, so
	// it will never fit on any line. Set len so that we
	// forcibly break the word into two sections
	if (len > linelen)
	    len = nextra;

	// If the word is too long but we have a hyphenation point
	// that will fit, use the hypehnation length. Change the
	// hyphenation character to a '-'.
	if (len > nextra && hyplen != 0 && hyplen <= nextra) {
	    len= hyplen;
	    x= inp + hyplen - 1;	// XXX why not the next line?
	    *x= '-';
	    //inp[ hyplen - 1  ]='-';
	    hyplen=0;	// It's no longer a hypchar to skip below
	}

	// If we can squeeze a space and the word onto the line, do it
	if (nextra >= len) {

	    // Add a space if this isn't the beginning of the line
	    if (outlen) {
		*outp = ' ';
		outp++; outlen++;
	    }

	    // Copy the word and bump up the pointers
	    // Also account for any hyphenation character
	    Wordcopy(outp, inp, len);
	    inp = inp + len;
	    if (hyplen) inp++;
	    outp = outp + len;
	    outlen = outlen + len;
	} else {

	    // We can't add any more to the line
	    // Spread the line if justify is on and centre is off
	    if (justify && ceval == 0) {
		nextra = linelen - outlen;
		spread(outbuf, nextra);
	    }

	    // And print it out
	    brkline();
	}
    }

    // We have reached the end of the input line. Break if no fill
    if (fill==0)		// XXX ! is not working in H
	brkline();
}

// put: put out line with proper spacing and indenting
void put(Char * buf)
{
    int i, nextra;
    Char ch, ulflag, boflag;

    // Print out the header
    if (lineno == 0 || lineno > bottom)
	phead();

    // Centering is done by setting a temporary indent value
    if (ceval) {
	i= Strlen(buf);		// XXX Why can't I put this below?
	tival = (rmval + tival - i) / 2;
	if (tival < 0)
	    tival = 0;
	ceval--;
    }

    // Print out the temporary indent spaces
    // and reset back to the usual indent value
    for (i = 0; i < tival; i++)
	putchar(' ');
    tival = inval;

    // Now process each character one at a time
    while (1) {

	// Get the actual ASCII value and the underline flag
	ch = *buf & ASCIIMASK;
	ulflag = *buf & ULMASK;
	boflag = *buf & BOLDMASK;
	if (ch == '\0')
	    break;

	// If this is a space, print out any extra spaces
	// by getting the extra space count in the upper half
	// of the word
	if (ch == ' ') {
	    nextra = *buf >> 9;
	    for (i = 0; i != nextra; i++)
		putchar(' ');
	}
	// Underline the character if the flag is set
	// Do the same for bold characters
	if (ulflag) {
	    putchar('_');
	    putchar(8);		// 8 is ASCII backspace
	}
	if (boflag) {
	    putchar(ch);
	    putchar(8);		// 8 is ASCII backspace
	}
	putchar(ch);
	buf++;
    }

    // End with a newline
    putchar('\n');

    // Do any end of page padding
    i = min(lsval - 1, bottom - lineno);
    skip(i);

    // Print out the footer if required
    lineno = lineno + lsval;
    if (lineno > bottom)
	pfoot();
}


// Mark up the spaces in the buffer so that there are nextra spaces
// Do this by storing an int value in the upper half of the word
void spread(Char * buf, int nextra)
{
    int buflen = Strlen(buf);
    Char *start;
    Char *end;
    Char *cptr;
    Char ch;

    // Set up the start and end based on the current direction
    if (direction == 1) {
	start = buf;
	end = buf + buflen;
    } else {
	end = buf;
	start = buf + buflen;
    }

    // Loop until we have added nextra spaces
    while (nextra > 0) {
	for (cptr = start; cptr != end; cptr = cptr + direction) {
	    // Get the ASCII character
	    ch = *cptr & ASCIIMASK;

	    // If the actual character is a space
	    if (nextra && ch == ' ') {
		*cptr = *cptr + EXTRASPACE;	// Add an extra space marker
		nextra--;
	    }
	}
    }
    direction = 0 - direction;			// Swap direction for next time
}

// Get an integer value following a command
// Check the range, and possibly set a default value
int getval(Char * buf, int defval, int minval, int maxval)
{
    int val;

    // Skip any spaces
    while (*buf == ' ' || *buf == '\t')
	buf++;

    // Return the default
    if (*buf == '\0')
	return (defval);

    // Get the value and ensure it is within range
    val = ctoi(buf);
    if (val < minval)
	val = minval;
    if (val > maxval)
	val = maxval;
    return (val);
}

// Get the tab positions from the input line and store them in
// the tablist
void do_ta(Char * buf)
{
    int i;
    int val;

    for (i = 0; i < MAXTABS; i++) {
	// Skip leading spaces
	while (*buf == ' ' || *buf == '\t' || *buf == '\0') {
	    if (*buf == '\0')
		return;
	    buf++;
	}
	val = ctoi(buf);
	tablist[i] = val;
	// Now skip the number
	while (*buf != ' ' && *buf != '\t' && *buf != '\0') {
	    buf++;
	}
	if (*buf == '\0')
	    return;
    }
}

//  gettl: copy title from buf to ttl
void gettl(Char * buf, Char * ttl)
{
    int i;

    // Skip any spaces and tabs
    while (*buf == ' ' || *buf == '\t')
	buf++;
    Strcpy(ttl, buf);
    return;
}


// Read a line of text from the given fd into inbuf.
// Return EOFILE on end of line, otherwise not EOFILE.
// Ensure the line is NUL terminated.
Char getlin(Char * buf, int maxlen, int fd)
{
    int i;
    Char c;
    for (i = 0; i < maxlen - 1; i++) {
	c = getchar();
	if (c == EOFILE || c == '\n')
	    break;
	*buf = c;
	buf++;
    }
    *buf = '\0';
    return (c);
}

//  brkline: end and print current filled line
void brkline()
{
    // Print the line if something is in it
    if (outlen)
	put(outbuf);

    // Now an empty line
    outp = outbuf;
    outlen = 0;
    return;
}

// space: space n lines or to bottom of page
void space(int n)
{
    int s;

    // Print out any remaining output line
    brkline();

    // Stop now, or print the header as required
    if (lineno > bottom)
	return;
    if (lineno == 0)
	phead();

    // Work out how many empty lines to print
    s = min(n, bottom + 1 - lineno);
    skip(s);

    // And print the footer as required
    lineno = lineno + n;
    if (lineno > bottom)
	pfoot();
    return;
}

// pfoot: put out page footer
void pfoot()
{
    skip(m3val);
    if (m4val > 0) {
	puttl(footer, curpag);
	skip(m4val - 1);
    }
}

// phead: put out page header
void phead()
{
    curpag = newpag;
    newpag++;
    if (m1val > 0) {
	skip(m1val - 1);
	puttl(header, curpag);
    }
    skip(m2val);
    lineno = m1val + m2val + 1;
}

// puttl: put out title line with optional page number
void puttl(Char * t, int pageno)
{
    Char *pgnumstring;
    Char separator;
    int i, l, m, n, pstlen;

    // Get the character that separates the three sections
    separator = *t;
    if (separator == '\0') {
	putchar('\n');
	return;
    }
    // Convert the page number into text
    pgnumstring = itoa(pageno);
    pstlen = Strlen(pgnumstring);

    // Move up past the quote and get length of first part
    // then print it out
    t++; l = titlen(t, separator, pstlen);
    t = partitle(t, separator, pgnumstring);
    if (*t == '\0') {
	putchar('\n');
	return;
    }
    // Get the length of the middle part
    t++; m = titlen(t, separator, pstlen);

    // Space out so we can print the middle out
    for (i = l; i < (rmval - m) / 2; i++)
	putchar(' ');
    t = partitle(t, separator, pgnumstring);
    if (*t == '\0') {
	putchar('\n');
	return;
    }
    if ((rmval - m) / 2 > l)
	m = m + (rmval - m) / 2;
    else
	m = m + l;
    // Get the length of the last bit
    t++; n = titlen(t, separator, pstlen);

    for (i = m; i < rmval - n; i++)
	putchar(' ');
    partitle(t, separator, pgnumstring);
    putchar('\n');
}

// Print out a part of the title. Return a pointer to the separator
Char *partitle(Char * t, Char sep, Char * pgnum)
{
    while (1) {
	// Stop when we reach the separator
	if (*t == sep || *t == '\0')
	    return (t);

	// Print out the character, or the page number on %
	if (*t == '%') {
	    while (*pgnum) {
		putchar(*pgnum);
		pgnum++;
	    }
	} else
	    putchar(*t);
	t++;
    }
    return (t);
}

//  skip: output n blank lines
void skip(int n)
{
    int i;

    for (i = 0; i < n; i++)
	putchar('\n');
    return;
}

// ctoi - convert string to int
int ctoi(Char * in)
{
    int k = 0;
    int negval = 0;
    // Skip + and -, and set the negval
    if (*in == '+')
	in++;
    if (*in == '-') {
	negval = 1;
	in++;
    }

    // Read digits, convert to ints
    while (1) {
	if (*in < '0' || *in > '9')
	    break;
	// Move up old value and add on next digit
	k = 10 * k + *in - '0';
	in++;
    }

    // Turn into a negative value if required
    if (negval)
	return (0 - k);
    else
	return (k);
}

// Return the length of the string that c points at
int Strlen(Char * c)
{
    int n = 0;
    while (*c != '\0') {
	c++;
	n++;
    }
    return (n);
}

// Return the length of the word that c points at
// Also set the position of the first hypchar, or 0 if no hypchar
int Wordlen(Char * c)
{
    int n = 0;
    hyplen=0;
    while (*c != '\0' && *c != ' ' && *c != '\t') {
	if (*c == hypchar) {
	    if (hyplen==0) hyplen= n + 1;
	} else {
	    n++;
	}
	c++;
    }
    return (n);
}

// Given a character, return 1 if it can be underlined, 0 otherwise
int is_underl(Char ch)
{
    if (ch == ' ' || ch == '\t' || ch == '!' || ch == ','
	|| ch == '.' || ch == ';' || ch == ':')
	return (0);
    return (1);
}

// Copy a string from src to dst
void Strcpy(Char * dst, Char * src)
{
    while (*src != '\0') {
	*dst = *src;
	dst++;
	src++;
    }
    *dst = '\0';
}

// Copy up to n characters from one string to another
// Like strncpy but we also deal with the hyphenation character
void Wordcopy(Char * dst, Char * src, int n)
{
    while (*src != '\0' && n) {
	if (*src != hypchar) {
	  *dst = *src;
	  dst++;
	  n--;
	}
	src++;
    }
    *dst = '\0';
}

// Convert an integer into a string and return a pointer to it
Char *itoa(int n)
{
    Char *digitptr;
    digitptr = tempbuf + 9;		// i.e digiptr= &tempbuf[9]
    *digitptr = '\0';
    digitptr--;

    while (n != 0) {
	*digitptr = (n % 10) + '0';	// Store a digit
	digitptr--;
	n = n / 10;
    }

    return (digitptr + 1);
}

// Given a title string just past the dividing character
// the dividing character in c, and the length of the
// page number in characters, return the length of the title
// Comes from Minix roff.
int titlen(Char * t, Char c, int k)
{
    int q;
    q = 0;
    while (1) {
	if (*t == 0)
	    break;
	if (*t == c)
	    break;
	if (*t == '%')
	    q = q + k;
	else
	    q++;
	t++;
    }
    return (q);
}

// Find the minimum of two integers
int min(int a, int b)
{
    if (a < b)
	return (a);
    else
	return (b);
}

// Put out a string with a newline
void Puts(Char * c)
{
    char ch;
    while (*c != '\0') {
	ch = *c;
	putchar(ch);
	c++;
    }
    putchar('\n');
}
