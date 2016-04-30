void puts(char *c)
{
  while (*c != '\0') {
    putchar(*c); c++;
  }
}

void main()
{
  char *x= "X now has a string attached\n";
  puts(x);
  x= x + 6;
  puts(x);
  x[12]='\n';
  x[13]='\0';
  puts(x);
}
