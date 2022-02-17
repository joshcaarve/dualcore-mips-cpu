/*
    Joshua Brard && Rohan Prabhu
    jbrard@purdue.edu
    prabhu4@purdue.edu


*/


`include "cpu_types_pkg.vh"
`include "fetch_decode_if.vh"

module fetch_decode (
    input logic CLK, nRST,
    fetch_decode_if.fd fdif
);
    import cpu_types_pkg::*;
    always_ff @ (posedge CLK, negedge nRST) begin
        if (nRST == 1'b0) begin
            // FLUSH
            fdif.instruction_out     <= '0;
            fdif.normal_pc_out       <= '0;
            fdif.next_pc_out         <= '0;
        end
        else if (fdif.flush == 1'b1) begin
            fdif.instruction_out     <= '0;
            fdif.normal_pc_out       <= '0;
            fdif.next_pc_out         <= '0;
        end
        else if (fdif.update == 1'b1) begin
            // move
            fdif.instruction_out <= fdif.instruction_in;
            fdif.normal_pc_out <= fdif.normal_pc_in;
            fdif.next_pc_out <= fdif.next_pc_in;
        end
        else begin
            // latch
            fdif.instruction_out <= fdif.instruction_out;
            fdif.normal_pc_out <= fdif.normal_pc_out;
            fdif.next_pc_out <= fdif.next_pc_out;
        end
    end

endmodule : fetch_decode