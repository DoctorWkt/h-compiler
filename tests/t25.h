void main()
{
  int o_ll=000101;
  int m=000000;
  int l=000007;

  printn(o_ll);
  printn(m);
  printn(l);
  if ((o_ll - m) / 2 > l)
        m = m + (o_ll - m) / 2;
  else
        m = m + l;
  printn(m);
}
