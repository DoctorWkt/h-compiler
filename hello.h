int x = 2;
int y = 32;
int z = 8;
int a;
int b;

int fred(int p, int q, int r)
{
  p= 3;
  x= p + q + r;
}


void main()
{
  fred(x,y,z);
  x = x + 3;
}
