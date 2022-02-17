/*
	Joshua Brard && Rohan Prabhu
	jbrard@purdue.edu, prabhu4@purdue.edu

*/

`include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"
`include "caches_types_pkg.vh"
`include "caches_if.vh"



module dcache (
    input logic CLK,
    input logic nRST,
    caches_if.dcache ccif,
	datapath_cache_if.dcache dpif
);
    import cpu_types_pkg::*;
    import caches_types_pkg::*;

    dcachef_t dcachef;
    dcache_frame [DCACHECOLUMNS-1:0] cache [DCACHEROWS-1:0];
    dcache_frame [DCACHECOLUMNS-1:0] next_cache [DCACHEROWS-1:0];

    logic [7:0] next_lru;
    logic [7:0] lru;

    dcache_state_t state;
    dcache_state_t next_state;

    logic [5:0] limit;
    logic [5:0] next_limit;
    word_t true_addr;

	logic left;
    logic right;
    logic hit;
    word_t [1:0] target_block;
    dcache_frame chosen_frame;


    always_comb begin : PARSER
        dcachef = dcachef_t'(dpif.dmemaddr);
        if(state == SNOOPED || state ==  RAMWRITE0 || state == RAMWRITE1) begin
            dcachef = dcachef_t'(ccif.ccsnoopaddr);
        end
    end : PARSER


    //integer i;
    //integer j;
    always_ff @ (posedge CLK, negedge nRST) begin
        if (nRST == 1'b0) begin
            state 	    <= INITIAL;
        end
        else begin
            state 	    <= next_state;
        end
    end

	always_ff @ (posedge CLK, negedge nRST) begin
        if (nRST == 1'b0) begin
            limit 		<= '0;
        end
        else begin
            limit 		<= next_limit;
        end
    end

	always_ff @ (posedge CLK, negedge nRST) begin
        if (nRST == 1'b0) begin
            lru 		<= '0;
        end
        else begin
            lru 		<= next_lru;
        end
    end
	always_ff @ (posedge CLK, negedge nRST) begin
		if (nRST == 1'b0) begin
			cache[0][0] <= '0;
			cache[0][1] <= '0;
			cache[1][0] <= '0;
			cache[1][1] <= '0;
			cache[2][0] <= '0;
			cache[2][1] <= '0;
			cache[3][0] <= '0;
			cache[3][1] <= '0;
			cache[4][0] <= '0;
			cache[4][1] <= '0;
			cache[5][0] <= '0;
			cache[5][1] <= '0;
			cache[6][0] <= '0;
			cache[6][1] <= '0;
			cache[7][0] <= '0;
			cache[7][1] <= '0;
		end
		else begin
			cache <= next_cache;
		end
	end


    always_comb begin
        right = 1'b0;
        if ((dcachef.tag == cache[dcachef.idx][1].tag) && cache[dcachef.idx][1].valid == 1'b1) begin
            right = 1'b1;
        end
    end

    always_comb begin
        left = 1'b0;
        if ((dcachef.tag == cache[dcachef.idx][0].tag) && cache[dcachef.idx][0].valid == 1'b1) begin
            left  = 1'b1;
        end
    end

    logic match;
    always_comb begin : CALC_MATCH
        match = 1'b0;
        if (left || right) begin
            match = 1'b1;
        end
    end : CALC_MATCH


    assign target_block = cache[dcachef.idx][right].data;
    always_comb begin
        chosen_frame = cache[dcachef.idx][lru[dcachef.idx]];
        if (match) begin//state == SNOOPED || state ==  RAMWRITE0 || state == RAMWRITE1) begin
            chosen_frame = cache[dcachef.idx][right];
        end
    end

    assign hit = match && chosen_frame.valid && chosen_frame.dirty;

	always_comb begin
        true_addr = dpif.dmemaddr;
        if (dcachef.blkoff) begin
            true_addr = dpif.dmemaddr - 32'd4;
        end
    end

    word_t snoop_addr;
    always_comb begin
        snoop_addr = ccif.ccsnoopaddr;
        if (dcachef.blkoff) begin
            snoop_addr = ccif.ccsnoopaddr - 32'd4;
        end
    end

    logic active;
    assign active = dpif.dmemREN || dpif.dmemWEN;

    always_comb begin
        next_state = state;
        casez (state)
            INITIAL : begin
                if(ccif.ccwait) begin
                    next_state = SNOOPED;
                end
                else if (dpif.dmemWEN) begin
                    if (chosen_frame.dirty && !hit && active) begin
                        next_state = CLEANWRITE;
                    end
                    else if (!chosen_frame.dirty && !hit && active) begin
                        next_state = MEMREAD;
                    end
                end
                else if (dpif.dmemREN) begin
                    if (chosen_frame.dirty && !match && active) begin
                        next_state = CLEANWRITE;
                    end
                    else if (!chosen_frame.dirty && !match && active) begin
                        next_state = MEMREAD;
                    end
                end
                else if (dpif.halt) begin
                    next_state = HALTCACHE;
                end
            end
            SNOOPED : begin
                if(match && chosen_frame.dirty && chosen_frame.valid)begin
                    next_state = RAMWRITE0;
                end
                else if (match && !chosen_frame.dirty && chosen_frame.valid) begin
                    next_state = INITIAL;
                end
                else if (!match || !chosen_frame.valid) begin
                    next_state = INITIAL;
                end
            end

            RAMWRITE0 : begin
                if(!ccif.dwait) begin
                    next_state = RAMWRITE1;
                end
            end
            RAMWRITE1 : begin
                if(!ccif.dwait) begin
                    next_state = INITIAL;
                end
            end
            CLEANWRITE : begin
                if (ccif.ccwait) begin
                    next_state = SNOOPED;
                end
                else if(!ccif.dwait) begin
                    next_state = CLEANFLAG;
                end
            end
            CLEANFLAG : begin
                if (ccif.ccwait) begin
                    next_state = SNOOPED;
                end
                else if(!ccif.dwait) begin
                    next_state = INITIAL;
                end
            end
            MEMREAD : begin
              	if (ccif.ccwait) begin
                    next_state = SNOOPED;
                end
                else if(!ccif.dwait) begin
                    next_state = READFLAG;
                end
            end
            READFLAG : begin
                if (ccif.ccwait) begin
                    next_state = SNOOPED;
                end
                else if(!ccif.dwait) begin
                    next_state = INITIAL;
                end
            end
            HALTCACHE : begin
                //limit must be 8 in order to preven loop
                if(limit >= 6'd32) begin
                    next_state = FLUSHED;
                end
                else if (ccif.ccwait) begin
                    next_state = SNOOPED;
                end
                else begin
                    next_state = HALTCACHE;
                end
            end
            FLUSHED : begin
                next_state = FLUSHED;
            end
			default : begin
				next_state = state;
			end
        endcase

    end



    always_comb begin : OUTPUT_LOGIC
        next_lru 		= lru;
        next_cache 		= cache;
        next_limit 		= limit;

        ccif.dstore 	= '0;
        ccif.dREN 		= '0;
        ccif.dWEN 		= '0;
        ccif.daddr 		= '0;
        ccif.ccwrite 	= '0;
        ccif.cctrans 	= '0;

        dpif.dhit 		= 1'b0;
        dpif.dmemload 	= '0;
        dpif.flushed 	= '0;

        casez (state)

            INITIAL : begin
                if (dpif.dmemREN && match) begin

                    next_lru[dcachef.idx] = left;
                    dpif.dmemload = target_block[dcachef.blkoff];
                    dpif.dhit = 1'b1;

                end
                else if (dpif.dmemWEN && hit) begin

                    next_lru[dcachef.idx] = left;
                    next_cache[dcachef.idx][right].data[dcachef.blkoff] = dpif.dmemstore;
                    dpif.dhit = 1'b1;

                end
            end

            SNOOPED : begin
				dpif.dhit = 1'b0;
                if (match) begin
                    if(chosen_frame.dirty && chosen_frame.valid)begin
                        ccif.cctrans = 1'b1;
                        ccif.ccwrite = 1'b1;
                    end
                    else if (!chosen_frame.dirty && chosen_frame.valid) begin
                        ccif.cctrans = 1'b1;
                        ccif.ccwrite = 1'b0;
                        if (ccif.ccinv) begin
                            next_cache[dcachef.idx][right].valid = 1'b0;
                            next_cache[dcachef.idx][right].dirty = 1'b0;
                        end
                        else begin
                            next_cache[dcachef.idx][right].valid = 1'b1;
                            next_cache[dcachef.idx][right].dirty = 1'b0;
                        end
                    end
                end
                else if (!match || !chosen_frame.valid) begin
                    ccif.cctrans = 1'b1;
                    ccif.ccwrite = 1'b0;
                end
            end
            RAMWRITE0 : begin
				dpif.dhit = 1'b0;
                ccif.daddr = snoop_addr;
                ccif.dWEN = 1'b1;
                ccif.dstore = chosen_frame.data[0];

            end
            RAMWRITE1 : begin
				dpif.dhit = 1'b0;
                ccif.daddr = snoop_addr + 4;
                ccif.dWEN = 1'b1;
                ccif.dstore = chosen_frame.data[1];

                if (!ccif.dwait) begin

                    if (ccif.ccinv) begin
                        next_cache[dcachef.idx][right].valid = 1'b0;
                        next_cache[dcachef.idx][right].dirty = 1'b0;
                    end
                    else begin
                        next_cache[dcachef.idx][right].valid = 1'b1;
                        next_cache[dcachef.idx][right].dirty = 1'b0;
                    end
                end
            end

            CLEANWRITE : begin
				dpif.dhit = 1'b0;
                ccif.ccwrite = 1'b1;
                ccif.dWEN = 1'b1;
                ccif.daddr = {chosen_frame.tag, dcachef.idx, 3'd0};
                ccif.dstore = chosen_frame.data[0];

            end

            CLEANFLAG : begin
				dpif.dhit = 1'b0;
                ccif.ccwrite = 1'b1;
                ccif.dWEN = 1'b1;
                ccif.daddr = {chosen_frame.tag, dcachef.idx, 3'd0} + 4;
                ccif.dstore = chosen_frame.data[1];

                //TODO DELETE
                if (!ccif.dwait) begin
                    if (ccif.ccinv) begin
                        next_cache[dcachef.idx][lru[dcachef.idx]].valid = 1'b0;
                        next_cache[dcachef.idx][lru[dcachef.idx]].dirty = 1'b0;
                    end
                    else begin
                        next_cache[dcachef.idx][lru[dcachef.idx]].valid = 1'b1;
                        next_cache[dcachef.idx][lru[dcachef.idx]].dirty = 1'b0;
                    end
                end

            end

            MEMREAD : begin
				dpif.dhit = 1'b0;
                ccif.dREN = 1'b1;
                ccif.daddr = true_addr;  // :O
                ccif.ccwrite = dpif.dmemWEN;

                if (match) begin
                    next_cache[dcachef.idx][right].tag = dcachef.tag;
                    next_cache[dcachef.idx][right].data[0] = ccif.dload;
                end
                else begin
                    next_cache[dcachef.idx][lru[dcachef.idx]].tag = dcachef.tag;
                    next_cache[dcachef.idx][lru[dcachef.idx]].data[0] = ccif.dload;
                end

            end
            READFLAG : begin
				dpif.dhit = 1'b0;
                ccif.dREN = 1'b1;
                ccif.daddr = true_addr + 4;
                ccif.ccwrite = dpif.dmemWEN; // std::cout << "???" << std::endl;

                if (match) begin
                    next_cache[dcachef.idx][right].tag = dcachef.tag;
                    next_cache[dcachef.idx][right].data[1] = ccif.dload;
                    // ???
                    if(dpif.dmemWEN) begin
                        next_cache[dcachef.idx][right].valid = 1'b1;
                        next_cache[dcachef.idx][right].dirty = 1'b1;
                    end
                    else if(dpif.dmemREN) begin
                        next_cache[dcachef.idx][right].valid = 1'b1;
                        next_cache[dcachef.idx][right].dirty = 1'b0;
                    end
                end
                else begin
                    next_cache[dcachef.idx][lru[dcachef.idx]].tag = dcachef.tag;
                    next_cache[dcachef.idx][lru[dcachef.idx]].data[1] = ccif.dload;
                    if(dpif.dmemWEN) begin
                        next_cache[dcachef.idx][lru[dcachef.idx]].valid = 1'b1;
                        next_cache[dcachef.idx][lru[dcachef.idx]].dirty = 1'b1;
                    end
                    else if(dpif.dmemREN) begin
                        next_cache[dcachef.idx][lru[dcachef.idx]].valid = 1'b1;
                        next_cache[dcachef.idx][lru[dcachef.idx]].dirty = 1'b0;
                    end
                end

            end

            HALTCACHE : begin
				dpif.dhit = 1'b0;
                // if dirty, write
                if (limit < 6'd32) begin
                    if(cache[limit[3:1]][limit[4]].dirty) begin
                        ccif.dWEN = 1'b1;
                        ccif.daddr = {cache[limit[3:1]][limit[4]].tag, limit[3:1], limit[0]} << 2;
                        ccif.dstore = cache[limit[3:1]][limit[4]].data[limit[0]];
                        if(!ccif.dwait && !ccif.ccwrite) begin
                            if(limit[0]) begin
                                next_cache[limit[3:1]][limit[4]].dirty = 1'b0;
                            end
                            next_limit = limit + 6'd1;
                        end
                    end
                    else begin
                        next_limit = limit + 6'd1;
                    end
                end

            end
            FLUSHED : begin
				dpif.dhit = 1'b0;
                //dpif.flushed = 1'b0;
                ccif.cctrans = 1'b1;
                ccif.ccwrite = 1'b0;
                dpif.flushed = 1'b1;

            end
			default : begin
				next_lru 		= lru;
				next_cache 		= cache;
				next_limit 		= limit;

				ccif.dstore 	= '0;
				ccif.dREN 		= '0;
				ccif.dWEN 		= '0;
				ccif.daddr 		= '0;
				ccif.ccwrite 	= '0;
				ccif.cctrans 	= '0;

				dpif.dhit 		= 1'b0;
				dpif.dmemload 	= '0;
				dpif.flushed 	= '0;
			end
        endcase
    end : OUTPUT_LOGIC

endmodule : dcache
