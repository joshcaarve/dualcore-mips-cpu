/*
	Joshua Brard
	jbrard@purdue.edu

    this block is the coherence protocol
    and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif

);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  parameter CPUS = 2;

  always_comb begin
    // cache outputs
    ccif.iwait = 1'b1;
    ccif.dwait = 1'b1;

    ccif.iload = '0;
    ccif.dload = '0;

    // ram outputs
    ccif.ramstore = '0;
    ccif.ramaddr = '0;
    ccif.ramWEN = '0;
    ccif.ramREN = '0;

    // coherence outputs to cache
    ccif.ccwait = '0;
    ccif.ccinv = '0;
    ccif.ccsnoopaddr = '0;

    if(ccif.ramstate == ACCESS) begin
      if(ccif.dREN) begin
        ccif.dwait = 1'b0;
      end
      else if(ccif.dWEN) begin
        ccif.dwait = 1'b0;
      end
      else if (ccif.iREN) begin
        ccif.iwait = 1'b0;
      end
    end

    else begin
      ccif.dwait = 1'b1;
      ccif.iwait = 1'b1;
    end

    // data read
    if(ccif.dREN) begin
      ccif.ramaddr = ccif.daddr;
      ccif.ramREN = ccif.dREN;
      ccif.dload = ccif.ramload;
    end

    // data write
    else if (ccif.dWEN) begin
      ccif.ramaddr = ccif.daddr;
      ccif.ramWEN = ccif.dWEN;
      ccif.ramstore = ccif.dstore;
    end

    // instruction
    else if (ccif.iREN) begin
      ccif.ramaddr = ccif.iaddr;
      ccif.ramREN = ccif.iREN;
      ccif.iload = ccif.ramload;
    end
  end

endmodule : memory_control
