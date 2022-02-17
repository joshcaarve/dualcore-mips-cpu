/*
  Joshua Brard
  jbrard@purdue.edu

  alu test bench
*/

// mapped needs this
`include "include/alu_if.vh"


`include "include/cpu_types_pkg.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module alu_tb;

  import cpu_types_pkg::*;
  parameter PERIOD = 10;

  logic CLK = 0; 
  // logic nRST;
  logic tb_blip = 1'b0;
  // clock
  always #(PERIOD/2) CLK++;

  // output task
  task check_output;
    input string test_case;

    input word_t expPortOut;
    input word_t actPortOut;

    input logic expZero;
    input logic actZero;

    input logic expOverflow;
    input logic actOverflow;

    input logic expNegative;
    input logic actNegative;
    begin
       tb_blip = 1'b1;
       assert(expPortOut == actPortOut &&
           expZero == actZero &&
           expOverflow == actOverflow &&
           expNegative == actNegative) begin
         //$info("Correct output for in test case %s", test_case);
       end
       else begin
         $error("Incorrect output in test case %s", test_case);
       end
       #(0.2);
       tb_blip = 1'b0;
    end
  endtask
	



  // interface
  alu_if aluif ();
  // test program
  test PROG (aluif);
  // DUT
`ifndef MAPPED
  alu DUT(aluif);
`else
  alu DUT(
    .\aluif.portA (aluif.portA),
    .\aluif.portB (aluif.portB),
    .\aluif.aluop (aluif.aluop),

    .\aluif.negative (aluif.negative),
    .\aluif.portOut (aluif.portOut),
    .\aluif.overflow (aluif.overflow),
    .\aluif.zero (aluif.zero)
  );
