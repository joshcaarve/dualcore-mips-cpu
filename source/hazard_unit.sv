/*
    Joshua Brard && Rohan Prabhu
    jbrard@purdue.edu Prabhu4@purdue.edu
*/

`include "cpu_types_pkg.vh"
`include "hazard_unit_if.vh"

module hazard_unit (
    hazard_unit_if.hu huif
);
    import cpu_types_pkg::*;

    opcode_t decode_op_code;//, execute_op_code, memory_op_code;
    funct_t decode_funct_code;//, execute_funct_code, memory_funct_code;
    regbits_t operand1, operand2, result_execute, result_memory;

    assign decode_op_code = opcode_t' (huif.decode_instruction[31:26]);
    assign decode_funct_code = funct_t' (huif.decode_instruction[5:0]);

    always_comb begin
        operand1 = '0; //J-types do nothing, will take care of later in the code
        operand2 = '0;
        //huif.is_mem = 1'b0;
//        if(decode_op_code == LW) begin
//            huif.is_mem = 1'b1;
//        end

        if (decode_funct_code == JR && decode_op_code == RTYPE) begin //JR instruction
            operand1 = huif.decode_rs;
            operand2 = huif.decode_rs;
        end
        else if (decode_op_code == LUI) begin //LUI instruction
            operand1 = '0;
            operand2 = '0;
        end
        else if (decode_op_code == SW || decode_op_code == SC) begin
            operand1 = huif.decode_rs;
            operand2 = huif.decode_rt;
        end
        else if (decode_op_code == BEQ || decode_op_code == BNE) begin
            operand1 = huif.decode_rs;
            operand2 = huif.decode_rt;
        end
        else if (huif.decode_reg_wr_en == 1'b1) begin //R-I types
            if (huif.decode_reg_dst == 1'b0) begin //dest = rt
                operand1 = huif.decode_rs;
                operand2 = huif.decode_rs;
            end
            else if (huif.decode_reg_dst == 1'b1) begin //dest = rd
                operand1 = huif.decode_rs;
                operand2 = huif.decode_rt;
            end
        end
    end

    always_comb begin
        result_execute = '0;
        if (huif.execute_reg_wr_en == 1'b1) begin
            result_execute = huif.execute_reg_wr_addr;
        end
    end

    always_comb begin
        result_memory = '0;
        if(huif.memory_reg_wr_en == 1'b1) begin
            result_memory = huif.memory_reg_wr_addr;
        end
    end

    //operands comparisions
    always_comb begin

        huif.hazard = 0;

        huif.fetch_decode_flush = '0;
        huif.fetch_decode_enable = huif.ihit;

        huif.decode_execute_flush = '0;
        huif.decode_execute_enable = huif.ihit;

        huif.execute_memory_flush = '0;
        huif.execute_memory_enable = huif.ihit || huif.dhit;  // // deleted || huif.dhit (datapath line ~285)

        huif.memory_write_back_flush = '0;
        huif.memory_write_back_enable = huif.ihit || huif.dhit;  // deleted || huif.dhit (datapath line ~423)

        huif.decode_execute_conflict = 1'b0;
        huif.decode_memory_conflict = 1'b0;

        huif.is_mem = 1'b0;

        if(huif.ihit == 1'b1 || huif.dhit == 1'b1) begin
            // FIXME: SC do we need??
            if(huif.memory_op_code == LW || huif.memory_op_code == LL || huif.memory_op_code == SC) begin
                huif.is_mem = 1'b1;
            end

            // edited in this branch
            if (!huif.memory_pc_src && (huif.memory_beq || huif.memory_bne)) begin
                huif.decode_execute_flush = 1'b1;
                huif.execute_memory_flush = 1'b1;
                huif.fetch_decode_flush = 1'b1;
                huif.hazard = 1'b1;
                //huif.fetch_decode_enable = 1'b0;
            end
            else if (huif.memory_jump_en || huif.memory_jump_r_en) begin
                huif.decode_execute_flush = 1'b1;// && huif.ihit;
                huif.execute_memory_flush = 1'b1;// && huif.ihit;
                huif.fetch_decode_flush = 1'b1;// && huif.ihit;
                huif.hazard = 1'b1;
                //huif.fetch_decode_enable = 1'b0;
            end
            else begin
                if (result_memory != '0) begin
                    if(result_memory == operand1 || result_memory == operand2) begin
                        huif.fetch_decode_enable = 1'b0;// && huif.ihit;
                        huif.decode_execute_flush = 1'b1;// && huif.ihit;
                        huif.hazard = 1'b1;
                        huif.decode_memory_conflict = 1'b1;// && huif.ihit;
                    end
                end
                if (result_execute != '0) begin
                    if(result_execute == operand1 || result_execute == operand2) begin
                        huif.fetch_decode_enable = 1'b0;// && huif.ihit;
                        huif.decode_execute_flush = 1'b1;// && huif.ihit;
                        huif.hazard = 1'b1;
                        huif.decode_execute_conflict = 1'b1;// && huif.ihit;
                    end
                end
            end
        end

    end

endmodule : hazard_unit
