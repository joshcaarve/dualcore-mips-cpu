/*
    Joshua Brard
    jbrard@purdue.edu

    request_unit testbench
*/

`include "request_unit_if.vh"
`include "cpu_types_pkg.vh"

`timescale 1 ns / 1 ns

module request_unit_tb;

    import cpu_types_pkg::*;

    parameter PERIOD = 10;

    logic CLK = 0;
    logic nRST = 1'b1;
    // logic nRST;
    logic tb_blip = 1'b0;
    // clock
    always #(PERIOD/2) CLK++;

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

    task check_output;
        input string test_case;

        // expected
        input logic ex_dmemWEN;
        input logic ex_dmemREN;
        input logic ex_imemREN;

        // actual
        input logic act_dmemWEN;
        input logic act_dmemREN;
        input logic act_imemREN;

        begin
            tb_blip = 1'b1;
            assert(ex_dmemWEN == act_dmemWEN &&
                   ex_dmemREN == act_dmemREN &&
                   ex_imemREN == act_imemREN) begin
                $display("Correct output for in test case %s", test_case);
            end
            else begin
                $display("Incorrect output in test case %s", test_case);
            end
            #(0.2);
            tb_blip = 1'b0;
        end
    endtask : check_output

    request_unit_if rqif();

    test PROG (rqif);

    `ifndef MAPPED
        request_unit DUT (CLK, nRST, rqif);
    `else
        request_unit DUT (
            .\CLK               (CLK),
            .\nRST              (nRST),
            .\rqif.dhit         (rqif.dhit),
            .\rqif.ihit         (rqif.ihit),
            .\rqif.dWEN         (rqif.dWEN),
            .\rqif.dREN         (rqif.dREN),
            .\rqif.iREN         (rqif.iREN),

            .\rqif.dmemREN      (rqif.dmemREN),
            .\rqif.dmemWEN      (rqif.dmemWEN),
            .\rqif.imemREN      (rqif.imemREN),
        );
    `endif
endmodule : request_unit_tb

program test (
    request_unit_if.tb rqif
);
    parameter PERIOD = 10;
    import cpu_types_pkg::*;

    string tb_test_case;
    integer tb_test_num;
    initial
        begin
            tb_test_num = 0;
            tb_test_case = "INIT";
            rqif.dhit = '0;
            rqif.ihit = '0;
            rqif.dWEN = '0;
            rqif.dREN = '0;
            rqif.iREN = 1'b1;
            reset_dut();
            #(PERIOD);


            /*
                task check_output;
                input string test_case;

                // expected
                input logic ex_dmemWEN;
                input logic ex_dmemREN;
                input logic ex_imemREN;

                // actual
                input logic act_dmemWEN;
                input logic act_dmemREN;
                input logic act_imemREN;
            */

            // TEST CASE 1
            #(PERIOD);
            tb_test_num = tb_test_num + 1;
            tb_test_case = "After Reset";
            #(PERIOD);
            check_output (tb_test_case,
                         1'b0, 1'b0, 1'b1,
                         rqif.dmemWEN, rqif.dmemREN, rqif.imemREN);
            #(PERIOD);


            // TEST CASE 2
            tb_test_num = tb_test_num + 1;
            tb_test_case = "ihit set to 1";
            rqif.dhit = 1'b0;
            rqif.ihit = 1'b1;
            rqif.dWEN = 1'b1;
            rqif.dREN = 1'b1;
            rqif.iREN = 1'b1;
            #(PERIOD);

            check_output (tb_test_case,
                          1'b1, 1'b1, 1'b1,
                          rqif.dmemWEN, rqif.dmemREN, rqif.imemREN);
            #(PERIOD);


            // TEST CASE 3
            tb_test_num = tb_test_num + 1;
            tb_test_case = "dhit set to 1";
            rqif.dhit = 1'b1;
            rqif.ihit = 1'b0;
            rqif.dWEN = 1'b1;
            rqif.dREN = 1'b1;
            rqif.iREN = 1'b1;
            #(PERIOD);

            check_output (tb_test_case,
                1'b0, 1'b0, 1'b1,
                rqif.dmemWEN, rqif.dmemREN, rqif.imemREN);
            #(PERIOD);


            // TEST CASE 4
            tb_test_num = tb_test_num + 1;
            tb_test_case = "ihit set to 1 && dhit set to 0";
            rqif.dhit = 1'b1;
            rqif.ihit = 1'b1;
            rqif.dWEN = 1'b1;
            rqif.dREN = 1'b0;
            rqif.iREN = 1'b1;
            #(PERIOD);

            check_output (tb_test_case,
                1'b1, 1'b0, 1'b1,
                rqif.dmemWEN, rqif.dmemREN, rqif.imemREN);
            #(PERIOD);

            // TEST CASE 5
            tb_test_num = tb_test_num + 1;
            tb_test_case = "ihit set to 1 && dhit set to 0 (mem signals modified)";
            rqif.dhit = 1'b0;
            rqif.ihit = 1'b1;
            rqif.dWEN = 1'b1;
            rqif.dREN = 1'b0;
            rqif.iREN = 1'b0;
            #(PERIOD);

            check_output (tb_test_case,
                1'b1, 1'b0, 1'b0,
                rqif.dmemWEN, rqif.dmemREN, rqif.imemREN);
            #(PERIOD);

            // TEST CASE 6
            tb_test_num = tb_test_num + 1;
            tb_test_case = "ihit set to 0 && dhit set to 1 (mem signals modified)";
            rqif.dhit = 1'b1;
            rqif.ihit = 1'b0;
            rqif.dWEN = 1'b0;
            rqif.dREN = 1'b0;
            rqif.iREN = 1'b1;
            #(PERIOD);

            check_output (tb_test_case,
                1'b0, 1'b0, 1'b1,
                rqif.dmemWEN, rqif.dmemREN, rqif.imemREN);
            #(PERIOD);

            $finish;
        end


endprogram : test
