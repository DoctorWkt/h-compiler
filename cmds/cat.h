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
  int fd;
  int cnt;
  int a;
  char *file;

  for (a=1; a < argc; a++) {
    file= argv[a];
    fd= open(file, 0);
    if (fd == -1) {
      puts("cannot open file\n");
      exit();
    }
      
    while (1) {
      cnt= read(fd, buffer, BUFLEN);
      if (cnt==0) break;
      write(1, buffer, cnt);
    }
    close(fd);
  }
  exit();
}
