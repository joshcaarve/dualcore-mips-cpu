
`include "cpu_types_pkg.vh"
`include "i_bus_control_if.vh"

module i_bus_control (
    input logic CLK,
    input logic nRST,
    i_bus_control_if.ib ibif
);
    logic select;
    logic next_select;

    always_ff @ (posedge CLK, negedge nRST) begin : SELECT_LOGIC
        if (nRST == 1'b0) begin
            select <= 1'b0;
        end
        else begin
            select <= next_select;
        end
    end : SELECT_LOGIC

    always_comb begin : NEXT_SELECT
        next_select = select;
        if (ibif.iwait == 1'b0) begin
            // halt case (ensure datapath puts low)
            if(ibif.iREN[0] && !ibif.iREN[1]) begin
                next_select = 1'b0;
            end
            else if (!ibif.iREN[0] && ibif.iREN[1]) begin
                next_select = 1'b1;
            end
            else if (ibif.iREN[0] && ibif.iREN[1]) begin
                next_select = !select;
            end
        end
		else begin
			if(ibif.iREN[0] && !ibif.iREN[1]) begin
                next_select = 1'b0;
            end
            else if (!ibif.iREN[0] && ibif.iREN[1]) begin
                next_select = 1'b1;
            end
		end
    end : NEXT_SELECT

    always_comb begin : OUTPUT_LOGIC

        ibif.iREN_out  = '0;
        ibif.iaddr_out = '0;
        ibif.iwait_out = '0;
        ibif.iload_out = '0;

        ibif.iload_out[select] = ibif.iload;
        ibif.iload_out[!select] = '0;

        ibif.iREN_out = ibif.iREN[select];
        ibif.iaddr_out = ibif.iaddr[select];

        ibif.iwait_out[select] = ibif.iwait;
        ibif.iwait_out[!select] = 1'b1;  // yeet
    end : OUTPUT_LOGIC

endmodule : i_bus_control
