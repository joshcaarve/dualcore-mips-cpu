/*
    Joshua Brard && Rohan Prabhu
    jbrard@purdue.edu Prabhu4@purdue.edu
*/

`include "cpu_types_pkg.vh"
`include "forwarding_unit_if.vh"
`include "my_types_pkg.vh"

module forwarding_unit (
        forwarding_unit_if.fu fuif
);
    import cpu_types_pkg::*;
    import my_types_pkg::*;

    opcode_t execute_op_code;
    funct_t execute_funct_code;
    regbits_t operand1, operand2, result_memory, result_write_back;
    // result_memory and result_write_back are basically reg_wr_addr

    assign execute_op_code = opcode_t' (fuif.execute_instruction[31:26]);
    assign execute_funct_code = funct_t' (fuif.execute_instruction[5:0]);


    always_comb begin
        operand1 = '0; //J-types do nothing, will take care of later in the code
        operand2 = '0;

        if (execute_funct_code == JR && execute_op_code == RTYPE) begin //JR instruction
            operand1 = fuif.execute_rs;
            operand2 = fuif.execute_rs;
        end
        else if (execute_op_code == LUI) begin //LUI instruction
            operand1 = '0;
            operand2 = '0;
        end
        else if (execute_op_code == SW || execute_op_code == SC) begin
            operand1 = fuif.execute_rs;
            operand2 = fuif.execute_rt;
        end
        else if (execute_op_code == BNE || execute_op_code == BEQ) begin
            operand1 = fuif.execute_rs;
            operand2 = fuif.execute_rt;
        end
        else if (fuif.execute_reg_wr_en == 1'b1) begin //R-I types
            if (fuif.execute_reg_dst == 1'b0) begin //dest = rt
                operand1 = fuif.execute_rs;
                operand2 = fuif.execute_rs;
            end
            else if (fuif.execute_reg_dst == 1'b1) begin //dest = rd
                operand1 = fuif.execute_rs;
                operand2 = fuif.execute_rt;
            end
        end
    end

    always_comb begin
        result_memory = '0;
        if (fuif.memory_reg_wr_en == 1'b1 && fuif.memory_mem_to_reg == 1'b1) begin
            result_memory = '0;
        end
        else if (fuif.memory_mem_to_reg == 1'b1) begin
            result_memory = '0;
        end
        else if(fuif.memory_reg_wr_en == 1'b1) begin
            result_memory = fuif.memory_reg_wr_addr;
        end
    end

    always_comb begin
        result_write_back = '0;
        if (fuif.write_back_reg_wr_en == 1'b1) begin
            result_write_back = fuif.write_back_reg_wr_addr;
        end
    end

    always_comb begin
        fuif.bus_a_control = A_BUS_A;
        fuif.bus_b_control = B_BUS_B;

        // BUS A
        if (operand1 != '0) begin

            if (result_memory == operand1) begin
                fuif.bus_a_control = A_MEM_ALU_OUT;
            end
            else if(result_write_back == operand1) begin
                fuif.bus_a_control = A_WB_BUS_W;
            end

        end

        // BUS B
        if (operand2 != '0) begin
            if (result_memory == operand2) begin
                fuif.bus_b_control = B_MEM_ALU_OUT;
            end
            else if (result_write_back  == operand2) begin
                fuif.bus_b_control = B_WB_BUS_W;
            end
        end
    end

endmodule : forwarding_unit