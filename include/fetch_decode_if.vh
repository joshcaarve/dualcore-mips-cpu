/*
    Joshua Brard && Rohan Prabhu
    jbrard@purdue.edu Prabhu4@purdue.edu
*/


`ifndef FETCH_DECODE_IF_VH
`define FETCH_DECODE_IF_VH

`include "cpu_types_pkg.vh"

interface fetch_decode_if;
    import cpu_types_pkg::*;

    logic update;
    logic flush;

    word_t normal_pc_in;   // PC +  4
    word_t instruction_in;  // imemload
    word_t next_pc_in;   // coming out of the PC module


    word_t instruction_out;  // imemload
    word_t normal_pc_out;   // PC +  4
    word_t next_pc_out;   // coming out of the PC module

    modport fd (
        input update, flush, instruction_in, normal_pc_in, next_pc_in,
        output instruction_out, normal_pc_out, next_pc_out
    );

endinterface : fetch_decode_if

`endif