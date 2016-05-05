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
  int err;
  int a;
  char *file;

  for (a=1; a < argc; a++) {
    file= argv[a];
    err= unlink(file);
    if (err == -1) {
      puts("cannot unlink file\n");
      exit();
    }
  }
  exit();
}
