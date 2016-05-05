void puts(char *c)
{
  while (*c != '\0') {
    putchar(*c); c++;
  }
}

void main()
{
  int id= time();
  puts("The time is ");
  printn(id);
  exit();
}
