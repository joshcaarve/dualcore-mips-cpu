/*
	Joshua Brard
	jbrard@purdue.edu

	register file
*/
`include "cpu_types_pkg.vh"
`include "register_file_if.vh"

module register_file (
	input logic CLK,
	input logic nRST,
	register_file_if.rf rfif
);

	import cpu_types_pkg::*;

	word_t [31 : 0] regFile; // 2d array to store
	word_t [31 : 0] nextRegFile;  // 2d array to store

	always_ff @ (negedge CLK, negedge nRST) begin : FF
		if(nRST == 1'b0) begin
			regFile <= '0;
		end 
		else begin
			regFile <= nextRegFile;
		end
	end  // end always_ff

	always_comb begin : NEXT_REG_FILE_LOGIC
		nextRegFile = regFile;  // no latch
		if(rfif.WEN) begin
			nextRegFile[rfif.wsel] = rfif.wdat;
		end
		nextRegFile[0] = '0;
	end  // end always_comb

	always_comb begin : OUTPUT_LOGIC
		rfif.rdat1 = '0;
		rfif.rdat2 = '0;
		
		rfif.rdat1 = regFile[rfif.rsel1];
		rfif.rdat2 = regFile[rfif.rsel2];
	end  // end always_comb
endmodule 
