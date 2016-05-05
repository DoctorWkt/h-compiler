#define BUFLEN 64
char buffer[BUFLEN];

void puts(char *c)
{
  while (*c != '\0') {
    putchar(*c); c++;
  }
}

void main(int argc, char *argv)
{
  int ifd;
  int ofd;
  int cnt;

  if (argc != 3) {
    puts("usage: cp src dst\n");
    exit();
  }

  ifd= open(argv[1], 0);
  if (ifd == -1) {
    puts("cannot open src\n");
    exit();
  }
  ofd= open(argv[2], 1);
  if (ofd == -1) {
    puts("cannot open dst\n");
    exit();
  }

  while (1) {
    cnt= read(ifd, buffer, BUFLEN);
    if (cnt==0) break;
    write(ofd, buffer, cnt);
  }
  close(ifd); close(ofd);
  }
  exit();
}
