char a[]= "This is a string";

void main()
{
  char *x;

  // Print the string
  x=a;
  while (*x != 0) {
    putchar(*x); x++;
  }
  putchar(10);

  // Shorten it
  a[4]= 0;

  // Print the string
  x=a;
  while (*x != 0) {
    putchar(*x); x++;
  }
  putchar(10);
}

