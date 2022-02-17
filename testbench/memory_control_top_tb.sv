`include "include/cpu_types_pkg.vh"
`include "include/cache_control_if.vh"
`include "include/arbiter_if.vh"
`include "include/i_bus_control_if.vh"
`include "include/d_bus_control_if.vh"

module memory_control_top_tb;

    import cpu_types_pkg::*;
    parameter PERIOD = 10;

    logic CLK = 0;
    logic nRST = 1'b1;

    logic tb_blip = 1'b0;
    // clock
    always #(PERIOD/2) CLK++;

    //cpu_ram_if rmif();

    //ram RAM (CLK, nRST, rmif);

    caches_if cif0();
    caches_if cif1();

    cache_control_if #(
        .CPUS(2)
    ) ccif (
        cif0, cif1
    );

    memory_control_top DUT (CLK, nRST, ccif);

    test PROG (CLK, nRST, ccif);

    task reset_dut;
        begin
            nRST = 1'b0;
            @(posedge CLK);
            @(posedge CLK);

            @(negedge CLK);
            nRST = 1'b1;

            @(negedge CLK);
            @(negedge CLK);
        end
    endtask : reset_dut



endmodule : memory_control_top_tb

program test (
    input logic CLK,
    input logic nRST,
    cache_control_if.cc ccif
);
    import cpu_types_pkg::*;
    parameter PERIOD = 10;
    string tb_test_case;
    integer tb_test_num;

    initial begin
        tb_test_case = "INIT";
        tb_test_num = 0;

        // FIXME CIF0, CIF1

        @(posedge CLK);
        @(posedge CLK);
        @(posedge CLK);

        reset_dut();


        $finish;
    end

endprogram : test