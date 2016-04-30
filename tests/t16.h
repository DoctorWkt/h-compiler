void main()
{
  int x;
  int y=4;

  for (x=0; x != 8; x++) {
    if (x<y)
      putchar('<');
    printn(x);
  }
  putchar('\n');

  for (x=0; x != 8; x++) {
    if (x>=y) {
      putchar('>');
      putchar('=');
    }
    printn(x);
  }
  putchar('\n');

  for (x=0; x != 8; x++) {
    if (x>y) {
      putchar('>');
    }
    printn(x);
  }
  putchar('\n');

  for (x=0; x != 8; x++) {
    if (x<=y) {
      putchar('<');
      putchar('=');
    }
    printn(x);
  }
}
