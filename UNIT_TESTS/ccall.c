#include <stdio.h>

static const char *strings[] = {
  "abcdefgh",
  "zyxwvuts",
  "12345678",
  "klmnopqr",
  "@@@@@@@@",
  "&&&&&&&&",
  0,
};

int
ccall_size (void)
{
  return sizeof (strings) / sizeof (strings[0]);
}

const char **
ccall (void)
{
  unsigned int index;

  printf ("-- C start\n");

  for (index = 0; index < sizeof (strings) / sizeof (strings[0]); ++index)
    printf ("[%d] %p %s\n", index, (void *) &strings [index], strings[index]);

  printf ("-- C exit\n");
  return strings;
}
