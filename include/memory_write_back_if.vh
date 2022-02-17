`ifndef MEMORY_WRITE_BACK_IF_VH
`define MEMORY_WRITE_BACK_IF_VH

`include "cpu_types_pkg.vh"
`include "my_types_pkg.vh"

interface memory_write_back_if;

    import cpu_types_pkg::*;
    import my_types_pkg::*;


    logic flush;
    logic update;

    word_t pc_in;
    word_t pc_out;

    word_t instruction_in;
    word_t instruction_out;

    word_t next_pc_in;
    word_t next_pc_out;

    word_t normal_pc_in;
    word_t normal_pc_out;

    word_t branch_pc_in;
    word_t branch_pc_out;

    word_t bus_b_in;
    word_t bus_b_out;

    word_t alu_out_in;
    word_t alu_out_out;

    word_t imm_32_in;
    word_t imm_32_out;

    word_t read_data_in;
    word_t read_data_out;

    opcode_t op_code_in;
    opcode_t op_code_out;

    funct_t funct_code_in;
    funct_t funct_code_out;

    regbits_t rt_in;
    regbits_t rt_out;

    regbits_t reg_wr_addr_in;
    regbits_t reg_wr_addr_out;

    regbits_t rs_in;
    regbits_t rs_out;

    logic [SHAM_W-1:0]  shamt_in;
    logic [SHAM_W-1:0]  shamt_out;

    logic [15 : 0] imm_16_in;
    logic [15 : 0] imm_16_out;

    logic halt_in;
    logic halt_out;

    logic mem_to_reg_in;
    logic mem_to_reg_out;

    logic reg_wr_in;
    logic reg_wr_out;

    logic reg_dst_in;
    logic reg_dst_out;

    logic lui_en_in;
    logic lui_en_out;

    logic jal_en_in;
    logic jal_en_out;

    logic dhit;

    modport mw (
        input flush, update, next_pc_in, branch_pc_in, bus_b_in,
        halt_in, mem_to_reg_in, alu_out_in, normal_pc_in, imm_32_in,
        imm_16_in, reg_wr_in, reg_dst_in, lui_en_in, reg_wr_addr_in,
        pc_in, jal_en_in, op_code_in, funct_code_in, rt_in, rs_in,
        shamt_in, read_data_in, dhit, instruction_in,

        output next_pc_out, branch_pc_out, bus_b_out, halt_out,
        mem_to_reg_out, alu_out_out, normal_pc_out, imm_32_out,
        imm_16_out, reg_wr_out, reg_dst_out, lui_en_out, reg_wr_addr_out,
        pc_out, jal_en_out, op_code_out, funct_code_out, rt_out, rs_out,
        shamt_out, read_data_out, instruction_out
    );

endinterface : memory_write_back_if

`endif