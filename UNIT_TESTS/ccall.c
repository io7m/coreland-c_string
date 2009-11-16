#include <stdio.h>
#include <stdlib.h>

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

unsigned int
ccall_input_term (const char **data)
{
  unsigned int count = 0;
  const char *index;

  printf ("-- C start\n");

  for (;;) {
    index = data [count];
    if (index == NULL) {
      printf ("[%u] %s\n", count, "NULL");
      break;
    } else {
      printf ("[%u] %s\n", count, index);
    }
    ++count;
  }

  printf ("-- C exit\n");
  return count;
}

unsigned int
ccall_input_unterm (const char **data, unsigned int size)
{
  unsigned int count = 0;
  const char *index;

  printf ("-- C start\n");

  for (;;) {
    if (count == size) break;
    index = data [count];
    if (index == NULL) {
      printf ("[%u] %s\n", count, "NULL");
    } else {
      printf ("[%u] %s\n", count, index);
    }
    ++count;
  }

  printf ("-- C exit\n");
  return count;
}

/*
 * Test the assumption that an Ada String_Ptr_t null == C NULL.
 */

int
ccall_assume (const char *data)
{
  return data == NULL;
}
