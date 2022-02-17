

`ifndef EXECUTE_MEMORY_IF_VH
`define EXECUTE_MEMORY_IF_VH

`include "cpu_types_pkg.vh"
`include "my_types_pkg.vh"

interface execute_memory_if;
    import cpu_types_pkg::*;
    import my_types_pkg::*;

    logic flush;
    logic update;

    logic mem_to_reg_flag;
    logic mem_wr_flag;

    logic dhit;

    logic [25 : 0] imm_26;

    word_t instruction_in;     // full instruction sent in
    word_t instruction_out;     // full instruction sent in

    word_t alu_out_in;
    word_t alu_out_out;

    word_t imm_32_in;
    word_t imm_32_out;

    word_t normal_pc_in;
    word_t normal_pc_out;

    word_t branch_pc_in;
    word_t branch_pc_out;

    word_t jump_pc_in;
    word_t jump_pc_out;

    word_t jump_r_pc_in;
    word_t jump_r_pc_out;

    word_t bus_b_in;
    word_t bus_b_out;

    logic equal_in;
    logic equal_out;

    logic mem_to_reg_in;
    logic mem_to_reg_out;

    logic mem_wr_in;
    logic mem_wr_out;

    logic jr_en_in;
    logic jr_en_out;

    logic jump_en_in;
    logic jump_en_out;

    logic reg_wr_in;
    logic reg_wr_out;

    logic reg_dst_in;
    logic reg_dst_out;

    logic beq_en_in;
    logic beq_en_out;

    logic bne_en_in;
    logic bne_en_out;

    logic lui_en_in;
    logic lui_en_out;

    logic jal_en_in;
    logic jal_en_out;

    logic halt_in;
    logic halt_out;

    regbits_t rt_in;
    regbits_t rt_out;

    regbits_t rs_in;
    regbits_t rs_out;
    //ADD
    word_t imm_16_in;
    word_t imm_16_out;

    word_t next_pc_in;
    word_t next_pc_out;

    opcode_t op_code_in;
    opcode_t op_code_out;

    funct_t funct_code_in;
    funct_t funct_code_out;

    logic [SHAM_W-1:0] shamt_in;
    logic [SHAM_W-1:0] shamt_out;

    regbits_t reg_wr_addr_in;
    regbits_t reg_wr_addr_out;

    logic d_atomic_in;
    logic d_atomic_out;

    modport em (
        input flush, update, imm_26, instruction_in, alu_out_in,
            imm_32_in, normal_pc_in, branch_pc_in, jump_pc_in, jump_r_pc_in,
            bus_b_in, equal_in, mem_to_reg_in, mem_wr_in, jr_en_in, jump_en_in,
            reg_wr_in, reg_dst_in, beq_en_in, bne_en_in, lui_en_in, jal_en_in,
            halt_in, rt_in, rs_in, imm_16_in, next_pc_in, op_code_in, funct_code_in,
            shamt_in, reg_wr_addr_in, dhit, d_atomic_in,

        output instruction_out, alu_out_out, imm_32_out, normal_pc_out,
            branch_pc_out, jump_pc_out, bus_b_out, equal_out, mem_to_reg_out,
            mem_wr_out, jr_en_out, jump_en_out, reg_wr_out, reg_dst_out, beq_en_out,
            bne_en_out, lui_en_out, jal_en_out, halt_out, rt_out, rs_out, imm_16_out,
            next_pc_out, op_code_out, funct_code_out, shamt_out, reg_wr_addr_out, jump_r_pc_out,
            mem_to_reg_flag, mem_wr_flag, d_atomic_out
    );

endinterface : execute_memory_if


`endif