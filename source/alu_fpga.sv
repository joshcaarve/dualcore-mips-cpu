/*
  Joshua Brard
  jbrard@purdue.edu

  alu fpga wrapper
*/

`include "cpu_types_pkg.vh"
`include "alu_if.vh"
module alu_fpga (
	input logic [3 : 0] KEY,
	input logic [17 : 0] SW,


	output logic [6 : 0] HEX0,
	output logic [6 : 0] HEX1,
	output logic [6 : 0] HEX2,
	output logic [6 : 0] HEX3,
	output logic [6 : 0] HEX4,
	output logic [6 : 0] HEX5,
	output logic [6 : 0] HEX6,
	output logic [6 : 0] HEX7
);
	import cpu_types_pkg::*;
	// interface
 	alu_if aluif();

	// 
	alu ALU(aluif);


	assign aluif.aluop = aluop_t'(~KEY);
	
	assign aluif.portA = { { 16 {SW [16] } }, SW [15 : 0] };

	always_ff @ (posedge SW[17]) begin
		aluif.portB <= { { 16 {SW [16] } }, SW [15 : 0] };
	end


	always_comb begin
		HEX0 = '0;
		casez(aluif.portOut[3 : 0])
			'h0: HEX0 = 7'b1000000;
      			'h1: HEX0 = 7'b1111001;
      			'h2: HEX0 = 7'b0100100;
      			'h3: HEX0 = 7'b0110000;
      			'h4: HEX0 = 7'b0011001;
      			'h5: HEX0 = 7'b0010010;
      			'h6: HEX0 = 7'b0000010;
      			'h7: HEX0 = 7'b1111000;
      			'h8: HEX0 = 7'b0000000;
     			'h9: HEX0 = 7'b0010000;
      			'hA: HEX0 = 7'b0001000;
     			'hB: HEX0 = 7'b0000011;
      			'hC: HEX0 = 7'b0100111;
     			'hD: HEX0 = 7'b0100001;
      			'hE: HEX0 = 7'b0000110;
      			'hF: HEX0 = 7'b0001110;
		endcase
	end


	always_comb begin
		HEX1 = '0;
		casez(aluif.portOut[7 : 4])
			'h0: HEX1 = 7'b1000000;
      			'h1: HEX1 = 7'b1111001;
      			'h2: HEX1 = 7'b0100100;
      			'h3: HEX1 = 7'b0110000;
      			'h4: HEX1 = 7'b0011001;
      			'h5: HEX1 = 7'b0010010;
      			'h6: HEX1 = 7'b0000010;
      			'h7: HEX1 = 7'b1111000;
      			'h8: HEX1 = 7'b0000000;
     			'h9: HEX1 = 7'b0010000;
      			'hA: HEX1 = 7'b0001000;
     			'hB: HEX1 = 7'b0000011;
      			'hC: HEX1 = 7'b0100111;
     			'hD: HEX1 = 7'b0100001;
      			'hE: HEX1 = 7'b0000110;
      			'hF: HEX1 = 7'b0001110;
		endcase
	end

	always_comb begin
		HEX2 = '0;
		casez(aluif.portOut[11 : 8])
			'h0: HEX2 = 7'b1000000;
      			'h1: HEX2 = 7'b1111001;
      			'h2: HEX2 = 7'b0100100;
      			'h3: HEX2 = 7'b0110000;
      			'h4: HEX2 = 7'b0011001;
      			'h5: HEX2 = 7'b0010010;
      			'h6: HEX2 = 7'b0000010;
      			'h7: HEX2 = 7'b1111000;
      			'h8: HEX2 = 7'b0000000;
     			'h9: HEX2 = 7'b0010000;
      			'hA: HEX2 = 7'b0001000;
     			'hB: HEX2 = 7'b0000011;
      			'hC: HEX2 = 7'b0100111;
     			'hD: HEX2 = 7'b0100001;
      			'hE: HEX2 = 7'b0000110;
      			'hF: HEX2 = 7'b0001110;
		endcase
	end

	always_comb begin
		HEX3 = '0;
		casez(aluif.portOut[15 : 12])
			'h0: HEX3 = 7'b1000000;
      			'h1: HEX3 = 7'b1111001;
      			'h2: HEX3 = 7'b0100100;
      			'h3: HEX3 = 7'b0110000;
      			'h4: HEX3 = 7'b0011001;
      			'h5: HEX3 = 7'b0010010;
      			'h6: HEX3 = 7'b0000010;
      			'h7: HEX3 = 7'b1111000;
      			'h8: HEX3 = 7'b0000000;
     			'h9: HEX3 = 7'b0010000;
      			'hA: HEX3 = 7'b0001000;
     			'hB: HEX3 = 7'b0000011;
      			'hC: HEX3 = 7'b0100111;
     			'hD: HEX3 = 7'b0100001;
      			'hE: HEX3 = 7'b0000110;
      			'hF: HEX3 = 7'b0001110;
		endcase
	end

	always_comb begin
		HEX4 = '0;
		casez(aluif.portOut[19 : 16])
			'h0: HEX4 = 7'b1000000;
      			'h1: HEX4 = 7'b1111001;
      			'h2: HEX4 = 7'b0100100;
      			'h3: HEX4 = 7'b0110000;
      			'h4: HEX4 = 7'b0011001;
      			'h5: HEX4 = 7'b0010010;
      			'h6: HEX4 = 7'b0000010;
      			'h7: HEX4 = 7'b1111000;
      			'h8: HEX4 = 7'b0000000;
     			'h9: HEX4 = 7'b0010000;
      			'hA: HEX4 = 7'b0001000;
     			'hB: HEX4 = 7'b0000011;
      			'hC: HEX4 = 7'b0100111;
     			'hD: HEX4 = 7'b0100001;
      			'hE: HEX4 = 7'b0000110;
      			'hF: HEX4 = 7'b0001110;
		endcase
	end

	always_comb begin
		HEX5 = '0;
		casez(aluif.portOut[23 : 20])
			'h0: HEX5 = 7'b1000000;
      			'h1: HEX5 = 7'b1111001;
      			'h2: HEX5 = 7'b0100100;
      			'h3: HEX5 = 7'b0110000;
      			'h4: HEX5 = 7'b0011001;
      			'h5: HEX5 = 7'b0010010;
      			'h6: HEX5 = 7'b0000010;
      			'h7: HEX5 = 7'b1111000;
      			'h8: HEX5 = 7'b0000000;
     			'h9: HEX5 = 7'b0010000;
      			'hA: HEX5 = 7'b0001000;
     			'hB: HEX5 = 7'b0000011;
      			'hC: HEX5 = 7'b0100111;
     			'hD: HEX5 = 7'b0100001;
      			'hE: HEX5 = 7'b0000110;
      			'hF: HEX5 = 7'b0001110;
		endcase
	end

	always_comb begin
		HEX6 = '0;
		casez(aluif.portOut[27 : 24])
			'h0: HEX6 = 7'b1000000;
      			'h1: HEX6 = 7'b1111001;
      			'h2: HEX6 = 7'b0100100;
      			'h3: HEX6 = 7'b0110000;
      			'h4: HEX6 = 7'b0011001;
      			'h5: HEX6 = 7'b0010010;
      			'h6: HEX6 = 7'b0000010;
      			'h7: HEX6 = 7'b1111000;
      			'h8: HEX6 = 7'b0000000;
     			'h9: HEX6 = 7'b0010000;
      			'hA: HEX6 = 7'b0001000;
     			'hB: HEX6 = 7'b0000011;
      			'hC: HEX6 = 7'b0100111;
     			'hD: HEX6 = 7'b0100001;
      			'hE: HEX6 = 7'b0000110;
      			'hF: HEX6 = 7'b0001110;
		endcase
	end
	
	always_comb begin
		HEX7 = '0;
		casez(aluif.portOut[31 : 28])
			'h0: HEX7 = 7'b1000000;
      			'h1: HEX7 = 7'b1111001;
      			'h2: HEX7 = 7'b0100100;
      			'h3: HEX7 = 7'b0110000;
      			'h4: HEX7 = 7'b0011001;
      			'h5: HEX7 = 7'b0010010;
      			'h6: HEX7 = 7'b0000010;
      			'h7: HEX7 = 7'b1111000;
      			'h8: HEX7 = 7'b0000000;
     			'h9: HEX7 = 7'b0010000;
      			'hA: HEX7 = 7'b0001000;
     			'hB: HEX7 = 7'b0000011;
      			'hC: HEX7 = 7'b0100111;
     			'hD: HEX7 = 7'b0100001;
      			'hE: HEX7 = 7'b0000110;
      			'hF: HEX7 = 7'b0001110;
		endcase
	end
endmodule 