`endif

endmodule


program test (
	alu_if.rf aluif
);
	/*		
	modport rf (
    		input   portA, portB, aluop,
    		output  negative, portOut, overflow, zero
  	);
	*/
	parameter PERIOD = 10;
	import cpu_types_pkg::*;

	string tb_test_case;
	integer tb_test_num;
	initial
	begin
	
		tb_test_num  = 0;
		tb_test_case = "INIT";
		aluif.aluop = ALU_AND;
		aluif.portB = '0;
		aluif.portA = '0;
			
          	#(PERIOD / 2);

		// Test Case 1 'AND' instruction
		
		tb_test_num = tb_test_num + 1;
		tb_test_case = "ALU OP CODE for 'AND'";
		aluif.aluop = ALU_AND;
		aluif.portB = 32'hFFFFFFFF;
		aluif.portA = 32'hFFFFFFFF;
            
  		#(PERIOD / 4);
		check_output(tb_test_case, 
			32'hFFFFFFFF, aluif.portOut,
			1'b0, aluif.zero,
			1'b0, aluif.overflow,
			1'b1, aluif.negative);


		#(PERIOD / 2);

		// Test Case 2 'OR' instruction
		
		tb_test_num = tb_test_num + 1;
		tb_test_case = "ALU OP CODE for 'OR'";
		aluif.aluop = ALU_OR;
		aluif.portB = 32'hAAAAAAAA;
		aluif.portA = 32'h55555555;
            
  		#(PERIOD / 4);
		check_output(tb_test_case, 
			32'hFFFFFFFF, aluif.portOut,
			1'b0, aluif.zero,
			1'b0, aluif.overflow,
			1'b1, aluif.negative);


		#(PERIOD / 2);


		// Test Case 3 'XOR' instruction
		
		tb_test_num = tb_test_num + 1;
		tb_test_case = "ALU OP CODE for 'XOR'";
		aluif.aluop = ALU_XOR;
		aluif.portB = 32'hFFFFFFFF;
		aluif.portA = 32'h55555555;
            
  		#(PERIOD / 4);
		check_output(tb_test_case, 
			32'hAAAAAAAA, aluif.portOut,
			1'b0, aluif.zero,
			1'b0, aluif.overflow,
			1'b1, aluif.negative);


		#(PERIOD / 2);

		// Test Case 4 'NOR' instruction
		
		tb_test_num = tb_test_num + 1;
		tb_test_case = "ALU OP CODE for 'NOR'";
		aluif.aluop = ALU_NOR;
		aluif.portB = 32'h7FFF0000;
		aluif.portA = 32'hF9F9F9F9;
            
  		#(PERIOD / 4);
		check_output(tb_test_case, 
			32'h00000606, aluif.portOut,
			1'b0, aluif.zero,
			1'b0, aluif.overflow,
			1'b0, aluif.negative);


		#(PERIOD / 2);

		
		// Test Case 5 'ADD' instruction
		
		tb_test_num = tb_test_num + 1;
		tb_test_case = "ALU OP CODE for 'ADD'";
		aluif.aluop = ALU_ADD;
		aluif.portB = 32'hFFFFFFFF;
		aluif.portA = 32'hFFFFFFFF;
            
  		#(PERIOD / 4);
		check_output(tb_test_case, 
			32'hFFFFFFFE, aluif.portOut,
			1'b0, aluif.zero,
			1'b1, aluif.overflow,
			1'b1, aluif.negative);


		#(PERIOD / 2);

		// Test Case 5 'SUB' instruction
		
		tb_test_num = tb_test_num + 1;
		tb_test_case = "ALU OP CODE for 'SUB'";
		aluif.aluop = ALU_SUB;
		aluif.portA = 32'hFF;
		aluif.portB = 32'hDD;
            
  		#(PERIOD / 4);
		check_output(tb_test_case, 
			32'h22, aluif.portOut,
			1'b0, aluif.zero,
			1'b1, aluif.overflow,
			1'b0, aluif.negative);


		#(PERIOD / 2);

		// Test Case 6 'SUB' instruction
		
		tb_test_num = tb_test_num + 1;
		tb_test_case = "ALU OP CODE for 'SUB' w/ zero flag";
		aluif.aluop = ALU_SUB;
		aluif.portA = 32'hFFFFFFFF;
		aluif.portB = 32'hFFFFFFFF;
            
  		#(PERIOD / 4);
		check_output(tb_test_case, 
			32'h0, aluif.portOut,
			1'b1, aluif.zero,
			1'b0, aluif.overflow,
			1'b0, aluif.negative);


		#(PERIOD / 2);

		// Test Case 7 'SLT' instruction
		
		tb_test_num = tb_test_num + 1;
		tb_test_case = "ALU OP CODE for 'SLT'";
		aluif.aluop = ALU_SLT;
		aluif.portA = 32'h00FFFFFF;
		aluif.portB = 32'h0FFFFFFF;
            
  		#(PERIOD / 4);
		check_output(tb_test_case, 
			32'h1, aluif.portOut,
			1'b0, aluif.zero,
			1'b0, aluif.overflow,
			1'b0, aluif.negative);

		#(PERIOD / 2);


		// Test Case 8 'SLTU' instruction
		
		tb_test_num = tb_test_num + 1;
		tb_test_case = "ALU OP CODE for 'SLTU' (both Positive)";
		aluif.aluop = ALU_SLTU;
		aluif.portA = 32'h00FFFFFF;
		aluif.portB = 32'h0FFFFFFF;
            
  		#(PERIOD / 4);
		check_output(tb_test_case, 
			32'h1, aluif.portOut,
			1'b0, aluif.zero,
			1'b0, aluif.overflow,
			1'b0, aluif.negative);

		#(PERIOD / 2);

		// Test Case 9 'SLTU' instruction
		
		tb_test_num = tb_test_num + 1;
		tb_test_case = "ALU OP CODE for 'SLTU' (both Negative)";
		aluif.aluop = ALU_SLTU;
		aluif.portA = 32'hEFFFFFFF;
		aluif.portB = 32'hFFFFFFFF;
            
  		#(PERIOD / 4);
		check_output(tb_test_case, 
			32'h0, aluif.portOut,
			1'b0, aluif.zero,
			1'b0, aluif.overflow,
			1'b0, aluif.negative);

		#(PERIOD / 2);


		// Test Case 10 'SLTU' instruction
		
		tb_test_num = tb_test_num + 1;
		tb_test_case = "ALU OP CODE for 'SLTU' (A is neg)";
		aluif.aluop = ALU_SLTU;
		aluif.portA = 32'hFFFFFFFF;
		aluif.portB = 32'h0FFFFFFF;
            
  		#(PERIOD / 4);
		check_output(tb_test_case, 
			32'h1, aluif.portOut,
			1'b0, aluif.zero,
			1'b0, aluif.overflow,
			1'b0, aluif.negative);

		#(PERIOD / 2);

		// Test Case 11 'SLTU' instruction
		
		tb_test_num = tb_test_num + 1;
		tb_test_case = "ALU OP CODE for 'SLTU' (B is neg)";
		aluif.aluop = ALU_SLTU;
		aluif.portA = 32'h0FFFFFFF;
		aluif.portB = 32'hFFFFFFFF;
            
  		#(PERIOD / 4);
		check_output(tb_test_case, 
			32'h0, aluif.portOut,
			1'b1, aluif.zero,
			1'b0, aluif.overflow,
			1'b0, aluif.negative);

		#(PERIOD / 2);
		
		// Test Case 12 'SLL' instruction
		
		tb_test_num = tb_test_num + 1;
		tb_test_case = "ALU OP CODE for 'SLL";
		aluif.aluop = ALU_SLL;
		aluif.portA = 32'h00000001;
		aluif.portB = 32'h00000001;
            
  		#(PERIOD / 4);
		check_output(tb_test_case, 
			32'h00000002, aluif.portOut,
			1'b0, aluif.zero,
			1'b0, aluif.overflow,
			1'b0, aluif.negative);

		#(PERIOD / 2);


		// Test Case 13 'SRL' instruction
		
		tb_test_num = tb_test_num + 1;
		tb_test_case = "ALU OP CODE for 'SRL";
		aluif.aluop = ALU_SRL;
		aluif.portA = 32'h00000001;
		aluif.portB = 32'h00000002;
            
  		#(PERIOD / 4);
		check_output(tb_test_case, 
			32'h00000001, aluif.portOut,
			1'b0, aluif.zero,
			1'b0, aluif.overflow,
			1'b0, aluif.negative);

		#(PERIOD / 2);
		

		// Test Case 14 'AND' instruction
		
		tb_test_num = tb_test_num + 1;
		tb_test_case = "ALU OP CODE for 'AND' both zero";
		aluif.aluop = ALU_SRL;
		aluif.portA = 32'h00000000;
		aluif.portB = 32'h00000000;
            
  		#(PERIOD / 4);
		check_output(tb_test_case, 
			32'h00000000, aluif.portOut,
			1'b1, aluif.zero,
			1'b0, aluif.overflow,
			1'b0, aluif.negative);

		#(PERIOD / 2);

		$finish;
	end
	
endprogram