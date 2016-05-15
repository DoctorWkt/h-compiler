recursive int fact(int x)
{
  if (x==1) return(x);
  return(fact(x - 1) * x);
}

void main()
{
  int x;
  x= fact(6);
  printn(x);
}
