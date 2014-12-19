#include <stdio.h>
#include "hocdec.h"
#define IMPORT extern __declspec(dllimport)
IMPORT int nrnmpi_myid, nrn_nobanner_;

extern void _ThreshDetect_reg();
extern void _ampanmda_reg();
extern void _fi_reg();
extern void _kamt_reg();
extern void _kdrmt_reg();
extern void _naxn_reg();

modl_reg(){
	//nrn_mswindll_stdio(stdin, stdout, stderr);
    if (!nrn_nobanner_) if (nrnmpi_myid < 1) {
	fprintf(stderr, "Additional mechanisms from files\n");

fprintf(stderr," ThreshDetect.mod");
fprintf(stderr," ampanmda.mod");
fprintf(stderr," fi.mod");
fprintf(stderr," kamt.mod");
fprintf(stderr," kdrmt.mod");
fprintf(stderr," naxn.mod");
fprintf(stderr, "\n");
    }
_ThreshDetect_reg();
_ampanmda_reg();
_fi_reg();
_kamt_reg();
_kdrmt_reg();
_naxn_reg();
}
