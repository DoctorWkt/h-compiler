char str1[]= "This is my first string\n";
void puts(char *c);

void puts(char *c)
{
  while (*c != '\0') {
    putchar(*c); c++;
  }
}

void main()
{
  puts(str1);
  puts("and this should get printed, too.\n");
}
