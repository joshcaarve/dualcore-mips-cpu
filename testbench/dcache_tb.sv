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


    // interfaces
    caches_if cif0 ();
    caches_if cif1 ();

    cache_control_if #(
        .CPUS(2)
    ) ccif (
        cif0, cif1
    );

    datapath_cache_if dif0 ();
    datapath_cache_if dif1 ();

    cpu_ram_if rmif ();

    memory_control_top MC (
        CLK,
        nRST,
        ccif
    );

    ram RAM (
        CLK,
        nRST,
        rmif
    );
`ifndef MAPPED
    // DUT
    dcache DUT0 (
        CLK,
        nRST,
        cif0,
        dif0
    );

    // DUT
    dcache DUT1 (
        CLK,
        nRST,
        cif1,
        dif1
    );
`else
    dcache DUT0 (
        CLK,
        nRST,
        cif0.dwait,
        cif0.dload,
        cif0.ccwait,
        cif0.ccinv,
        cif0.ccsnoopaddr,
        cif0.dREN,
        cif0.dWEN,
        cif0.daddr,
        cif0.dstore,
        cif0.ccwrite,
        cif0.cctrans,

        dif0.halt,
        dif0.dmemREN,
        dif0.dmemWEN,
        dif0.datomic,
        dif0.dmemstore,
        dif0.dmemaddr,
        dif0.dhit,
        dif0.dmemload,
        dif0.flushed
    );
    dcache DUT1 (
        CLK,
        nRST,
        cif1.dwait,
        cif1.dload,
        cif1.ccwait,
        cif1.ccinv,
        cif1.ccsnoopaddr,
        cif1.dREN,
        cif1.dWEN,
        cif1.daddr,
        cif1.dstore,
        cif1.ccwrite,
        cif1.cctrans,

        dif1.halt,
        dif1.dmemREN,
        dif1.dmemWEN,
        dif1.datomic,
        dif1.dmemstore,
        dif1.dmemaddr,
        dif1.dhit,
        dif1.dmemload,
        dif1.flushed
    );
