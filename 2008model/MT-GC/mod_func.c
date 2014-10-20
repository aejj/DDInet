#include <stdio.h>
#include "hocdec.h"
#define IMPORT extern __declspec(dllimport)
IMPORT int nrnmpi_myid, nrn_nobanner_;

extern void _kamt_reg();
extern void _kdrmt_reg();
extern void _naxn_reg();
extern void _nmdanetOB_reg();

modl_reg(){
	//nrn_mswindll_stdio(stdin, stdout, stderr);
    if (!nrn_nobanner_) if (nrnmpi_myid < 1) {
	fprintf(stderr, "Additional mechanisms from files\n");

fprintf(stderr," kamt.mod");
fprintf(stderr," kdrmt.mod");
fprintf(stderr," naxn.mod");
fprintf(stderr," nmdanetOB.mod");
fprintf(stderr, "\n");
    }
_kamt_reg();
_kdrmt_reg();
_naxn_reg();
_nmdanetOB_reg();
}
