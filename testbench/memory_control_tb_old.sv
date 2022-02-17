/*
	Joshua Brard
	jbrard@purdue.edu
*/

`include "include/cpu_types_pkg.vh"
`include "include/cache_control_if.vh"
`include "include/caches_if.vh"
`include "include/system_if.vh"
`include "include/cpu_ram_if.vh"
`include "include/datapath_cache_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns


module memory_control_tb;

    import cpu_types_pkg::*;

    parameter PERIOD = 10;

    logic CLK = 0, nRST = 1;

    logic tb_blip = 1'b0; // for check_output task

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
        input word_t expData;
        input word_t actData;
        begin
            tb_blip = 1'b1;
            assert (expData == actData) begin
                $display("Correct output in test case %s", test_case);
            end
            else begin
                $display("Incorrect output in test case %s", test_case);
            end
            #(0.2);
            tb_blip = 1'b0;
        end
    endtask : check_output

    // Instantiate cpu ram interface
    cpu_ram_if cpuif ();

    ram RAM (CLK, nRST, cpuif);

    // Instantiate caches
    caches_if cif0 ();
    caches_if cif1 ();

    // Instantiate cache control interface
    cache_control_if    #(.CPUS(2))       ccif (cif0, cif1);

    // Inputs to ram
    assign cpuif.ramaddr = ccif.ramaddr;
    assign cpuif.ramstore = ccif.ramstore;
    assign cpuif.ramREN = ccif.ramREN;
    assign cpuif.ramWEN = ccif.ramWEN;

    // Outputs out of ram
    assign ccif.ramstate = cpuif.ramstate;
    assign ccif.ramload = cpuif.ramload;

    //memory_control DUT (CLK, nRST, ccif);

    test PROG (CLK, nRST, ccif);


`ifndef MAPPED
    memory_control DUT (CLK, nRST, ccif);
`else
    memory_control DUT (
    .\ccif.iREN (ccif.iREN),
    .\ccif.dREN (ccif.dREN),
    .\ccif.dWEN (ccif.dWEN),
    .\ccif.dstore (ccif.dstore),
    .\ccif.iaddr (ccif.iaddr),
    .\ccif.daddr (ccif.daddr),

    .\ccif.ramload (ccif.ramload),
    .\ccif.ramstate (ccif.ramstate),

    .\ccif.ccwrite (ccif.ccwrite),
    .\ccif.cctrans (ccif.cctrans),

    .\ccif.iwait (ccif.iwait),
    .\ccif.dwait (ccif.dwait),
    .\ccif.iload (ccif.iload),
    .\ccif.dload (ccif.dload),

    .\ccif.ramstore (ccif.ramstore),
    .\ccif.ramaddr (ccif.ramaddr),
    .\ccif.ramWEN (ccif.ramWEN),
    .\ccif.ramREN (ccif.ramREN),

    .\ccif.ccwait (ccif.ccwait),
    .\ccif.ccinv (ccif.ccinv),
    .\ccif.ccsnoopaddr (ccif.ccsnoopaddr),

    .\nRST (nRST),
    .\CLK (CLK)
    );
`endif


program test (
    input logic CLK,
    input logic nRST,
    cache_control_if ccif
);

    parameter PERIOD = 10;
    import cpu_types_pkg::*;

    string tb_test_case;
    integer tb_test_num;
    integer i;

    task automatic dump_memory();
        string filename = "memcpu.hex";
        int memfd;

        cif0.daddr = 0;
        cif0.dWEN = 0;
        cif0.dREN = 0;

        memfd = $fopen(filename,"w");
        if (memfd)
            $display("Starting memory dump.");
        else
            begin $display("Failed to open %s.",filename); $finish; end

        for (int unsigned i = 0; memfd && i < 16384; i++)
            begin
                int chksum = 0;
                bit [7:0][7:0] values;
                string ihex;

                cif0.daddr = i << 2;
                cif0.dREN = 1;
                repeat (4) @(posedge CLK);
                if (cif0.dload === 0)
                    continue;
                values = {8'h04,16'(i),8'h00,cif0.dload};
                foreach (values[j])
                    chksum += values[j];
                chksum = 16'h100 - chksum;
                ihex = $sformatf(":04%h00%h%h",16'(i),cif0.dload,8'(chksum));
                $fdisplay(memfd,"%s",ihex.toupper());
            end //for
        if (memfd)
            begin
                cif0.dREN = 0;
                $fdisplay(memfd,":00000001FF");
                $fclose(memfd);
                $display("Finished memory dump.");
            end
    endtask

    task reset_values;
        begin
            #(PERIOD);
            // instructions
            cif0.iREN = 1'b0;
            cif0.iaddr = '0;

            // data
            cif0.dREN = 1'b0;
            cif0.dWEN = 1'b0;
            cif0.dstore = 1'b0;
            cif0.daddr = '0;
            #(PERIOD);
        end
    endtask : reset_values

    task toggle_bits;
        begin
            // instructions
            cif0.iREN = 1'b1;
            cif0.iaddr = '1;

            // data
            cif0.dREN = 1'b1;
            cif0.dWEN = 1'b1;
            cif0.dstore = 1'b1;
            cif0.daddr = '1;
        end
    endtask : toggle_bits



    initial begin

        // NOTE: word_t = [31 : 0]

        // Test Case INIT
        tb_test_num  = 0;
        tb_test_case = "INIT";
        reset_values();
        reset_dut();
        #(PERIOD);


        $finish;
    end


endprogram : test
endmodule : memory_control_tb