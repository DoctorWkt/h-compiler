int c[]= { 1,2,3,4 };

void main()
{
  int i;
  for (i=0; i!= 4; i++)
    printn( c[i] );
  putchar('\n');

  for (i=0; i!= 4; i++) 
    c[i]++;

  for (i=0; i!= 4; i++)
    printn( c[i] );
  putchar('\n');

  for (i=0; i!= 4; i++) 
    c[i]--;

  for (i=0; i!= 4; i++)
    printn( c[i] );
}
