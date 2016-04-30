char a[]= "This is a string";

void main()
{
  char *x;

  // Print the string
  for (x=a; *x != 0; x++) putchar(*x);
  putchar(10);

  // Shorten it
  a[4]= 0;

  // Print the string
  for (x=a; *x != 0; x++) putchar(*x);
  putchar(10);
}

