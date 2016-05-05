char buffer[] = "This is a test line\n";

void puts(char *c)
{
  while (*c != '\0') {
    putchar(*c); c++;
  }
}

void main(int argc, char *argv)
{
  int ofd;
  int cnt;

  if (argc != 2) {
    puts("usage: creat dst\n");
    exit();
  }

  ofd= creat(argv[1]);
  if (ofd == -1) {
    puts("cannot create dst\n");
    exit();
  }

  write(ofd, buffer, 20);
  close(ofd);
  exit();
}
