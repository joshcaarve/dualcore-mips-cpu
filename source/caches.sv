/*
	Joshua Brard
	jbrard@purdue.edu

  this block holds the i and d cache
*/


// interfaces
`include "datapath_cache_if.vh"
`include "caches_if.vh"

// cpu types
`include "cpu_types_pkg.vh"


module caches (
  input logic CLK, nRST,
  datapath_cache_if dcif,
  caches_if cif
);
  import cpu_types_pkg::*;

  // dcache
  dcache  DCACHE(CLK, nRST, cif, dcif);

  // icache
  icache  ICACHE(CLK, nRST, dcif.halt, cif, dcif);
  /*
  word_t instr;
  word_t daddr;


  //singlecycle
  assign dcif.ihit = (dcif.imemREN) ? ~cif.iwait : 0;
  assign dcif.dhit = (dcif.dmemREN|dcif.dmemWEN) ? ~cif.dwait : 0;
  assign dcif.imemload = cif.iload;
  assign dcif.dmemload = cif.dload;

  assign cif.iREN = dcif.imemREN;
  assign cif.dREN = dcif.dmemREN;
  assign cif.dWEN = dcif.dmemWEN;
  assign cif.dstore = dcif.dmemstore;
  assign cif.iaddr = dcif.imemaddr;
  assign cif.daddr = dcif.dmemaddr;
  */


endmodule : caches
