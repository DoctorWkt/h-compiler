int x = 2;
int y = 32;
int z = 8;
int a;
int b;

void main()
{
fred:
  a= y >> 3;
  a++;
  return;
  goto fred;
  a= y >> 3;
  a--;
}
