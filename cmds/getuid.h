void puts(char *c)
{
  while (*c != '\0') {
    putchar(*c); c++;
  }
}

void main()
{
  int id= getuid();
  puts("My uid is ");
  printn(id);
  exit();
}
