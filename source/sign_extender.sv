/*
    Joshua Brard
    jbrard@purdue.edu

    00 : ZERO_EXT
    01 : SIGN_EXT
    10 : LIU_CAT
*/
`include "cpu_types_pkg.vh"
`include "my_types_pkg.vh"

`include "control_unit_if.vh"

import cpu_types_pkg::*;
import my_types_pkg::*;


module sign_extender (
    input logic [15 : 0] immediate_16,
    input ext_code_t ext_code,
    output word_t out_32
);
    import cpu_types_pkg::*;
    import my_types_pkg::*;

    always_comb begin
        out_32 = {immediate_16, immediate_16};  // avoid latch ?
        casez (ext_code)
            ZERO_EXT: begin
                out_32 = {16'b0000000000000000, immediate_16};
            end
            SIGN_EXT: begin
                out_32 = {{16{immediate_16[15]}}, immediate_16};
            end
            LUI_EXT: begin
                out_32 = immediate_16 << 16;
            end
        endcase
    end

endmodule : sign_extender
