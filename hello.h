char str1[]= "This is my first string\n";
void puts(char *c);

void main()
{
  int x;

  puts(str1);
  puts("and this should get printed, too.\n");

  for (x=00; x != 020; x++)
    printn(x);
}

void puts(char *c)
{
  while (*c != '\0') {
    putchar(*c); c++;
  }
}

