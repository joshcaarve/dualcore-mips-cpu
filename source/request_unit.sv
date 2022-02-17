/*
    Joshua Brard
    jbrard@purdue.edu

    The request_unit will detect when memory requests are completed in the datapath and
    take actions to deassert the memory request.

*/

`include "request_unit_if.vh"
`include "cpu_types_pkg.vh"

module request_unit (
    input logic clk, nRST,
    request_unit_if.ru rqif
);

    always_ff @ (posedge clk, negedge nRST) begin
        if (nRST == 1'b0) begin
            rqif.dmemREN <= '0;
            rqif.dmemWEN <= '0;
            rqif.imemREN <= '1;
        end

        else begin
	        // rqif.imemREN <= 1'b1;  // always want to get next instruction (gotta keep moving)
	        rqif.imemREN <= rqif.iREN;  // always set to 1'b1

            //rqif.dmemREN <= rqif.dmemREN;
            //rqif.dmemWEN <= rqif.dmemWEN;

            if (rqif.ihit == 1'b1) begin
		        rqif.dmemREN <= rqif.dREN;  // send next data
		        rqif.dmemWEN <= rqif.dWEN;  // data
	        end
            else if (rqif.dhit == 1'b1) begin
		        rqif.dmemREN <= 1'b0;  // do not need to get data anymore
		        rqif.dmemWEN <= 1'b0;  // do not need to get data anymore
	        end
        end
    end
endmodule : request_unit
