#define BUFLEN 64
char buffer[BUFLEN];
void main(int argc, char *argv)
{
  int fd;
  int cnt;
  int a;
  char *file;

  for (a=1; a < argc; a++) {
    file= argv[a];
    fd= open(file, 0);
    while (1) {
      cnt= read(fd, buffer, BUFLEN);
      if (cnt==0) break;
      write(1, buffer, cnt);
    }
    close(fd);
  }
  exit();
}
