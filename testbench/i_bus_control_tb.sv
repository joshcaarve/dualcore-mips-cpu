`timescale 1 ns / 1 ns
`include "include/cpu_types_pkg.vh"
`include "include/i_bus_control_if.vh"

module i_bus_control_tb;
    import cpu_types_pkg::*;
    parameter PERIOD = 10;

    logic CLK = 0;
    logic nRST = 1'b1;

    logic tb_blip = 1'b0;
    // clock
    always #(PERIOD/2) CLK++;

    i_bus_control_if ibif();

    i_bus_control DUT (
        CLK,
        nRST,
        ibif
    );

    test PROG (
        CLK,
        nRST,
        ibif
    );


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

endmodule : i_bus_control_tb

program test (
    input logic CLK,
    input logic nRST,
    i_bus_control_if.tb ibif
);
    import cpu_types_pkg::*;
    parameter PERIOD = 10;
    string tb_test_case;
    integer tb_test_num;


    initial begin

        tb_test_case = "INIT";
        tb_test_num = 0;

        ibif.iREN = '0;
        ibif.iaddr = '0;
        ibif.iwait = '0;
        reset_dut();

        ibif.iREN = 2'b10;
        ibif.iaddr[1] = 32'hFFFFFFFF;
        ibif.iwait = '0;


        @(posedge CLK);
        @(posedge CLK);
        @(posedge CLK);
        @(posedge CLK);
        @(posedge CLK);
        @(posedge CLK);
        @(posedge CLK);
        @(posedge CLK);
        @(posedge CLK);
        @(posedge CLK);
        @(posedge CLK);
        @(posedge CLK);

        $finish;
    end




    endprogram : test