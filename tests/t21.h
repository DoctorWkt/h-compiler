void main()
{
  int x;
  for (x=-6; x != 7; x++) {
    if (x)		// Test that this works
      printn(x);
  }
  putchar('\n');

  for (x=-6; x != 7; x++) {
    if (x)		// Test that this works
      printn(x);
    else
      printn(45);
  }
  putchar('\n');

  x=-6;
  while (x) {		// Test that this works
    printn(x); x++;
  }
  putchar('\n');

  x= -6;
  do {
    printn(x); x++;
  } while (x);		// Test that this works
  putchar('\n');

  for (x=-6; x; x++) {	// Test that this works
    printn(x);
  }
  

}
