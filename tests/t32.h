recursive void printnum(int x)
{
  int remainder, dividend;
  if (x==0) return;
  remainder= x%10;
  dividend= x/10;
  printnum(dividend);
  putchar(remainder + '0');
}

void main()
{
  printnum(1234);
  putchar('\n');
}
