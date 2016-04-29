void main()
{
  int x;
  int y;
  int z;

  for (x=1; x != 11; x++) {
    for (y=1; y != 11; y++) {
      z= x * y;
      printn(z);
    }
    if (x==5) break;
  }
}

