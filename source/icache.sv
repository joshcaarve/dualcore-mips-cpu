/*
	Joshua Brard && Rohan Prabhu
	jbrard@purdue.edu, prabhu4@purdue.edu

*/

`include "cpu_types_pkg.vh"
`include "caches_types_pkg.vh"
`include "caches_if.vh"
`include "datapath_cache_if.vh"


module icache (
    input logic CLK,
    input logic nRST,
	input logic halt,
    caches_if.icache ccif,
    datapath_cache_if.icache dpif
);
    import cpu_types_pkg::*;
    import caches_types_pkg::*;

    // state variables
    icache_state_t state;
    icache_state_t next_state;

    // icachef_t variables
    icachef_t icachef;

    // did we find the value in the icache table
    logic hit;

    // frame variable
    icache_frame [ICACHEROWS - 1 :0] icache;
    icache_frame [ICACHEROWS - 1 :0] next_icache;

    always_comb begin : PARSER
        icachef = '0;
        if(dpif.imemREN == 1'b1) begin
            icachef = icachef_t'(dpif.imemaddr);  // parse (typecast possibly optional)
            //icachef = dpif.imemaddr;  // parse (typecast possibly optional)
        end
    end : PARSER


    always_comb begin : DETERMINE_HIT
        hit = 1'b0;
        if(icache[icachef.idx].valid && (icache[icachef.idx].tag == icachef.tag)) begin
            hit = 1'b1;
        end
    end : DETERMINE_HIT


    // NEXT STATE
    always_ff @ (posedge CLK, negedge nRST) begin : NEXT_STATE
        if(nRST == 1'b0) begin
            state <= IDLE;
            // reset icache
        end
        else begin
            state <= next_state;
        end
    end : NEXT_STATE

    // next icache
    //integer i;
    always_ff @ (posedge CLK, negedge nRST) begin : NEXT_ICACHE
        if(nRST == 1'b0) begin
            icache <= '0;
        end
        else begin
            icache <= next_icache;
        end
    end : NEXT_ICACHE


    always_comb begin : NEXT_STATE_LOGIC
        next_state = IDLE;  // no latch
        casez (state)
        IDLE : begin
            if(hit == 1'b1) begin
                next_state = IDLE;
            end
            else begin
                next_state = UPDATE;
            end
        end
        UPDATE : begin
            if(ccif.iwait == 1'b1) begin
                next_state = UPDATE;
            end
            else begin
                next_state = IDLE;
            end
        end
        endcase
    end : NEXT_STATE_LOGIC


    always_comb begin : ICACHE_UPDATE
        next_icache = icache;
        if(state == UPDATE) begin

            if(ccif.iwait == 1'b0) begin
		        next_icache[icachef.idx].data = ccif.iload;
		        next_icache[icachef.idx].valid = 1'b1;
		        next_icache[icachef.idx].tag = icachef.tag;
            end
        end
    end : ICACHE_UPDATE

	assign dpif.ihit = hit && !halt;

    always_comb begin : OUTPUT_LOGIC

        dpif.imemload  = '0;
        ccif.iaddr     = '0;
        ccif.iREN      = '0;

        casez (state)
            IDLE : begin
 				ccif.iaddr = '0;
        		ccif.iREN  = '0;
                if(hit == 1'b1) begin
                    dpif.imemload = icache[icachef.idx].data;
                end
            end
            UPDATE : begin
				dpif.imemload  = '0;
                ccif.iaddr = dpif.imemaddr;
                ccif.iREN = 1'b1;
                //dpif.imemload = icache[icachef.idx].data;
            end
        endcase
    end : OUTPUT_LOGIC


endmodule : icache
