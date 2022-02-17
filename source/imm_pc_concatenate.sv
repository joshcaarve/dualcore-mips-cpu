/*
    Joshua Brard
    jbrard@purdue.edu

    for jump instructions

*/


`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

module imm_pc_concatenate (
    input logic [25 : 0] imm_26,
    input logic [3 : 0] pc,

    output word_t out
);
    /*
    logic [27 : 0] imm_28;
    always_comb begin
        imm_28 = imm_26 << 2;
        out = {pc, imm_28};
    end
    */
    assign out = {pc, imm_26 << 2};
endmodule : imm_pc_concatenate