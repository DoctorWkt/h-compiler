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
  if (argc != 3) {
    puts("usage: mv src dst\n");
    exit();
  }
  rename(argv[1], argv[2]);
  exit();
}
