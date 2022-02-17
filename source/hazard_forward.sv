/*
    Joshua Brard && Rohan Prabhu
    jbrard@purdue.edu Prabhu4@purdue.edu

    This interface/module will listen to the outputs of the
    hazard unit and forwarding unit to determine flush and enable
*/


`include "cpu_types_pkg.vh"
`include "my_types_pkg.vh"
`include "hazard_unit_if.vh"

module hazard_forward (
    hazard_forward_if.hf hfif
);
    import cpu_types_pkg::*;
    import my_types_pkg::*;

    always_comb begin
        // default case

        hfif.fetch_decode_flush = hfif.hu_fetch_decode_flush;
        hfif.fetch_decode_enable = hfif.hu_fetch_decode_enable;

        hfif.decode_execute_flush = hfif.hu_decode_execute_flush;
        hfif.decode_execute_enable = hfif.hu_decode_execute_enable;

        hfif.execute_memory_flush = hfif.hu_execute_memory_flush;
        hfif.execute_memory_enable = hfif.hu_execute_memory_enable;

        hfif.memory_write_back_flush = hfif.hu_memory_write_back_flush;
        hfif.memory_write_back_enable = hfif.hu_memory_write_back_enable;

        if (hfif.ihit == 1'b1 || hfif.dhit == 1'b1) begin
            // hu_is_mem is in the execute stage
            if (hfif.hu_is_mem == 1'b0 &&
                (hfif.hu_decode_execute_conflict || hfif.hu_decode_memory_conflict)) begin

                if (!hfif.ex_mem_to_reg && !hfif.ex_mem_wr) begin
                    // forwarding unit can fix

                    hfif.fetch_decode_flush = 1'b0;
                    hfif.fetch_decode_enable = 1'b1;

                    hfif.decode_execute_flush = 1'b0;
                    hfif.decode_execute_enable = 1'b1;

                    hfif.execute_memory_flush = 1'b0;
                    hfif.execute_memory_enable = 1'b1;

                    hfif.memory_write_back_flush = 1'b0;
                    hfif.memory_write_back_enable = 1'b1;
                end
            end
        end

    end


endmodule : hazard_forward