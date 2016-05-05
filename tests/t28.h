void main(int argc, char *argv)
{
  int i;
  for (i=-3; i != 4; i++) {
    printn(i);
    printn(i && 1);
    putchar('\n');
  }
}
