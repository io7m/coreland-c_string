#include "ctxt.h"
#include "install.h"

struct install_item insthier[] = {
  {INST_COPY, "generic-conf.c", 0, ctxt_repos, 0, 0, 0644},
};
unsigned long insthier_len = sizeof(insthier) / sizeof(struct install_item);
