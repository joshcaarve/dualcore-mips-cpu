/*
    Joshua Brard
    jbrard@purdue.edu

    simple 4 mux

*/


`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;


module mux_4 (
    input word_t in_0, in_1, in_2, in_3,
    input logic [2 : 0] control,

    output word_t out
);
    import cpu_types_pkg::*;

    always_comb begin
        out = in_0;
        casez (control)
            3'b000: out = in_0;
            3'b001: out = in_1;
            3'b010: out = in_2;
            3'b100: out = in_3;
        endcase
    end

endmodule : mux_4