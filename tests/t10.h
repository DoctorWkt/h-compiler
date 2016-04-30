int c[]= { 1,3,5,7,9 };
void main()
{
  int x;
  int y=3;
  int z=4;

  x= y + z;
  printn(x);
  x= c[0] + y;
  printn(x);
  x= y + c[2];
  printn(x);
  x= c[1] + c[2];
  printn(x);
  x= c[2] + c[3] + c[4];
  printn(x);
}

