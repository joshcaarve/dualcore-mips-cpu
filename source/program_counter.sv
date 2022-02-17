/*
    Joshua Brard
    jbrard@purdue.edu
*/


`include "cpu_types_pkg.vh"
`include "program_counter_if.vh"

module program_counter (
    input logic clk,
    input logic nRst,
    program_counter_if.pc pcif
);
    parameter PC_INIT = '0;

    import cpu_types_pkg::*;

    always_ff @ (posedge clk, negedge nRst) begin
        if (nRst == 1'b0) begin
            pcif.pc_out <= PC_INIT;
        end
        else if(pcif.pc_WEN) begin
            pcif.pc_out <= pcif.pc_in;
        end
    end

endmodule : program_counter


