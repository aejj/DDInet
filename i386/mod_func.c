#include <stdio.h>
#include "hocdec.h"
extern int nrnmpi_myid;
extern int nrn_nobanner_;
modl_reg(){
  if (!nrn_nobanner_) if (nrnmpi_myid < 1) {
    fprintf(stderr, "Additional mechanisms from files\n");

    fprintf(stderr," kamt.mod");
    fprintf(stderr," kdrmt.mod");
    fprintf(stderr," naxn.mod");
    fprintf(stderr," nmdanet.mod");
    fprintf(stderr, "\n");
  }
  _kamt_reg();
  _kdrmt_reg();
  _naxn_reg();
  _nmdanet_reg();
}
