char str1[]= "This is my first string\n";
char buf[100];
char tempbuf[10];

void puts(char *c)
{
  while (*c != '\0') {
    putchar(*c); c++;
  }
}

int strlen(char *c)
{
  int n=0;
  while (*c != '\0') {
    c++; n++;
  }
  return(n);
}

void strcpy(char *dst, char *src)
{
  while (*src != '\0') {
    *dst= *src;
    dst++; src++;
  }
  *dst='\0';
}

/* Given a number, convert the number
 * into ASCII digits and store in the
 * printbuf array. Null terminate the
 * string. Return a pointer to the first
 * digit in the character.
 */
char *itoa(int n)
{
  char *digitptr;
  digitptr= tempbuf + 9;        /* i.e digiptr= &tempbuf[9] */
  *digitptr= '\0';
  digitptr--;

  while (n != 0) {
    *digitptr = (n%10) + '0';   /* Store a digit */
    digitptr--;
    n=n/10;
  }

  return(digitptr+1);
}



void main()
{
  char *x= str1;
  int len;

  puts(x);
  x++; puts(x);
  len= strlen(x);
  printn(len);
  strcpy(buf, str1);
  puts(str1);
  x= itoa(12345);
  puts(x);
  putchar('\n');
}
