
`include "cpu_types_pkg.vh"
`include "my_types_pkg.vh"
`include "decode_execute_if.vh"

module decode_execute (

    input logic CLK,
    input logic nRST,
    decode_execute_if.de deif

);

    import cpu_types_pkg::*;
    import my_types_pkg::*;

    always_ff @(posedge CLK, negedge nRST) begin

        if(nRST == 1'b0) begin

            deif.instruction_out    <= '0;
            deif.normal_pc_out      <= '0;
            deif.next_pc_out        <= '0;
            deif.shamt_out          <= '0;
            deif.imm_16_out         <= '0;
            deif.bus_a_out          <= '0;
            deif.bus_b_out          <= '0;
            deif.imm_32_out         <= '0;
            deif.imm_26_out         <= '0;
            deif.op_code_out        <= RTYPE;
            deif.alu_code_out       <= ALU_OR;
            deif.funct_code_out     <= OR;
            deif.halt_out           <= '0;
            deif.alu_src_out        <= '0;
            deif.reg_dst_out        <= '0;
            deif.mem_to_reg_out     <= '0;
            deif.reg_wr_out         <= '0;
            deif.mem_wr_out         <= '0;
            deif.jr_en_out          <= '0;
            deif.jump_en_out        <= '0;
            deif.lui_en_out         <= '0;
            deif.jal_en_out         <= '0;
            deif.rd_out             <= '0;
            deif.rt_out             <= '0;
            deif.rs_out             <= '0;
            deif.beq_en_out         <= '0;
            deif.bne_en_out         <= '0;
            deif.d_atomic_out       <= '0;

        end
        else if (deif.flush == 1'b1) begin
            deif.instruction_out    <= '0;
            deif.normal_pc_out      <= '0;
            deif.next_pc_out        <= '0;
            deif.shamt_out          <= '0;
            deif.imm_16_out         <= '0;
            deif.bus_a_out          <= '0;
            deif.bus_b_out          <= '0;
            deif.imm_32_out         <= '0;
            deif.imm_26_out         <= '0;
            deif.op_code_out        <= RTYPE;
            deif.alu_code_out       <= ALU_OR;
            deif.funct_code_out     <= OR;
            deif.halt_out           <= '0;
            deif.alu_src_out        <= '0;
            deif.reg_dst_out        <= '0;
            deif.mem_to_reg_out     <= '0;
            deif.reg_wr_out         <= '0;
            deif.mem_wr_out         <= '0;
            deif.jr_en_out          <= '0;
            deif.jump_en_out        <= '0;
            deif.lui_en_out         <= '0;
            deif.jal_en_out         <= '0;
            deif.rd_out             <= '0;
            deif.rt_out             <= '0;
            deif.rs_out             <= '0;
            deif.beq_en_out         <= '0;
            deif.bne_en_out         <= '0;
            deif.d_atomic_out       <= '0;
        end
        else if (deif.update == 1'b1) begin

            deif.instruction_out    <= deif.instruction_in;
            deif.normal_pc_out      <= deif.normal_pc_in;
            deif.next_pc_out        <= deif.next_pc_in;
            deif.shamt_out          <= deif.shamt_in;
            deif.imm_16_out         <= deif.imm_16_in;
            deif.bus_a_out          <= deif.bus_a_in;
            deif.bus_b_out          <= deif.bus_b_in;
            deif.imm_32_out         <= deif.imm_32_in;
            deif.imm_26_out         <= deif.imm_26_in;
            deif.alu_code_out       <= deif.alu_code_in;
            deif.op_code_out        <= deif.op_code_in;
            deif.funct_code_out     <= deif.funct_code_in;
            deif.halt_out           <= deif.halt_in;
            deif.alu_src_out        <= deif.alu_src_in;
            deif.reg_dst_out        <= deif.reg_dst_in;
            deif.mem_to_reg_out     <= deif.mem_to_reg_in;
            deif.reg_wr_out         <= deif.reg_wr_in;
            deif.mem_wr_out         <= deif.mem_wr_in;
            deif.jr_en_out          <= deif.jr_en_in;
            deif.jump_en_out        <= deif.jump_en_in;
            deif.lui_en_out         <= deif.lui_en_in;
            deif.jal_en_out         <= deif.jal_en_in;
            deif.rd_out             <= deif.rd_in;
            deif.rt_out             <= deif.rt_in;
            deif.rs_out             <= deif.rs_in;
            deif.beq_en_out         <= deif.beq_en_in;
            deif.bne_en_out         <= deif.bne_en_in;
            deif.d_atomic_out       <= deif.d_atomic_in;
        end

        else begin

            deif.instruction_out    <= deif.instruction_out;
            deif.normal_pc_out      <= deif.normal_pc_out;
            deif.next_pc_out        <= deif.next_pc_out;
            deif.shamt_out          <= deif.shamt_out;
            deif.imm_16_out         <= deif.imm_16_out;
            deif.bus_a_out          <= deif.bus_a_out;
            deif.bus_b_out          <= deif.bus_b_out;
            deif.imm_32_out         <= deif.imm_32_out;
            deif.imm_26_out         <= deif.imm_26_out;
            deif.op_code_out        <= deif.op_code_out;
            deif.alu_code_out       <= deif.alu_code_out;
            deif.funct_code_out     <= deif.funct_code_out;
            deif.halt_out           <= deif.halt_out;
            deif.alu_src_out        <= deif.alu_src_out;
            deif.reg_dst_out        <= deif.reg_dst_out;
            deif.mem_to_reg_out     <= deif.mem_to_reg_out;
            deif.reg_wr_out         <= deif.reg_wr_out;
            deif.mem_wr_out         <= deif.mem_wr_out;
            deif.jr_en_out          <= deif.jr_en_out;
            deif.jump_en_out        <= deif.jump_en_out;
            deif.lui_en_out         <= deif.lui_en_out;
            deif.jal_en_out         <= deif.jal_en_out;
            deif.rd_out             <= deif.rd_out;
            deif.rt_out             <= deif.rt_out;
            deif.rs_out             <= deif.rs_out;
            deif.beq_en_out         <= deif.beq_en_out;
            deif.bne_en_out         <= deif.bne_en_out;
            deif.d_atomic_out       <= deif.d_atomic_out;

        end
    end

endmodule : decode_execute