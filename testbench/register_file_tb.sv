/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "include/register_file_if.vh"


`include "include/cpu_types_pkg.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module register_file_tb;

  import cpu_types_pkg::*;
  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

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
  endtask

  /*
  task check_output;
    word_t expected;
    word_t actual;
    string test_case;
    begin
       if (expected == actual) begin
         $info("Correct output for test case %s", test_case);
       end
       else begin
         $error("Incorrect output for test case %s", test_case);
       end
    end
  endtask
  */

  // interface
  register_file_if rfif ();
  // test program
  test PROG (CLK, nRST, rfif);
  // DUT
`ifndef MAPPED
  register_file DUT(CLK, nRST, rfif);
`else
  register_file DUT(
    .\rfif.rdat2 (rfif.rdat2),
    .\rfif.rdat1 (rfif.rdat1),
    .\rfif.wdat (rfif.wdat),
    .\rfif.rsel2 (rfif.rsel2),
    .\rfif.rsel1 (rfif.rsel1),
    .\rfif.wsel (rfif.wsel),
    .\rfif.WEN (rfif.WEN),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

endmodule


program test (
	input logic CLK, 
	input logic nRST, 
	register_file_if.tb rfif
);
		
	/* modport rf (
   		 input   WEN, wsel, rsel1, rsel2, wdat,
  		 output  rdat1, rdat2
 	 ); */
	parameter PERIOD = 10;
	import cpu_types_pkg::*;

	string tb_test_case;
	integer tb_test_num;
	integer i;
	initial
	begin
	
		tb_test_num  = 0;
		tb_test_case = "INIT";
		rfif.WEN     = '0;
                rfif.wsel    = '0;
                rfif.rsel1   = '0;
                rfif.rsel2   = '0;
                rfif.wdat    = '0;

		// Test Case 1
		tb_test_num = tb_test_num + 1;
		tb_test_case = "RESET";
		#(0.1);

                reset_dut();
	

		// Test Case 2
		
		tb_test_num = tb_test_num + 1;
		tb_test_case = "WEN == 1'b1 Write data to regFile[1]";

                rfif.WEN = 1'b1;
             	rfif.rsel1 = 5'b00001;
                rfif.rsel2 = 5'b00001;

		for(i = 0; i < 32; i++) begin
			rfif.wdat = 32'hFFFFFFFF;
			rfif.wsel = i;
			#(PERIOD);
		end
	
		#(PERIOD * 10);
            

		
		// Test Case 3
	        rfif.WEN = 1'b0;
		reset_dut();
		tb_test_num = tb_test_num + 1;
		tb_test_case = "WEN == 1'b0 Write data to regFile[1]";

                rfif.WEN = 1'b0;
             	rfif.rsel1 = 5'b00001;
                rfif.rsel2 = 5'b00001;

		for(i = 0; i < 32; i++) begin
			rfif.wdat = 32'hFFFFFFFF;
			rfif.wsel = i;
			#(PERIOD);
		end
	
		#(PERIOD * 10);

		
		$finish;
	end
	
endprogram
