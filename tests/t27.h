void main()
{
  int i;

  for (i=0; i < 32; i++) {
    if (i > 8 && i < 20)
      printn(i);
  }
  putchar('\n');
  for (i=0; i < 32; i++) {
    if (i == 8 || i == 16 || i==24)
      printn(i);
  }
}
