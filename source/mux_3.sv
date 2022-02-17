/*
    Joshua Brard
    jbrard@purdue.edu

    simple mux

*/


module mux_3 #(
    parameter NUM_BITS = 32
) (
    input logic [NUM_BITS - 1 : 0] in_0,
    input logic [NUM_BITS - 1 : 0] in_1,
    input logic [NUM_BITS - 1 : 0] in_2,
    input logic [1 : 0] control,

    output logic [NUM_BITS - 1 : 0] out
);
    // For the BusW (wdat) 3 way mux
    // in0: busW after the 2 way mux
    // in1: pc + 4
    // in2: extender_out

    always_comb begin
        out = in_0;
        casez(control)
            2'b00: out = in_0;
            2'b01: out = in_1;
            2'b10: out = in_2;
        endcase
    end

endmodule : mux_3