`endif
    // test program
    test PROG (
        CLK,
        nRST,
        cif0,
        cif1,
        dif0,
        dif1
    );

    assign ccif.ramstate = rmif.ramstate;
    assign ccif.ramload = rmif.ramload;

    assign rmif.ramWEN = ccif.ramWEN;
    assign rmif.ramstore = ccif.ramstore;
    assign rmif.ramREN = ccif.ramREN;
    assign rmif.ramaddr = ccif.ramaddr;

    // Reset Tasks
    task reset_dut;
        begin
            nRST = 1'b0;
            @(posedge CLK);
            @(posedge CLK);

            @(negedge CLK);
            nRST = 1'b1;

            @(posedge CLK);
            @(posedge CLK);
        end
    endtask : reset_dut

    task reset_values;
        dif0.halt       = '0;
        dif0.datomic     = '0;
        dif0.dmemREN    = '0;
        dif0.dmemWEN    = '0;
        dif0.dmemstore  = '0;
        dif0.dmemaddr   = '0;

        dif1.halt       = '0;
        dif1.datomic     = '0;
        dif1.dmemREN    = '0;
        dif1.dmemWEN    = '0;
        dif1.dmemstore  = '0;
        dif1.dmemaddr   = '0;
    endtask : reset_values

    task finished;
        begin
            nRST = 1'b0;
            @(posedge CLK);
            @(posedge CLK);
        end
    endtask : finished

    // Check Output Tasks
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


program test (
    input logic CLK,
    input logic nRST,
    caches_if.dcache cif0,
    caches_if.dcache cif1,
    datapath_cache_if.dcache dif0,
    datapath_cache_if.dcache dif1
);

    parameter PERIOD = 10;
    import cpu_types_pkg::*;
    import caches_types_pkg::*;

    string tb_test_case;
    integer tb_test_num;

    initial begin
        tb_test_case = "INIT";
        tb_test_num = 0;
        reset_values();
        reset_dut();

        tb_test_case = "TEST CASE 1";
        tb_test_num++;

        dif0.dmemWEN = 1'b0;
        dif0.dmemREN = 1'b0;
        dif0.dmemstore = 32'd0;
        dif0.dmemaddr = 1'b0;
        dif0.halt = 1'b0;

        dif1.dmemWEN = 1'b0;
        dif1.dmemREN = 1'b1;
        dif1.dmemstore = 32'd0;
        dif1.dmemaddr = 32'h0000AF00;
        dif1.halt = 1'b0;

        @(posedge CLK);
        @(posedge CLK);

        check_to_mc (
                tb_test_case,
                tb_test_num,
                1'b1, cif1.dREN,
                1'b0, cif1.dWEN,
                32'h0000AF00, cif1.daddr,
                '0, cif1.dstore
            );

        while(!dif1.dhit) begin
            @(posedge CLK);
        end
        check_to_dp (
            tb_test_case,
            tb_test_num,
            1'b1, dif1.dhit,
            32'ha0a0, dif1.dmemload
            );
        @(posedge CLK);


        dif1.dmemWEN = 1'b0;
        dif1.dmemREN = 1'b0;
        dif1.dmemstore = 32'd0;
        dif1.dmemaddr = 32'h0000AF00;
        dif1.halt = 1'b0;

        @(posedge CLK);
        @(posedge CLK);

        tb_test_case = "READ FROM OTHER CACHE";
        tb_test_num++;

        dif0.dmemWEN = 1'b0;
        dif0.dmemREN = 1'b1;
        dif0.dmemstore = 32'd0;
        dif0.dmemaddr = 32'h0000AF00;
        dif0.halt = 1'b0;

        dif1.dmemWEN = 1'b0;
        dif1.dmemREN = 1'b0;
        dif1.dmemstore = 32'd0;
        dif1.dmemaddr = 32'd0;
        dif1.halt = 1'b0;

        while(!dif0.dhit) begin
            @(posedge CLK);
        end

        dif0.dmemWEN = 1'b0;
        dif0.dmemREN = 1'b0;
        dif0.dmemstore = 32'd0;
        dif0.dmemaddr = 32'h0000AF00;
        dif0.halt = 1'b0;

        @(posedge CLK);
        @(posedge CLK);

        tb_test_case = "WRITE FROM CACHE 0";
        tb_test_num++;

        dif0.dmemWEN = 1'b1;
        dif0.dmemREN = 1'b0;
        dif0.dmemstore = 32'h0000FF00;
        dif0.dmemaddr = 32'h0000AF00;
        dif0.halt = 1'b0;

        dif1.dmemWEN = 1'b0;
        dif1.dmemREN = 1'b0;
        dif1.dmemstore = 32'd0;
        dif1.dmemaddr = 32'd0;
        dif1.halt = 1'b0;

        while(!dif0.dhit) begin
            @(posedge CLK);
        end

        @(posedge CLK);

        dif0.dmemWEN = 1'b0;
        dif0.dmemREN = 1'b0;
        dif0.dmemstore = 1'b0;
        dif0.dmemaddr = 32'h0000AF00;
        dif0.halt = 1'b0;

        @(posedge CLK);
        @(posedge CLK);


        tb_test_case = "WRITE FROM CACHE 1 when 0 is modified";
        tb_test_num++;

        dif1.dmemWEN = 1'b1;
        dif1.dmemREN = 1'b0;
        dif1.dmemstore = 32'hBA5EBA11;
        dif1.dmemaddr = 32'h0000AF00;
        dif1.halt = 1'b0;

        dif0.dmemWEN = 1'b0;
        dif0.dmemREN = 1'b0;
        dif0.dmemstore = 32'd0;
        dif0.dmemaddr = 32'd0;
        dif0.halt = 1'b0;

        while(!dif1.dhit) begin
            @(posedge CLK);
        end

        @(posedge CLK);

        dif1.dmemWEN = 1'b0;
        dif1.dmemREN = 1'b0;
        dif1.dmemstore = 1'b0;
        dif1.dmemaddr = 32'h0000AF00;
        dif1.halt = 1'b0;

        @(posedge CLK);
        @(posedge CLK);


        tb_test_case = "WRITE FROM CACHE 0 ... again";
        tb_test_num++;

        dif0.dmemWEN = 1'b1;
        dif0.dmemREN = 1'b0;
        dif0.dmemstore = 32'h0000C01D;
        dif0.dmemaddr = 32'h0000AF00;
        dif0.halt = 1'b0;

        dif1.dmemWEN = 1'b0;
        dif1.dmemREN = 1'b0;
        dif1.dmemstore = 32'd0;
        dif1.dmemaddr = 32'd0;
        dif1.halt = 1'b0;

        while(!dif0.dhit) begin
            @(posedge CLK);
        end

        @(posedge CLK);

        dif0.dmemWEN = 1'b0;
        dif0.dmemREN = 1'b0;
        dif0.dmemstore = 1'b0;
        dif0.dmemaddr = 32'h0000AF00;
        dif0.halt = 1'b0;

        @(posedge CLK);
        @(posedge CLK);

        dif0.halt = 1'b1;
        dif1.halt = 1'b1;

        @(posedge CLK);

        while(!dif0.flushed || !dif1.flushed) begin
            @(posedge CLK);
        end

        @(posedge CLK);


        $display("Program Finished .... reseting DUTs now");
        tb_test_case = "FINISHED";
        tb_test_num = -1;
        finished();  // sets nRST
        $finish;
    end

endprogram : test
endmodule : dcache_tb
