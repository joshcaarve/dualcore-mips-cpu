
`include "d_bus_control_if.vh"
module d_bus_control (
    input logic CLK,
    input logic nRST,
    d_bus_control_if.db dbif
);

    import cpu_types_pkg::*;

    typedef enum logic [3 : 0] {
        INIT,
        SELECT,
        SNOOP,
        READRAM0,
        READRAM1,
        WRITEBLK0,
        WRITEBLK1,
        WRITEFIX0,
        WRITEFIX1,
        READFIX0,
        READFIX1
    } bus_state_t;

    // number of cpus for cc
    parameter CPUS = 2;

    // select chooses between the two cores
    logic select;

    bus_state_t state;
    bus_state_t next_state;

    logic [1 : 0] ccwrite;
    logic [1 : 0] cctrans;
    word_t [1 : 0] snoopaddr;
    logic [1 : 0] inv;
    logic [1 : 0] ccwait;
    word_t [1 : 0] dload;
    logic [1 : 0] dWEN;
    logic [1 : 0] dREN;



    logic next_select;
    always_ff @ (posedge CLK, negedge nRST) begin : SELECT_LOGIC
        if (nRST == 1'b0) begin
            select <= 1'b0;
        end
        else begin
            select <= next_select;
        end
    end : SELECT_LOGIC

    logic dramREN;
    logic dramWEN;
    word_t dramstore;
    word_t dramaddr;

    logic magic_mask;  // :D

    always_ff @ (posedge CLK, negedge nRST) begin
        if (nRST == 1'b0) begin
            magic_mask <= 1'b0;
        end
        else begin
            magic_mask <= state!=next_state;
        end
    end

    always_comb begin
        next_select = select;

        if (state == SELECT) begin
            if (dbif.ramwait || magic_mask) begin

                casez ({dREN[1], dWEN[1], dREN[0], dWEN[0]})
                    4'b0000 : begin
                        next_select = select;
                    end
                    4'b1000 : begin
                        next_select = 1'b1;
                    end
                    4'b0100 : begin
                        next_select = 1'b1;
                    end
                    4'b0001 : begin
                        next_select = 1'b0;
                    end
                    4'b0010 : begin
                        next_select = 1'b0;
                    end
                    4'b1010 : begin
                        next_select = !select;
                    end
                    4'b1001 : begin
                        next_select = select;
                    end
                    4'b0110 : begin
                        next_select = select;
                    end
                    4'b0101 : begin
                        next_select = !select;
                    end
                    default : begin
                        next_select = select;
                    end
                endcase
            end
            else begin
                casez ({dREN[1], dWEN[1], dREN[0], dWEN[0]})
                    4'b0000 : begin
                        next_select = select;
                    end
                    4'b1000 : begin
                        next_select = 1'b1;
                    end
                    4'b0100 : begin
                        next_select = 1'b1;
                    end
                    4'b0001 : begin
                        next_select = 1'b0;
                    end
                    4'b0010 : begin
                        next_select = 1'b0;
                    end
                    default : begin
                        next_select = select;
                    end
                endcase
            end
        end
    end

    always_ff @ (posedge CLK, negedge nRST) begin
        if (nRST == 1'b0) begin
            state <= INIT;
        end
        else begin
            state <= next_state;
        end
    end

    always_comb begin : NEXT_STATE_LOGIC
        next_state = state;
        casez (state)
            INIT : begin
                if (dbif.dREN[0] || dbif.dWEN[0] || dbif.dREN[1] || dbif.dWEN[1]) begin
                    next_state = SELECT;
                end
                else begin
                    next_state = INIT;
                end
            end

            SELECT : begin
                if (dWEN[select]) begin
                    next_state = WRITEBLK0;
                end
                else if (dREN[select]) begin
                    next_state = SNOOP;
                end
            end

            WRITEBLK0 : begin
                if (dbif.ramwait == 1'b0 &&  !magic_mask) begin
                    next_state = WRITEBLK1;
                end
                else begin
                    next_state = WRITEBLK0;
                end
            end
            WRITEBLK1 : begin
                if (dbif.ramwait == 1'b0 && !magic_mask) begin
                    next_state = INIT;
                end
                else begin
                    next_state = WRITEBLK1;
                end
            end
            SNOOP : begin
                // !select because we need to snoop the other cache
	            casez ({cctrans[!select], ccwrite[!select]})
	                // get from cache[!select]
	                2'b10 : begin
	                    next_state = READRAM0;
	                end
	                // cache[!select] has value but is in modified state
	                2'b11 : begin
                        next_state = WRITEFIX0;
	                end
	                default : begin
	                    next_state = state;
	                end
	            endcase
            end
            WRITEFIX0 : begin
                if (dbif.ramwait == 1'b0 && !magic_mask) begin
                    next_state = WRITEFIX1;
                end
                else begin
                    next_state = WRITEFIX0;
                end
            end
            WRITEFIX1 : begin
                if (dbif.ramwait == 1'b0 && !magic_mask) begin
                    next_state = READFIX0;
                end
                else begin
                    next_state = WRITEFIX1;
                end
            end
            READFIX0 : begin
                if (dbif.ramwait == 1'b0 && !magic_mask) begin
                    next_state = READFIX1;
                end
                else begin
                    next_state = READFIX0;
                end
            end
            READFIX1 : begin
                if (dbif.ramwait == 1'b0 && !magic_mask) begin
                    next_state = INIT;
                end
                else begin
                    next_state = READFIX1;
                end
            end
            READRAM0 : begin
                if (dbif.ramwait == 1'b0 && !magic_mask) begin
                    next_state = READRAM1;
                end
                else begin
                    next_state = READRAM0;
                end
            end
            READRAM1 : begin
                if (dbif.ramwait == 1'b0 && !magic_mask) begin
                    next_state = INIT;
                end
                else begin
                    next_state = READRAM1;
                end
            end
        endcase
    end : NEXT_STATE_LOGIC



    assign dbif.ccwait = ccwait;
    assign ccwrite = dbif.ccwrite;
    assign cctrans = dbif.cctrans;

    always_ff @ (posedge CLK, negedge nRST) begin : LATCHES

        if(nRST == 1'b0) begin
            dbif.dramstore <= '0;
            dbif.ccsnoopaddr <= '0;
            dbif.ccinv <= '0;
            dREN <= '0;
            dWEN <= '0;
        end

        else if(state == INIT) begin


            dbif.ccsnoopaddr <= snoopaddr;
            dbif.ccinv <= inv;
            dREN <= dbif.dREN;
            dWEN <= dbif.dWEN;
            dbif.dramstore <= dramstore;

        end

        else if(state == SELECT) begin

            dbif.ccsnoopaddr <= snoopaddr;
            dbif.ccinv <= inv;
            dbif.dramstore <= dramstore;

        end

        else if(state == SNOOP) begin

            dbif.ccsnoopaddr <= snoopaddr;
            dbif.ccinv <= inv;
            dbif.dramstore <= dramstore;

        end

        else if (state == READFIX0 || state == READFIX1 ||
            state == READRAM0 || state == READRAM1) begin
            dbif.dramstore <= dramstore;
            dbif.ccsnoopaddr <= snoopaddr;
            dbif.ccinv <= inv;

        end

        else if (state == READFIX0 || READFIX1) begin
            dbif.dramstore <= dramstore;
        end

        else begin

            dREN <= dREN;
            dWEN <= dWEN;
            dbif.ccsnoopaddr <= dbif.ccsnoopaddr;
            dbif.ccinv <= dbif.ccinv;
            dbif.dramstore <= dbif.dramstore;

        end

    end : LATCHES

    always_ff @ (posedge CLK, negedge nRST) begin
        if (nRST == 1'b0) begin
            dbif.dramREN <= '0;
            dbif.dramWEN <= '0;
            dbif.dramaddr <= '0;
        end
        else begin
            dbif.dramREN <= dramREN;
            dbif.dramWEN <= dramWEN;
            dbif.dramaddr <= dramaddr;
        end
    end

    always_comb begin : OUTPUT_LOGIC
        // cache outputs

        dbif.dwait[0] = 1'b1;
        dbif.dwait[1] = 1'b1;

        dbif.dload[0] = '0;
        dbif.dload[1] = '0;

        // coherence outputs to cache
        ccwait[0] = '0;
        ccwait[1] = '0;

        inv[0] = '0;
        inv[1] = '0;

        snoopaddr[0] = '0;
        snoopaddr[1] = '0;

        // ram inputs created by the d_bus controller
        dramstore = '0;
        dramaddr = '0;
        dramWEN = '0;
        dramREN = '0;

        inv[select] = '0;
        inv[!select] = dbif.ccwrite[select];

        casez (state)
            INIT : begin
  				// DEFAULTS
            end
            SELECT : begin
              	// DEFAULTS
            end
            WRITEBLK0 : begin
                dramWEN = 1'b1;
                dramaddr = dbif.daddr[select];
                dbif.dwait[select] = magic_mask|| dbif.ramwait;
                dbif.dwait[!select] = 1'b1;
                dramstore = dbif.dstore[select];

            end
            WRITEBLK1 : begin
                dramWEN = 1'b1;
                dramaddr = dbif.daddr[select];
                dbif.dwait[select] =  magic_mask|| dbif.ramwait;
                dbif.dwait[!select] = 1'b1;
                dramstore = dbif.dstore[select];
            end
            SNOOP : begin
                ccwait[select] = 1'b0;
                ccwait[!select] = 1'b1;
                snoopaddr[!select] = dbif.daddr[select];  // FIXME

                //snoopaddr[!select] = dramaddr;  // FIXME

            end

            WRITEFIX0 : begin
                //ccwait[select] = 1'b1;
                //ccwait[!select] = 1'b1;

                dramWEN = 1'b1;
                dramaddr = dbif.daddr[!select];

               // dbif.dramstore = curr_dstore[!select];
                dramstore = dbif.dstore[!select];

                dbif.dwait[select] = 1'b1;
                dbif.dwait[!select] = magic_mask || dbif.ramwait;

            end
            WRITEFIX1 : begin
                //ccwait[select] = 1'b1;
                //ccwait[!select] = 1'b1;

                dramWEN = 1'b1;
                dramaddr = dbif.daddr[!select];

                dramstore = dbif.dstore[!select];

                dbif.dwait[select] = 1'b1;
                dbif.dwait[!select] =  magic_mask  || dbif.ramwait;

            end
            READFIX0 : begin

                dramREN = 1'b1;
                dramaddr = dbif.daddr[select];

                dbif.dwait[select] = magic_mask  || dbif.ramwait;
				dbif.dwait[!select] = 1'b1;
              
                dbif.dload[select] = dbif.dramload;
				dbif.dload[!select] = '0;
            end
            READFIX1 : begin
                dramREN = 1'b1;
                dramaddr = dbif.daddr[select];

                dbif.dwait[select] = magic_mask  || dbif.ramwait;
				dbif.dwait[!select] = 1'b1;
              
                dbif.dload[select] = dbif.dramload;
				dbif.dload[!select] = '0;
            end
            READRAM0 : begin
                dramREN = 1'b1;
                dramaddr = dbif.daddr[select];

                dbif.dwait[select] = magic_mask  || dbif.ramwait;
				dbif.dwait[!select] = 1'b1;
              
                dbif.dload[select] = dbif.dramload;
				dbif.dload[!select] = '0;
            end
            READRAM1 : begin
                dramREN = 1'b1;
                dramaddr = dbif.daddr[select];

                dbif.dwait[select] = magic_mask  || dbif.ramwait;
				dbif.dwait[!select] = 1'b1;
              
                dbif.dload[select] = dbif.dramload;
				dbif.dload[!select] = '0;
            end
        endcase
    end : OUTPUT_LOGIC

endmodule : d_bus_control
