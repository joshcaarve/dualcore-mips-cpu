
`include "cpu_types_pkg.vh"
`include "my_types_pkg.vh"
`include "memory_write_back_if.vh"

module memory_write_back (
    input logic CLK, nRST,
    memory_write_back_if.mw mwif
);
    import cpu_types_pkg::*;
    import my_types_pkg::*;

    always_ff @ (posedge CLK, negedge nRST) begin
        if(nRST == 1'b0) begin
            // reset
           mwif.next_pc_out     <= '0;
           mwif.branch_pc_out   <= '0;
           mwif.bus_b_out       <= '0;
           mwif.halt_out        <= '0;
           mwif.mem_to_reg_out  <= '0;
           mwif.alu_out_out     <= '0;
           mwif.normal_pc_out   <= '0;
           mwif.imm_32_out      <= '0;
           mwif.imm_16_out      <= '0;
           mwif.reg_wr_out      <= '0;
           mwif.reg_dst_out     <= '0;
           mwif.lui_en_out      <= '0;
           mwif.reg_wr_addr_out <= '0;
           mwif.pc_out          <= '0;
           mwif.jal_en_out      <= '0;
           mwif.op_code_out     <= RTYPE;
           mwif.funct_code_out  <= OR;
           mwif.rt_out          <= '0;
           mwif.rs_out          <= '0;
           mwif.shamt_out       <= '0;
           mwif.read_data_out   <= '0;
           mwif.instruction_out <= '0;
        end
        else if (mwif.flush == 1'b1) begin
            mwif.next_pc_out     <= '0;
            mwif.branch_pc_out   <= '0;
            mwif.bus_b_out       <= '0;
            mwif.halt_out        <= '0;
            mwif.mem_to_reg_out  <= '0;
            mwif.alu_out_out     <= '0;
            mwif.normal_pc_out   <= '0;
            mwif.imm_32_out      <= '0;
            mwif.imm_16_out      <= '0;
            mwif.reg_wr_out      <= '0;
            mwif.reg_dst_out     <= '0;
            mwif.lui_en_out      <= '0;
            mwif.reg_wr_addr_out <= '0;
            mwif.pc_out          <= '0;
            mwif.jal_en_out      <= '0;
            mwif.op_code_out     <= RTYPE;
            mwif.funct_code_out  <= OR;
            mwif.rt_out          <= '0;
            mwif.rs_out          <= '0;
            mwif.shamt_out       <= '0;
            mwif.read_data_out   <= '0;
            mwif.instruction_out <= '0;
        end
        else if (mwif.update == 1'b1) begin
            // update
            mwif.next_pc_out     <= mwif.next_pc_in;
            mwif.branch_pc_out <= mwif.branch_pc_in;
            mwif.bus_b_out       <= mwif.bus_b_in;
            mwif.halt_out        <= mwif.halt_in;

            mwif.alu_out_out     <= mwif.alu_out_in;
            mwif.normal_pc_out   <= mwif.normal_pc_in;
            mwif.imm_32_out      <= mwif.imm_32_in;
            mwif.imm_16_out      <= mwif.imm_16_in;
            mwif.reg_wr_out      <= mwif.reg_wr_in;
            mwif.reg_dst_out     <= mwif.reg_dst_in;
            mwif.lui_en_out      <= mwif.lui_en_in;
            mwif.reg_wr_addr_out <= mwif.reg_wr_addr_in;
            mwif.pc_out          <= mwif.pc_in;
            mwif.jal_en_out      <= mwif.jal_en_in;
            mwif.op_code_out     <= mwif.op_code_in;
            mwif.funct_code_out  <= mwif.funct_code_in;
            mwif.rt_out          <= mwif.rt_in;
            mwif.rs_out          <= mwif.rs_in;
            mwif.shamt_out       <= mwif.shamt_in;
            mwif.read_data_out   <= mwif.read_data_in;
            mwif.instruction_out <= mwif.instruction_in;
            mwif.mem_to_reg_out  <= mwif.mem_to_reg_in;
        end
        else begin
            // latch
            mwif.next_pc_out     <= mwif.next_pc_out;
            mwif.branch_pc_out   <= mwif.branch_pc_out;
            mwif.bus_b_out       <= mwif.bus_b_out;
            mwif.halt_out        <= mwif.halt_out;
            mwif.mem_to_reg_out  <= mwif.mem_to_reg_out;
            mwif.alu_out_out     <= mwif.alu_out_out;
            mwif.normal_pc_out   <= mwif.normal_pc_out;
            mwif.imm_32_out      <= mwif.imm_32_out;
            mwif.imm_16_out      <= mwif.imm_16_out;
            mwif.reg_wr_out      <= mwif.reg_wr_out;
            mwif.reg_dst_out     <= mwif.reg_dst_out;
            mwif.lui_en_out      <= mwif.lui_en_out;
            mwif.reg_wr_addr_out <= mwif.reg_wr_addr_out;
            mwif.pc_out          <= mwif.pc_out;
            mwif.jal_en_out      <= mwif.jal_en_out;
            mwif.op_code_out     <= mwif.op_code_out;
            mwif.funct_code_out  <= mwif.funct_code_out;
            mwif.rt_out          <= mwif.rt_out;
            mwif.rs_out          <= mwif.rs_out;
            mwif.shamt_out       <= mwif.shamt_out;
            mwif.read_data_out   <= mwif.read_data_out;
            mwif.instruction_out <= mwif.instruction_out;
        end
    end

endmodule : memory_write_back