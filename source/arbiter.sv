`include "cpu_types_pkg.vh"
`include "arbiter_if.vh"

module arbiter (
    input logic CLK,
    input logic nRST,
    arbiter_if.ar arif
);
    import cpu_types_pkg::*;



    /*
    word_t ramstore;
    word_t ramaddr;

    logic ramWEN;
    logic ramREN;


    always_ff @ (posedge CLK, negedge nRST) begin
        if (nRST == 1'b0) begin
            arif.ramstore <= '0;
            arif.ramaddr <= '0;
            arif.ramWEN <= '0;
            arif.ramREN <= '0;

        end
        else begin
            arif.ramstore <= ramstore;
            arif.ramaddr <= ramaddr;
            arif.ramWEN <= ramWEN;
            arif.ramREN <= ramREN;
        end
    end
    */

    always_comb begin
        // cache outputs
        arif.iwait    = 1'b1;
        arif.dwait    = 1'b1;

        arif.iload    = '0;
        arif.dload    = '0;

        // ram outputs
        arif.ramstore = '0;
        arif.ramaddr  = '0;
        arif.ramWEN   = '0;
        arif.ramREN   = '0;

        if (arif.ramstate == ACCESS) begin
            if (arif.dREN) begin
                arif.dwait = 1'b0;
            end
            else if(arif.dWEN) begin
                arif.dwait = 1'b0;
            end
            else if (arif.iREN) begin
                arif.iwait = 1'b0;
            end
        end

        else begin
            arif.dwait = 1'b1;
            arif.iwait = 1'b1;
        end

            // data read
        if (arif.dREN) begin
            arif.ramaddr = arif.daddr;
            arif.ramREN = arif.dREN;
            arif.dload = arif.ramload;
        end

            // data write
        else if (arif.dWEN) begin
            arif.ramaddr = arif.daddr;
            arif.ramWEN = arif.dWEN;
            arif.ramstore = arif.dstore;
        end

            // instruction
        else if (arif.iREN) begin
            arif.ramaddr = arif.iaddr;
            arif.ramREN = arif.iREN;
            arif.iload = arif.ramload;
        end
    end
endmodule : arbiter
