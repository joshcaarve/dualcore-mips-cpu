/*
  Joshua Brard
  jbrard@purdue.edu

  icache_tb
*/

`include "include/cpu_types_pkg.vh"
`include "include/caches_types_pkg.vh"
`include "include/caches_if.vh"
`include "include/datapath_cache_if.vh"
`include "include/cpu_ram_if.vh"
`include "include/cache_control_if.vh"


// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module icache_tb;
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

    task check_to_mc;
        input string test_case;
        input integer test_case_num;

        input logic exp_iREN;
        input logic act_iREN;

        input word_t exp_iaddr;
        input word_t act_iaddr;

        begin
            tb_blip = 1'b1;
            assert (
                    exp_iREN == act_iREN &&
                    exp_iaddr == act_iaddr
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

        input logic exp_ihit;
        input logic act_ihit;

        input word_t exp_imemload;
        input word_t act_imemload;

        begin
            tb_blip = 1'b1;
            assert (
                    exp_ihit == act_ihit &&
                    exp_imemload == act_imemload
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

    // interfaces
    caches_if chif();

    datapath_cache_if dpif();

    cpu_ram_if rmif();

    cache_control_if #(.CPUS(1))  ccif (chif, chif);

    // test program
    test PROG (CLK, nRST, chif, dpif);

    memory_control MC (CLK, nRST, ccif);

    ram RAM (CLK, nRST, rmif);

    // DUT

	`ifndef MAPPED
    	icache DUT(CLK, nRST, chif, dpif);
	`else
		icache DIT (
			.\CLK		     (CLK),
			.\nRST			 (nRST),
			.\chif.iwait     (chif.iwait),
			.\chif.iload	 (chif.iload),
			.\chif.iREN		 (chif.iREN),
			.\chif.iaddr	 (chif.iaddr),

			.\dpif.imemREN   (dpif.imemREN),
			.\dpif.imemaddr	 (dpif.imemaddr),
			.\dpif.ihit		 (dpif.ihit),
			.\dpif.imemload	 (dpif.imemload)
		);
	`endif
		

    assign ccif.ramstate = rmif.ramstate;
    assign ccif.ramload = rmif.ramload;

    assign rmif.ramWEN = ccif.ramWEN;
    assign rmif.ramstore = ccif.ramstore;
    assign rmif.ramREN = ccif.ramREN;
    assign rmif.ramaddr = ccif.ramaddr;

endmodule : icache_tb

program test (
    input logic CLK,
    input logic nRST,
    caches_if.icache chif,
    datapath_cache_if.icache dpif
);

    parameter PERIOD = 10;
    import cpu_types_pkg::*;
    import caches_types_pkg::*;

    string tb_test_case;
    integer tb_test_num;

    initial begin
        tb_test_case = "INIT";
        tb_test_num = 0;
        dpif.imemREN = 1'b0;
        dpif.imemaddr = '0;

        reset_dut();

        /////////////////////////////////////////////////////////////////
        tb_test_num = tb_test_num + 1;
        tb_test_case = "First Compulsory MISS";
        dpif.imemREN = 1'b1;
        dpif.imemaddr = 32'h0000FF00;

        #(PERIOD);
        check_to_mc (
                tb_test_case, tb_test_num,
                1'b1, chif.iREN,
                32'hFF00, chif.iaddr
            );

        #(PERIOD);
        #(PERIOD);

        check_to_dp (
                tb_test_case, tb_test_num,
                1'b1, dpif.ihit,
                32'hDEAD, dpif.imemload
            );

        #(PERIOD);

        /////////////////////////////////////////////////////////////////
        dpif.imemREN = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "First HIT";
        dpif.imemREN = 1'b1;
        dpif.imemaddr = 32'h0000FF00;

        #(PERIOD);
        check_to_mc (
            tb_test_case, tb_test_num,
            1'b0, chif.iREN,
            '0, chif.iaddr
            );
        #(PERIOD);
        check_to_dp (
            tb_test_case, tb_test_num,
            1'b1, dpif.ihit,
            32'hDEAD, dpif.imemload
            );
        #(PERIOD);


        /////////////////////////////////////////////////////////////////
        dpif.imemREN = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Second Compulsory Miss";
        dpif.imemREN = 1'b1;
        dpif.imemaddr = 32'h0000FF04;

        #(PERIOD);
        check_to_mc (
            tb_test_case, tb_test_num,
            1'b1, chif.iREN,
            32'hFF04, chif.iaddr
            );

        #(PERIOD);
        #(PERIOD);

        check_to_dp (
            tb_test_case, tb_test_num,
            1'b1, dpif.ihit,
            32'hBEEF, dpif.imemload
            );


        /////////////////////////////////////////////////////////////////
        dpif.imemREN = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Second HIT";
        dpif.imemREN = 1'b1;
        dpif.imemaddr = 32'h0000FF04;

        #(PERIOD);
        check_to_mc (
            tb_test_case, tb_test_num,
            1'b0, chif.iREN,
            '0, chif.iaddr
            );
        #(PERIOD);
        check_to_dp (
            tb_test_case, tb_test_num,
            1'b1, dpif.ihit,
            32'hBEEF, dpif.imemload
            );

        #(PERIOD);

        /////////////////////////////////////////////////////////////////
        dpif.imemREN = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "First Conflict Miss";
        dpif.imemREN = 1'b1;
        dpif.imemaddr = 32'h00000F04;

        #(PERIOD);
        check_to_mc (
            tb_test_case, tb_test_num,
            1'b1, chif.iREN,
            32'h0F04, chif.iaddr
            );

        #(PERIOD);
        #(PERIOD);

        check_to_dp (
            tb_test_case, tb_test_num,
            1'b1, dpif.ihit,
            32'hABCD, dpif.imemload
            );


        #(PERIOD);

        /////////////////////////////////////////////////////////////////
        dpif.imemREN = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Miss but fill up 2";
        dpif.imemREN = 1'b1;
        dpif.imemaddr = 32'hFFFFFFF08;

        #(PERIOD);
        check_to_mc (
            tb_test_case, tb_test_num,
            1'b1, chif.iREN,
            32'hFFFFFFF08, chif.iaddr
            );

        #(PERIOD);
        #(PERIOD);

        check_to_dp (
            tb_test_case, tb_test_num,
            1'b1, dpif.ihit,
            32'hAAAA, dpif.imemload
            );

        #(PERIOD);

        /////////////////////////////////////////////////////////////////
        dpif.imemREN = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Miss but fill up 3";
        dpif.imemREN = 1'b1;
        dpif.imemaddr = 32'hFFFFFF0C;

        #(PERIOD);
        check_to_mc (
            tb_test_case, tb_test_num,
            1'b1, chif.iREN,
            32'hFFFFFF0C, chif.iaddr
            );

        #(PERIOD);
        #(PERIOD);

        check_to_dp (
            tb_test_case, tb_test_num,
            1'b1, dpif.ihit,
            32'h1111, dpif.imemload
            );

        #(PERIOD);

        /////////////////////////////////////////////////////////////////
        dpif.imemREN = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Miss but fill up 4";
        dpif.imemREN = 1'b1;
        dpif.imemaddr = 32'hFFFFFFF10;

        #(PERIOD);
        check_to_mc (
            tb_test_case, tb_test_num,
            1'b1, chif.iREN,
            32'hFFFFFFF10, chif.iaddr
            );

        #(PERIOD);
        #(PERIOD);

        check_to_dp (
            tb_test_case, tb_test_num,
            1'b1, dpif.ihit,
            32'h2222, dpif.imemload
            );


        #(PERIOD);


        /////////////////////////////////////////////////////////////////
        dpif.imemREN = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Miss but fill up 5";
        dpif.imemREN = 1'b1;
        dpif.imemaddr = 32'hFFFFFFF14;

        #(PERIOD);
        check_to_mc (
            tb_test_case, tb_test_num,
            1'b1, chif.iREN,
            32'hFFFFFFF14, chif.iaddr
            );

        #(PERIOD);
        #(PERIOD);

        check_to_dp (
            tb_test_case, tb_test_num,
            1'b1, dpif.ihit,
            32'h3333, dpif.imemload
            );


        #(PERIOD);

        /////////////////////////////////////////////////////////////////
        dpif.imemREN = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Miss but fill up 6";
        dpif.imemREN = 1'b1;
        dpif.imemaddr = 32'hFFFFFF18;

        #(PERIOD);
        check_to_mc (
            tb_test_case, tb_test_num,
            1'b1, chif.iREN,
            32'hFFFFFF18, chif.iaddr
            );

        #(PERIOD);
        #(PERIOD);

        check_to_dp (
            tb_test_case, tb_test_num,
            1'b1, dpif.ihit,
            32'h4444, dpif.imemload
            );

        #(PERIOD);

        /////////////////////////////////////////////////////////////////
        dpif.imemREN = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Miss but fill up 7";
        dpif.imemREN = 1'b1;
        dpif.imemaddr = 32'hFFFFFF1C;

        #(PERIOD);
        check_to_mc (
            tb_test_case, tb_test_num,
            1'b1, chif.iREN,
            32'hFFFFFF1C, chif.iaddr
            );

        #(PERIOD);
        #(PERIOD);

        check_to_dp (
            tb_test_case, tb_test_num,
            1'b1, dpif.ihit,
            32'h4445, dpif.imemload
            );

        #(PERIOD);


        /////////////////////////////////////////////////////////////////
        dpif.imemREN = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Miss but fill up 8";
        dpif.imemREN = 1'b1;
        dpif.imemaddr = 32'hFFFFFF20;

        #(PERIOD);
        check_to_mc (
            tb_test_case, tb_test_num,
            1'b1, chif.iREN,
            32'hFFFFFF20, chif.iaddr
            );

        #(PERIOD);
        #(PERIOD);

        check_to_dp (
            tb_test_case, tb_test_num,
            1'b1, dpif.ihit,
            32'h4446, dpif.imemload
            );

        #(PERIOD);


        /////////////////////////////////////////////////////////////////
        dpif.imemREN = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Miss but fill up 9";
        dpif.imemREN = 1'b1;
        dpif.imemaddr = 32'hFFFFFF24;

        #(PERIOD);
        check_to_mc (
            tb_test_case, tb_test_num,
            1'b1, chif.iREN,
            32'hFFFFFF24, chif.iaddr
            );

        #(PERIOD);
        #(PERIOD);

        check_to_dp (
            tb_test_case, tb_test_num,
            1'b1, dpif.ihit,
            32'h4447, dpif.imemload
            );

        #(PERIOD);

        /////////////////////////////////////////////////////////////////
        dpif.imemREN = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Miss but fill up 10";
        dpif.imemREN = 1'b1;
        dpif.imemaddr = 32'hFFFFFF28;

        #(PERIOD);
        check_to_mc (
            tb_test_case, tb_test_num,
            1'b1, chif.iREN,
            32'hFFFFFF28, chif.iaddr
            );

        #(PERIOD);
        #(PERIOD);

        check_to_dp (
            tb_test_case, tb_test_num,
            1'b1, dpif.ihit,
            32'h4448, dpif.imemload
            );

        #(PERIOD);


        /////////////////////////////////////////////////////////////////
        dpif.imemREN = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Miss but fill up 11";
        dpif.imemREN = 1'b1;
        dpif.imemaddr = 32'hFFFFFF2C;

        #(PERIOD);
        check_to_mc (
            tb_test_case, tb_test_num,
            1'b1, chif.iREN,
            32'hFFFFFF2C, chif.iaddr
            );

        #(PERIOD);
        #(PERIOD);

        check_to_dp (
            tb_test_case, tb_test_num,
            1'b1, dpif.ihit,
            32'h4449, dpif.imemload
            );

        #(PERIOD);

        /////////////////////////////////////////////////////////////////
        dpif.imemREN = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Miss but fill up 12";
        dpif.imemREN = 1'b1;
        dpif.imemaddr = 32'hFFFFFF30;

        #(PERIOD);
        check_to_mc (
            tb_test_case, tb_test_num,
            1'b1, chif.iREN,
            32'hFFFFFF30, chif.iaddr
            );

        #(PERIOD);
        #(PERIOD);

        check_to_dp (
            tb_test_case, tb_test_num,
            1'b1, dpif.ihit,
            32'h444A, dpif.imemload
            );

        #(PERIOD);


        /////////////////////////////////////////////////////////////////
        dpif.imemREN = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Miss but fill up 13";
        dpif.imemREN = 1'b1;
        dpif.imemaddr = 32'hFFFFFF34;

        #(PERIOD);
        check_to_mc (
            tb_test_case, tb_test_num,
            1'b1, chif.iREN,
            32'hFFFFFF34, chif.iaddr
            );

        #(PERIOD);
        #(PERIOD);

        check_to_dp (
            tb_test_case, tb_test_num,
            1'b1, dpif.ihit,
            32'h444B, dpif.imemload
            );

        #(PERIOD);


        /////////////////////////////////////////////////////////////////
        dpif.imemREN = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Miss but fill up 14";
        dpif.imemREN = 1'b1;
        dpif.imemaddr = 32'hFFFFFF38;

        #(PERIOD);
        check_to_mc (
            tb_test_case, tb_test_num,
            1'b1, chif.iREN,
            32'hFFFFFF38, chif.iaddr
            );

        #(PERIOD);
        #(PERIOD);

        check_to_dp (
            tb_test_case, tb_test_num,
            1'b1, dpif.ihit,
            32'h444C, dpif.imemload
            );

        #(PERIOD);


        /////////////////////////////////////////////////////////////////
        dpif.imemREN = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Miss but fill up 15";
        dpif.imemREN = 1'b1;
        dpif.imemaddr = 32'hFFFFFF3C;

        #(PERIOD);
        check_to_mc (
            tb_test_case, tb_test_num,
            1'b1, chif.iREN,
            32'hFFFFFF3C, chif.iaddr
            );

        #(PERIOD);
        #(PERIOD);

        check_to_dp (
            tb_test_case, tb_test_num,
            1'b1, dpif.ihit,
            32'h444D, dpif.imemload
            );

        #(PERIOD);


        /////////////////////////////////////////////////////////////////
        dpif.imemREN = 1'b0;
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Test Capacity misses ";
        dpif.imemREN = 1'b1;
        dpif.imemaddr = 32'h00000F3C;

        #(PERIOD);
        check_to_mc (
            tb_test_case, tb_test_num,
            1'b1, chif.iREN,
            32'h00000F3C, chif.iaddr
            );

        #(PERIOD);
        #(PERIOD);

        check_to_dp (
            tb_test_case, tb_test_num,
            1'b1, dpif.ihit,
            32'h0DAB, dpif.imemload
            );

        #(PERIOD);



        #(PERIOD);
        #(PERIOD);


        $finish;
    end





endprogram : test
