#include <stdio.h>

const char *
cstr_terminated1 (void)
{
  static const char *str = "hello";

  printf ("C: %s: returning %s\n", __func__, str);
  return str;
}

void
cstr_terminated2 (const char *str)
{
  printf ("C: %s: received %s\n", __func__, str);
}

void
cstr_unterminated1 (char **str, size_t *size)
{
  static char buf[8];

  buf [0] = 'h';
  buf [1] = 'e';
  buf [2] = 'l';
  buf [3] = 'l';
  buf [4] = 'o';

  *str = buf;
  *size = 5;

  printf ("C: %s: returning %c%c%c%c%c %d\n", __func__,
    buf [0], buf [1], buf [2], buf [3], buf [4], *size);
}

void
cstr_unterminated2 (const char *str, size_t size)
{
  size_t index;

  printf ("C: %s: hexdump ", __func__);

  for (index = 0; index < size; ++index) {
    printf ("%.2hhx", str [index]);
  }
  printf (" %lu\n", size);
}
