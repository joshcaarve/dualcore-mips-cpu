/*
  Joshua Brard
  jbrard@purdue.edu

  alu interface
*/
`ifndef ALU_IF_VH
`define ALU_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface alu_if;
  // import types
  import cpu_types_pkg::*;

  logic negative, overflow, zero;
  word_t portA, portB, portOut;
  aluop_t aluop;

  // alu ports
  modport rf (
    input   portA, portB, aluop,
    output  negative, portOut, overflow, zero
  );
  // alu tb
  modport tb (
    input   negative, portOut, overflow, zero,
    output  portA, portB, aluop
  );
endinterface

`endif // ALU_IF_VH