/*
    Joshua Brard
    jbrard@purdue.edu

    simple mux

*/

`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

module mux_2 (
    input word_t in_0,
    input word_t in_1,
    input logic control,

    output word_t out
);
    import cpu_types_pkg::*;

    assign out = control ? in_1 : in_0;

endmodule : mux_2

