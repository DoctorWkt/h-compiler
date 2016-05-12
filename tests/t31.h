char str1[]="Hello";
int ilist1[]= { 1, 2, 3};
int empty1[4];
void main(int argc, char *argv)
{
  char str2[]="abc";			// Local arrays now!
  int ilist2[]= {1, 4, 2};
  int empty1[4];
  int x;

  x=str1[0]; putchar(x); putchar('\n');
  x=str2[0]; putchar(x); putchar('\n');

  x= ilist1[2]; printn(x);
  x= ilist2[2]; printn(x);

  empty1[2]= 2 + 3; printn(empty1[2]);
}
