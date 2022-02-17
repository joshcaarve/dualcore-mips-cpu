/*
    Joshua Brard
    jbrard@purdue.edu
*/

`ifndef PROGRAM_COUNTER_IF_VH
`define PROGRAM_COUNTER_IF_VH

`include "cpu_types_pkg.vh"

interface program_counter_if;

    import cpu_types_pkg::*;

    word_t pc_in;  // pc_in
    word_t pc_out; // pc out
    logic pc_WEN;  // cnt enable
    modport pc (
        input pc_in, pc_WEN,
        output pc_out
    );

endinterface : program_counter_if

`endif