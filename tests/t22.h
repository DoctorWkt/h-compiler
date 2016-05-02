#define EOF 4
int islegal(int c)
{
    if (c >= ' ') {
        if (c <= '~') {
            return(1);
        }
    }
    if (c == ' ') return(1);
    if (c == '\t') return(1);
    if (c == '\n') return(1);
    if (c == EOF) return(1);
    return(0);
}

void main()
{
  char ch;

  for (ch=-30; ch != 300; ch++) {
    if (islegal(ch)) {
      putchar(ch); putchar(' '); printn(ch);
    }
  }
  exit();
}
