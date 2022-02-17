/*
	Joshua Brard
	jbrard@purdue.edu

	register file
*/
`include "cpu_types_pkg.vh"
`include "alu_if.vh"

module alu (
	alu_if.rf aluif
);
	import cpu_types_pkg::*;
	assign aluif.negative = aluif.portOut[31];
	assign aluif.zero = (aluif.portOut == 0 ? 1'b1 : 1'b0);
	always_comb begin
		// avoid latch
		aluif.portOut 	= '0;

		//aluif.negative = '0;

		aluif.overflow 	= '0;

		//aluif.zero 	= '0;

		casez(aluif.aluop)
			ALU_SLL : begin
				aluif.portOut = aluif.portB << aluif.portA[4:0];
				// no overflow
			end
			
			ALU_SRL : begin
				aluif.portOut = aluif.portB >> aluif.portA[4:0];
				// no overflow
			end
			
			ALU_ADD : begin
				{aluif.overflow, aluif.portOut} = {1'b0, aluif.portA} + {1'b0, aluif.portB};
			end

			ALU_SUB : begin
				{aluif.overflow, aluif.portOut} = {1'b0, aluif.portA} - {1'b0, aluif.portB};
				//aluif.portOut = aluif.portA - aluif.portB;
			end

			ALU_AND : begin
				aluif.portOut = aluif.portA & aluif.portB;
				// no overflow
			end

			ALU_OR : begin
				aluif.portOut = aluif.portA | aluif.portB;
				// no overflow
			end

			ALU_XOR : begin
				aluif.portOut = aluif.portA ^ aluif.portB;
				// no overflow
			end

			ALU_NOR : begin
				aluif.portOut = ~(aluif.portA | aluif.portB);
				// no overflow
			end

			ALU_SLT	: begin
 				// both negative
				if(aluif.portA[31] && aluif.portB[31]) begin
					if(aluif.portA < aluif.portB) begin
						aluif.portOut = 1'b0;
					end
					else begin
						aluif.portOut = 1'b1;
					end
				end 
				else if (aluif.portA[31] && !aluif.portB[31]) begin
					aluif.portOut = 1'b1;
				end
				else if(!aluif.portA[31] && aluif.portB[31]) begin
					aluif.portOut = 1'b0;
				end
				// both positive
				else begin
					if(aluif.portA < aluif.portB) begin
						aluif.portOut = 1'b1;
					end
					else begin
						aluif.portOut = 1'b0;
					end
				end
				// no overflow
			end

			ALU_SLTU : begin
				if(aluif.portA < aluif.portB) begin
					aluif.portOut = 1'b1;
				end
				else begin
					aluif.portOut = 1'b0;
				end
				// no overflow
			end
		endcase
	end
endmodule 