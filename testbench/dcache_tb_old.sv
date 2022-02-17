/*
  Joshua Brard
  jbrard@purdue.edu

  dcache_tb
*/

`include "include/cpu_types_pkg.vh"
`include "include/caches_types_pkg.vh"
`include "include/caches_if.vh"
`include "include/datapath_cache_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module dcache_tb;
    import cpu_types_pkg::*;
    import caches_types_pkg::*;

    parameter PERIOD = 10;

    logic CLK = 1'b0;
    logic nRST = 1'b0;


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
   

        begin
            tb_blip = 1'b1;

			#(0.1)
			tb_blip = 1'b0;
        end
    endtask : check_output
    // interfaces
    caches_if ccdf();
    datapath_cache_if dpif();

    cpu_ram_if rmif();
    cache_control_if #(.CPUS(1)) ccif(ccdf, ccdf);

    // test program
    test PROG (CLK, nRST, ccdf, dpif);

    memory_control MC (CLK, nRST, ccif);

    ram RAM (CLK, nRST, rmif);

    // DUT
    dcache DUT(CLK, nRST, ccdf, dpif);


    assign ccif.ramstate = rmif.ramstate;
    assign ccif.ramload = rmif.ramload;

    assign rmif.ramWEN = ccif.ramWEN;
    assign rmif.ramstore = ccif.ramstore;
    assign rmif.ramREN = ccif.ramREN;
    assign rmif.ramaddr = ccif.ramaddr;




    task check_to_mc;
        input string test_case;
        input integer test_case_num;

        input logic exp_dREN;
        input logic act_dREN;

        input logic exp_dWEN;
        input logic act_dWEN;

        input word_t exp_daddr;
        input word_t act_daddr;

        input word_t exp_dstore;
        input word_t act_dstore;

        begin
            tb_blip = 1'b1;
            assert (
                    exp_dREN == act_dREN &&
                    exp_dWEN == act_dWEN &&
                    exp_daddr == act_daddr &&
                    exp_dstore == act_dstore
                ) begin
                $display("TO MC: Correct output for in test case %s # %d", test_case, test_case_num);
            end
            else begin
                $display("TO MC: Incorrect output in test case %s # %d", test_case, test_case_num);
            end
            #(0.1)
            tb_blip = 1'b0;
        end
    endtask : check_to_mc

    task check_to_dp;
        input string test_case;
        input integer test_case_num;

        input logic exp_dhit;
        input logic act_dhit;

        input word_t exp_dmemload;
        input word_t act_dmemload;

        begin
            tb_blip = 1'b1;
            assert (
                exp_dhit == act_dhit &&
                    exp_dmemload == act_dmemload
                ) begin
                $display("TO DP: Correct output for in test case %s # %d", test_case, test_case_num);
            end
            else begin
                $display("TO DP: Incorrect output in test case %s # %d", test_case, test_case_num);
            end
            #(0.1)
            tb_blip = 1'b0;
        end
    endtask : check_to_dp





endmodule : dcache_tb

