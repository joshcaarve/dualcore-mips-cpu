/*
	Joshua Brard && Rohan Prabhu
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

    // Instantiate cpu ram interface
    cpu_ram_if cpuif();

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

    test PROG (CLK, nRST, ccif, cif0, cif1);


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

/*
{
        inside this program (test), I am acting as a cache
        acting as a cache is done by modifying the cache 0 values
        modifying the values will allow me to test my memory controler :D
}
*/
program test (
    input logic CLK,
    input logic nRST,
    cache_control_if ccif,
    caches_if cif0,
    caches_if cif1

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
            cif0.ccwrite = '0;
            cif0.cctrans = '0;

            // data
            cif0.dREN = 1'b0;
            cif0.dWEN = 1'b0;
            cif0.dstore = 1'b0;
            cif0.daddr = '0;

            cif1.iREN = 1'b0;
            cif1.iaddr = '0;

            // data
            cif1.dREN = 1'b0;
            cif1.dWEN = 1'b0;
            cif1.dstore = 1'b0;
            cif1.daddr = '0;
            cif1.ccwrite = '0;
            cif1.cctrans = '0;

            #(PERIOD);

        end
    endtask : reset_values
    /*
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

            cif1.iREN = 1'b1;
            cif1.iaddr = '1;

            // data
            cif1.dREN = 1'b1;
            cif1.dWEN = 1'b1;
            cif1.dstore = 1'b1;
            cif1.daddr = '1;

            ccif.iwait[0] = 1'b1;
            ccif.dwait[0] = 1'b1;
            ccif.iload[0] = '1;
            ccif.dload[0] = '1;
            ccif.ccwait[0] = '1;
            ccif.ccinv[0] = '1;
            ccif.ccsnoopaddr[0] = '1;

            ccif.ccwrite[0] = '1;
            ccif.cctrans[0] = '1;

            ccif.ccwrite[1] = '1;
            ccif.cctrans[1] = '1;

            ccif.iwait[1];
            ccif.dwait[1];
            ccif.iload[1] = '1;
            ccif.dload[1] = '1;
            ccif.ccwait[1] = '1;
            ccif.ccinv[1] = '1;
            ccif.ccsnoopaddr[1] = '1;


        end
    endtask : toggle_bits
    */

    task check_output;
        input string test_case;

        input logic cache;

        input logic expiwait;

        input logic expdwait;

        input word_t expiload;

        input word_t expdload;

        input word_t expramstore;

        input word_t expramaddr;

        input logic  expramWEN;

        input logic  expramREN;

        input logic expccwait;

        input logic expccinv;

        input word_t expccsnoopaddr;

        begin
            #(0.1);
            tb_blip = 1'b1;
            assert (

                expramREN == ccif.ramREN &&
                    expramWEN == ccif.ramWEN &&
                    expramaddr == ccif.ramaddr &&
                    expiload == ccif.iload[cache] &&
                    expdload == ccif.dload[cache] &&
                    expiwait == ccif.iwait[cache] &&
                    expdwait == ccif.dwait[cache] &&
                    expramstore == ccif.ramstore
                ) begin
                $display("Correct output in test case %s on cache %s", test_case, cache);
            end
            else begin
                $display("Incorrect output in test case %s", test_case);
            end
            #(0.2);
            tb_blip = 1'b0;
        end
    endtask : check_output

    initial begin

        // NOTE: word_t = [31 : 0]

        // Test Case INIT
        tb_test_num  = 0;
        tb_test_case = "INIT";
        reset_values();
        reset_dut();
        #(PERIOD * 2);


        // Test Case #1
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Write back 0xFFFFFFFF to address 0x00000000 from cache0";
        cif0.dWEN = 1'b1;
        cif0.dREN = 1'b0;

        cif1.dWEN = 1'b0;
        cif1.dREN = 1'b0;
        cif1.iREN = 1'b0;

        @(negedge CLK);
        @(negedge CLK);
        @(negedge CLK);

        cif0.daddr = 32'h00000000;
        cif0.dstore = 32'hFFFF0000;

        check_output(tb_test_case,
            0,  //cache display
            1,  //expiwait
            1,  //expdwait
            '0,  //expioad
            '0,  //expdload
            32'hFFFF0000,  //expramstore
            32'h00000000,  //expramaddr
            1,  //expramWEN
            '0,  //expramREN
            '0,  //expccwait
            '0,  //expccinv
            '0); //expcccnoopaddr

        @(negedge ccif.dwait[0]);
        @(posedge CLK);

        cif0.daddr = 32'h00000001;
        cif0.dstore = 32'h0000FFFF;

        check_output(tb_test_case,
            0,  //cache display
            1,  //expiwait
            1,  //expdwait
            '0,  //expioad
            '0,  //expdload
            32'h0000FFFF,  //expramstore
            32'h00000001,  //expramaddr
            1,  //expramWEN
            '0,  //expramREN
            '0,  //expccwait
            '0,  //expccinv
            '0); //expcccnoopaddr

        @(posedge ccif.dwait[0]);

        tb_test_num = tb_test_num + 1;
        tb_test_case = "Write back 0xFFFFFFFF to address 0x00000000 from cache1";
        cif0.dWEN = 1'b0;
        cif0.dREN = 1'b0;
        cif0.daddr = 32'h00000000;
        cif0.dstore = 32'hFFFFFFFF;

        cif1.dWEN = 1'b1;
        cif1.dREN = 1'b0;
        cif1.iREN = 1'b0;

        @(negedge CLK);
        @(negedge CLK);
        @(negedge CLK);

        cif0.daddr = 32'h00000000;
        cif0.dstore = 32'hFFFFFFFF;

        check_output(tb_test_case,
            1,  //cache display
            1,  //expiwait
            1,  //expdwait
            '0,  //expioad
            '0,  //expdload
            32'hFFFFFFFF,  //expramstore
            32'h00000000,  //expramaddr
            1,  //expramWEN
            '0,  //expramREN
            '0,  //expccwait
            '0,  //expccinv
            '0); //expcccnoopaddr


        @(negedge ccif.dwait[1]);
        @(posedge CLK);

        cif0.daddr = 32'h00000001;
        cif0.dstore = 32'hFFFFFFFF;

        check_output(tb_test_case,
            1,  //cache display
            1,  //expiwait
            1,  //expdwait
            '0,  //expioad
            '0,  //expdload
            32'hFFFFFFFF,  //expramstore
            32'h00000001,  //expramaddr
            1,  //expramWEN
            '0,  //expramREN
            '0,  //expccwait
            '0,  //expccinv
            '0); //expcccnoopaddr

        @(negedge ccif.dwait[1]);

        #(PERIOD);
        reset_values();
        #(PERIOD);

        // Test Case #1 con
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Read value 0xFFFFFFFF asked by cache0 from address 0x00000000 but from cache 1 (NOT MODIFIED)";
        cif0.dWEN = 1'b0;
        cif0.dREN = 1'b1;
        cif0.daddr = 32'h00000000;

        cif1.dWEN = 1'b0;
        cif1.dREN = 1'b0;
        cif1.daddr = 32'h00000000;

        @(posedge CLK);
        @(posedge CLK);

        cif1.cctrans = 1'b1;
        cif1.ccwrite = 1'b0;

        @(posedge CLK);

        cif1.dstore = 32'h0000FFFF;

        @(negedge ccif.dwait);

        cif1.dstore = 32'hFFFF0000;

        @(negedge ccif.dwait);


        #(PERIOD);
        reset_values();



        // Test Case #2
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Read value 0xFFFFFFFF asked by cache1 from address 0x0000FFFF but from cache 0 (NOT MODIFIED)";
        cif0.dWEN = 1'b0;
        cif0.dREN = 1'b0;
        cif0.daddr = 32'h00000000;

        cif1.dWEN = 1'b0;
        cif1.dREN = 1'b1;
        cif1.daddr = 32'h00000000;

        @(posedge CLK);
        @(posedge CLK);

        cif0.cctrans = 1'b1;
        cif0.ccwrite = 1'b0;

        @(posedge CLK);

        cif0.cctrans = 1'b1;
        cif0.ccwrite = 1'b0;
//        cif1.dload = 32'h0000FFFF;

        @(negedge ccif.dwait);

        cif0.cctrans = 1'b1;
        cif0.ccwrite = 1'b0;
//        cif1.dload = 32'hFFFF0000;

        @(negedge ccif.dwait);

//        #(PERIOD);
        @(posedge CLK);
        reset_values();



        tb_test_num = tb_test_num + 1;
        tb_test_case = "Read value 0xFFFFFFFF asked by cache0 from address 0x0000FFFF but from cache 1 (MODIFIED)";
        cif0.dWEN = 1'b0;
        cif0.dREN = 1'b1;
        cif0.daddr = 32'h00000000;

        @(posedge CLK);
        @(posedge CLK);

        cif1.dWEN = 1'b0;
        cif1.dREN = 1'b0;
        cif1.daddr = 32'h00000000;

        cif1.cctrans = 1'b1;
        cif1.ccwrite = 1'b1;

        @(posedge CLK);

        cif1.cctrans = 1'b1;
        cif1.ccwrite = 1'b1;
//        cif0.dload = 32'h0000FFFF;

        @(negedge ccif.dwait);

        cif1.cctrans = 1'b1;
        cif1.ccwrite = 1'b1;
//        cif0.dload = 32'hFFFF0000;

        @(negedge ccif.dwait);

//        #(PERIOD);
        @(posedge CLK);
        reset_values();


        tb_test_num = tb_test_num + 1;
        tb_test_case = "Read value 0xFFFFFFFF asked by cache1 from address 0x0000FFFF but from cache 0 (MODIFIED)";
        cif0.dWEN = 1'b0;
        cif0.dREN = 1'b0;
        cif0.daddr = 32'h00000000;

        @(posedge CLK);

        cif1.dWEN = 1'b0;
        cif1.dREN = 1'b1;
        cif1.daddr = 32'h00000000;

        cif0.cctrans = 1'b1;
        cif0.ccwrite = 1'b1;

        @(posedge CLK);

        cif0.cctrans = 1'b1;
        cif0.ccwrite = 1'b1;
//        cif1.dload = 32'h0000FFFF;

        @(negedge ccif.dwait);

        cif0.cctrans = 1'b1;
        cif0.ccwrite = 1'b1;
//        cif1.dload = 32'hFFFF0000;

        @(negedge ccif.dwait);

        #(PERIOD);
        @(posedge CLK);
        reset_values();


        // Test Case #2 con
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Read value 0xFFFFFFFF from address 0x00030034";
        cif0.iREN = 1'b1;
        cif0.iaddr = 32'h00030034;

        #(PERIOD);
        reset_values();


        // Test Case #3
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Write 0xFFFFFFFF to address 0x000800AC";
        cif0.iREN = 1'b1;
        cif0.iaddr = 32'h000800AC;
        cif0.dstore = 32'hFFFFFFFF;

        #(PERIOD);
        reset_values();


        // Test Case #3 con
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Read instruction 0xFFFFFFFF from address 0x000800AC";
        cif1.iREN = 1'b1;
        cif1.iaddr = 32'h000800AC;

        #(PERIOD);
        reset_values();


        #(PERIOD);
        reset_values();


        dump_memory();

        reset_values();


        /*
        tb_test_num = tb_test_num + 1;
        tb_test_case = "TOGGLE";

        #(PERIOD);
        reset_values();
        // WRITE
        cif0.dWEN = 1'b1;
        cif0.daddr = 32'hFFFFFFFF;
        cif0.dstore = 32'hFFFFFFFF;

        #(PERIOD);
        reset_values();
        // READ
        cif0.dREN = 1'b1;
        cif0.daddr = 32'hFFFFFFFF;

        #(PERIOD);
        check_output(tb_test_case, 32'hFFFFFFFF, ccif.ramload);
        reset_values();

        cif0.iREN = 1'b1;
        cif0.iaddr = 32'hFFFFFFFF;

        #(PERIOD);
        check_output(tb_test_case, 32'hFFFFFFFF, ccif.ramload);
        reset_values();
        */
        $finish;
    end






endprogram : test
endmodule : memory_control_tb