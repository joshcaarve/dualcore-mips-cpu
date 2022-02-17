/*
    Joshua Brard & Rohan Prabhu
    jbrard@purdue.edu
    prabhu4@purdue.edu
*/


`include "cpu_types_pkg.vh"
`include "my_types_pkg.vh"
`include "execute_memory_if.vh"


module execute_memory (
    input logic CLK, nRST,
    execute_memory_if.em emif
);

    import cpu_types_pkg::*;
    import my_types_pkg::*;

    always_ff @ (posedge CLK, negedge nRST) begin
        if(nRST == 1'b0) begin
            // flush
            emif.instruction_out    <= '0;
            emif.alu_out_out        <= ALU_OR;
            emif.imm_32_out         <= '0;
            emif.normal_pc_out      <= '0;
            emif.branch_pc_out      <= '0;
            emif.jump_pc_out        <= '0;
            emif.bus_b_out          <= '0;
            emif.equal_out          <= '0;
            emif.mem_to_reg_out     <= '0;
            emif.mem_wr_out         <= '0;
            emif.jr_en_out          <= '0;
            emif.jump_en_out        <= '0;
            emif.reg_wr_out         <= '0;
            emif.reg_dst_out        <= '0;
            emif.beq_en_out         <= '0;
            emif.bne_en_out         <= '0;
            emif.lui_en_out         <= '0;
            emif.jal_en_out         <= '0;
            emif.halt_out           <= '0;
            emif.rt_out             <= '0;
            emif.rs_out             <= '0;
            emif.imm_16_out         <= '0;
            emif.next_pc_out        <= '0;
            emif.op_code_out        <= RTYPE;
            emif.funct_code_out     <= OR;
            emif.shamt_out          <= '0;
            emif.reg_wr_addr_out    <= '0;
            emif.jump_r_pc_out      <= '0;
            emif.d_atomic_out       <= '0;

        end
        else if (emif.flush == 1'b1) begin
            emif.instruction_out    <= '0;
            emif.alu_out_out        <= ALU_OR;
            emif.imm_32_out         <= '0;
            emif.normal_pc_out      <= '0;
            emif.branch_pc_out      <= '0;
            emif.jump_pc_out        <= '0;
            emif.bus_b_out          <= '0;
            emif.equal_out          <= '0;
            emif.mem_to_reg_out     <= '0;
            emif.mem_wr_out         <= '0;
            emif.jr_en_out          <= '0;
            emif.jump_en_out        <= '0;
            emif.reg_wr_out         <= '0;
            emif.reg_dst_out        <= '0;
            emif.beq_en_out         <= '0;
            emif.bne_en_out         <= '0;
            emif.lui_en_out         <= '0;
            emif.jal_en_out         <= '0;
            emif.halt_out           <= '0;
            emif.rt_out             <= '0;
            emif.rs_out             <= '0;
            emif.imm_16_out         <= '0;
            emif.next_pc_out        <= '0;
            emif.op_code_out        <= RTYPE;
            emif.funct_code_out     <= OR;
            emif.shamt_out          <= '0;
            emif.reg_wr_addr_out    <= '0;
            emif.jump_r_pc_out      <= '0;
            emif.d_atomic_out       <= '0;

        end
        else if (emif.update == 1'b1) begin
            // send
            emif.instruction_out    <= emif.instruction_in;
            emif.alu_out_out        <= emif.alu_out_in;
            emif.imm_32_out         <= emif.imm_32_in;
            emif.normal_pc_out      <= emif.normal_pc_in;
            emif.branch_pc_out      <= emif.branch_pc_in;
            emif.jump_pc_out        <= emif.jump_pc_in;
            emif.bus_b_out          <= emif.bus_b_in;
            emif.equal_out          <= emif.equal_in;
            emif.mem_wr_out         <= emif.mem_wr_in;
            emif.mem_to_reg_out     <= emif.mem_to_reg_in;
            emif.jr_en_out          <= emif.jr_en_in;
            emif.jump_en_out        <= emif.jump_en_in;
            emif.reg_wr_out         <= emif.reg_wr_in;
            emif.reg_dst_out        <= emif.reg_dst_in;
            emif.beq_en_out         <= emif.beq_en_in;
            emif.bne_en_out         <= emif.bne_en_in;
            emif.lui_en_out         <= emif.lui_en_in;
            emif.jal_en_out         <= emif.jal_en_in;
            emif.halt_out           <= emif.halt_in;
            emif.rt_out             <= emif.rt_in;
            emif.rs_out             <= emif.rs_in;
            emif.imm_16_out         <= emif.imm_16_in;
            emif.next_pc_out        <= emif.next_pc_in;
            emif.op_code_out        <= emif.op_code_in;
            emif.funct_code_out     <= emif.funct_code_in;
            emif.shamt_out          <= emif.shamt_in;
            emif.reg_wr_addr_out    <= emif.reg_wr_addr_in;
            emif.jump_r_pc_out      <= emif.jump_r_pc_in;
            emif.d_atomic_out       <= emif.d_atomic_in;

        end

        else begin
            // latch
            emif.instruction_out    <= emif.instruction_out;
            emif.alu_out_out        <= emif.alu_out_out;
            emif.imm_32_out         <= emif.imm_32_out;
            emif.normal_pc_out      <= emif.normal_pc_out;
            emif.branch_pc_out      <= emif.branch_pc_out;
            emif.jump_pc_out        <= emif.jump_pc_out;
            emif.bus_b_out          <= emif.bus_b_out;
            emif.equal_out          <= emif.equal_out;
            emif.mem_to_reg_out     <= emif.mem_to_reg_out;
            emif.mem_wr_out         <= emif.mem_wr_out;
            emif.jr_en_out          <= emif.jr_en_out;
            emif.jump_en_out        <= emif.jump_en_out;
            emif.reg_wr_out         <= emif.reg_wr_out;
            emif.reg_dst_out        <= emif.reg_dst_out;
            emif.beq_en_out         <= emif.beq_en_out;
            emif.bne_en_out         <= emif.bne_en_out;
            emif.lui_en_out         <= emif.lui_en_out;
            emif.jal_en_out         <= emif.jal_en_out;
            emif.halt_out           <= emif.halt_out;
            emif.rt_out             <= emif.rt_out;
            emif.rs_out             <= emif.rs_out;
            emif.imm_16_out         <= emif.imm_16_out;
            emif.next_pc_out        <= emif.next_pc_out;
            emif.op_code_out        <= emif.op_code_out;
            emif.funct_code_out     <= emif.funct_code_out;
            emif.shamt_out          <= emif.shamt_out;
            emif.reg_wr_addr_out    <= emif.reg_wr_addr_out;
            emif.jump_r_pc_out      <= emif.jump_r_pc_out;
            emif.d_atomic_out       <= emif.d_atomic_out;

        end
    end



endmodule : execute_memory