program test (
    input logic CLK,
    input logic nRST,
    caches_if.dcache ccdf,
    datapath_cache_if.dcache dpif
);

    parameter PERIOD = 10;
    import cpu_types_pkg::*;
    import caches_types_pkg::*;

    string tb_test_case;
    integer tb_test_num;


    initial begin
        tb_test_case = "INIT";
        tb_test_num = 0;
        #(PERIOD);
        reset_dut();

        /////////////////////////////////////////////////////////////////
        dpif.dmemREN = 1'b0;
        dpif.dmemWEN = 1'b0;
        dpif.halt = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "First Compulsory MISS";

        dpif.dmemREN = 1'b1;
        dpif.dmemWEN = 1'b0;
        dpif.dmemstore = '0;
        dpif.dmemaddr = 32'h0000FF00;


        #(PERIOD);
        check_to_mc (
                tb_test_case, tb_test_num,
                1'b1, ccdf.dREN,
                1'b0, ccdf.dWEN,
                32'h0000FF00, ccdf.daddr,
                '0, ccdf.dstore
            );

        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);

        check_to_dp (
                tb_test_case, tb_test_num,
                1'b1, dpif.dhit,
                32'hDEAD, dpif.dmemload
            );

        #(PERIOD);

        /////////////////////////////////////////////////////////////////
        dpif.dmemREN = 1'b0;
        dpif.dmemWEN = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Get a Hit 1 with offset (proves Associativity)";

        dpif.dmemREN = 1'b1;
        dpif.dmemWEN = 1'b0;
        dpif.dmemstore = '0;
        dpif.dmemaddr = 32'h0000FF04;

        #(PERIOD);
        check_to_mc (
            tb_test_case, tb_test_num,
            1'b0, ccdf.dREN,
            1'b0, ccdf.dWEN,
            '0, ccdf.daddr,
            '0, ccdf.dstore
            );

        #(PERIOD);
        check_to_dp (
            tb_test_case, tb_test_num,
            1'b1, dpif.dhit,
            32'hBEEF, dpif.dmemload
            );


        #(PERIOD);

        /////////////////////////////////////////////////////////////////
        dpif.dmemREN = 1'b0;
        dpif.dmemWEN = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Miss because different Address";

        dpif.dmemREN = 1'b1;
        dpif.dmemWEN = 1'b0;
        dpif.dmemstore = '0;
        dpif.dmemaddr = 32'h0000AF04;

        #(PERIOD);

        check_to_mc (
            tb_test_case, tb_test_num,
            1'b1, ccdf.dREN,
            1'b0, ccdf.dWEN,
            32'h0000AF00, ccdf.daddr,
            '0, ccdf.dstore
            );

        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);

        check_to_dp (
            tb_test_case, tb_test_num,
            1'b1, dpif.dhit,
            32'hAAA0, dpif.dmemload
            );


        #(PERIOD);

        while(!dpif.dhit) begin
            #(PERIOD);
        end

        /////////////////////////////////////////////////////////////////
        dpif.dmemREN = 1'b0;
        dpif.dmemWEN = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Hits based on Asssociativity";

        dpif.dmemREN = 1'b1;
        dpif.dmemWEN = 1'b0;
        dpif.dmemstore = '0;
        dpif.dmemaddr = 32'h0000AF00;

        #(PERIOD);

        check_to_mc (
            tb_test_case, tb_test_num,
            1'b0, ccdf.dREN,
            1'b0, ccdf.dWEN,
            '0, ccdf.daddr,
            '0, ccdf.dstore
            );

        #(PERIOD);
        #(PERIOD);

        check_to_dp (
            tb_test_case, tb_test_num,
            1'b1, dpif.dhit,
            32'hA0A0, dpif.dmemload
            );


        #(PERIOD);


        while(!dpif.dhit) begin
            #(PERIOD);
        end

        /////////////////////////////////////////////////////////////////
        dpif.dmemREN = 1'b0;
        dpif.dmemWEN = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Conflict Miss 1 ";

        dpif.dmemREN = 1'b1;
        dpif.dmemWEN = 1'b0;
        dpif.dmemstore = '0;
        dpif.dmemaddr = 32'h0000BF00;

        #(PERIOD);

        check_to_mc (
            tb_test_case, tb_test_num,
            1'b1, ccdf.dREN,
            1'b0, ccdf.dWEN,
            32'h0000BF00, ccdf.daddr,
            '0, ccdf.dstore
            );

        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);

        check_to_dp (
            tb_test_case, tb_test_num,
            1'b1, dpif.dhit,
            32'hB0B0, dpif.dmemload
            );


        #(PERIOD);

        while(!dpif.dhit) begin
            #(PERIOD);
        end


        /////////////////////////////////////////////////////////////////
        dpif.dmemREN = 1'b0;
        dpif.dmemWEN = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Write to Address 0x0000AF00 (DB)";

        dpif.dmemREN = 1'b0;
        dpif.dmemWEN = 1'b1;
        dpif.dmemstore = 32'hFFFFFFF0;
        dpif.dmemaddr = 32'h0000AF00;

        #(PERIOD);

        check_to_mc (
            tb_test_case, tb_test_num,
            1'b0, ccdf.dREN,
            1'b0, ccdf.dWEN,
            '0, ccdf.daddr,
            '0, ccdf.dstore
            );

        #(PERIOD);
        #(PERIOD);

        check_to_dp (
            tb_test_case, tb_test_num,
            1'b1, dpif.dhit,
            '0, dpif.dmemload
            );


        #(PERIOD);

        while(!dpif.dhit) begin
            #(PERIOD);
        end


        /////////////////////////////////////////////////////////////////
        dpif.dmemREN = 1'b0;
        dpif.dmemWEN = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Read Address 0x0000AF00 (DB)";

        dpif.dmemREN = 1'b1;
        dpif.dmemWEN = 1'b0;
        dpif.dmemstore = '0;
        dpif.dmemaddr = 32'h0000AF00;

        #(PERIOD);

        check_to_mc (
            tb_test_case, tb_test_num,
            1'b0, ccdf.dREN,
            1'b0, ccdf.dWEN,
            '0, ccdf.daddr,
            '0, ccdf.dstore
            );

        #(PERIOD);
        #(PERIOD);

        check_to_dp (
            tb_test_case, tb_test_num,
            1'b1, dpif.dhit,
            32'hFFFFFFF0, dpif.dmemload
            );


        #(PERIOD);

        /////////////////////////////////////////////////////////////////
        dpif.dmemREN = 1'b0;
        dpif.dmemWEN = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Read LRU (hit)";

        dpif.dmemREN = 1'b1;
        dpif.dmemWEN = 1'b0;
        dpif.dmemstore = '0;
        dpif.dmemaddr = 32'h0000BF00;

        #(PERIOD);

        check_to_mc (
            tb_test_case, tb_test_num,
            1'b0, ccdf.dREN,
            1'b0, ccdf.dWEN,
            '0, ccdf.daddr,
            '0, ccdf.dstore
            );

        #(PERIOD);
        #(PERIOD);


        check_to_dp (
            tb_test_case, tb_test_num,
            1'b1, dpif.dhit,
            32'hB0B0, dpif.dmemload
            );


        #(PERIOD);

        while(!dpif.dhit) begin
            #(PERIOD);
        end

        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);


        /////////////////////////////////////////////////////////////////
        dpif.dmemREN = 1'b0;
        dpif.dmemWEN = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Write to Address 0x0000CF00 (DB)";

        dpif.dmemREN = 1'b0;
        dpif.dmemWEN = 1'b1;
        dpif.dmemstore = 32'hFFFFFF00;
        dpif.dmemaddr = 32'h0000CF00;

        #(PERIOD);

        check_to_mc (
            tb_test_case, tb_test_num,
            1'b0, ccdf.dREN,
            1'b1, ccdf.dWEN,
            32'h0000CF00, ccdf.daddr,
            32'h0000B0B0, ccdf.dstore
            );

        while(!dpif.dhit) begin
            #(PERIOD);
        end

        check_to_dp (
            tb_test_case, tb_test_num,
            1'b1, dpif.dhit,
            '0, dpif.dmemload
            );


        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        while(!dpif.dhit) begin
            #(PERIOD);
        end



        /////////////////////////////////////////////////////////////////
        dpif.dmemREN = 1'b0;
        dpif.dmemWEN = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "HALT!";

        dpif.halt = 1'b1;
        dpif.dmemREN = 1'b0;
        dpif.dmemWEN = 1'b0;
        dpif.dmemstore = 32'hFFFFFF00;
        dpif.dmemaddr = 32'h0000CF00;

        #(PERIOD * 5);

        check_to_mc (
            tb_test_case, tb_test_num,
            1'b0, ccdf.dREN,
            1'b1, ccdf.dWEN,
            32'h0000CF00, ccdf.daddr,
            32'hFFFFFF00, ccdf.dstore
            );

//        while(!dpif.dhit) begin
//            #(PERIOD);
//        end
        #(PERIOD * 5);

        check_to_dp (
            tb_test_case, tb_test_num,
            1'b0, dpif.dhit,
            '0, dpif.dmemload
            );


        #(PERIOD * 50);

        reset_dut();  //


        $finish;
    end








endprogram : test
