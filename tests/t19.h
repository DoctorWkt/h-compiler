char str1[]= "This is my first string\n";

void puts(char *c)
{
  while (*c) {
    putchar(*c); c++;
  }
}

int strlen(char *c)
{
  int n=0;
  while (*c) {
    c++; n++;
  }
  return(n);
}

void main()
{
  int len;
  int x=1;

  puts(str1);
  len= strlen(str1);
  printn(len);

  while (1) {
    printn(x); x++;
    if (x==8) break;
  }
}
