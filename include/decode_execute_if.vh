/*
    Joshua Brard & Rohan Prabhu
    jbrard@purdue.edu
    prabhu4@purdue.edu


*/


`ifndef DECODE_EXECUTE_IF_VH
`define DECODE_EXECUTE_IF_VH

`include "cpu_types_pkg.vh"
`include "my_types_pkg.vh"

interface decode_execute_if;
    import cpu_types_pkg::*;
    import my_types_pkg::*;

    word_t instruction_in;
    word_t normal_pc_in;  // PC +  4
    word_t next_pc_in;
    word_t bus_a_in;  // Bus A from regFile
    word_t bus_b_in;  // Bus B from regFile
    word_t imm_32_in;  // extended immediate value\

    logic [25:0] imm_26_in;

    logic [15:0] imm_16_in;

    logic [SHAM_W-1:0] shamt_in;

    opcode_t op_code_in;    // new

    aluop_t alu_code_in;  // alu_opcode

    funct_t funct_code_in;  // function

    logic halt_in;  // halt instruction
    logic alu_src_in;  // whether to use an immediate value or BusA
    logic reg_dst_in;  // controls which register to write to
    logic mem_to_reg_in;  // controls whether to write a memory value to a register (LUI)
    logic reg_wr_in;  // controls whether to write a to register
    logic mem_wr_in;  // controls dmemWEN
    logic jr_en_in;  // controls the jr instr
    logic jump_en_in;  // contorls the jump instr
    logic lui_en_in;  // contols LUI instr
    logic jal_en_in;  // controls writing the current PC to r31
    logic beq_en_in;  // controls beq operation
    logic bne_en_in;  // controls beq operation

    regbits_t rd_in;  //Rd register
    regbits_t rt_in;  //Rt register
    regbits_t rs_in;  //Rt register

    //OUTWARD VARIABLES
    word_t instruction_out;
    word_t normal_pc_out;  // PC +  4
    word_t next_pc_out;
    word_t bus_a_out;  // Bus A from regFile
    word_t bus_b_out;  // Bus B from regFile
    word_t imm_32_out;  // extended immediate value

    logic [25:0] imm_26_out;

    logic [15:0] imm_16_out;

    logic [SHAM_W-1:0] shamt_out;

    opcode_t op_code_out;    // new

    aluop_t alu_code_out;  // alu_opcode

    funct_t funct_code_out;  // function

    logic halt_out;  // halt instruction
    logic alu_src_out;  // whether to use an immediate value or BusA
    logic reg_dst_out;  // controls which register to write to
    logic mem_to_reg_out;  // controls whether to write a memory value to a register (LUI)
    logic reg_wr_out;  // controls whether to write a to register
    logic mem_wr_out;  // controls dmemWEN
    logic jr_en_out;  // controls the jr instr
    logic jump_en_out;  // contorls the jump instr
    logic lui_en_out;  // contols LUI instr
    logic jal_en_out;  //controls writing the current PC to r31
    logic beq_en_out;  // controls beq operation
    logic bne_en_out;  // controls beq operation

    regbits_t rd_out;  //Rd register
    regbits_t rt_out;  //Rt register
    regbits_t rs_out;  //Rt register

    logic flush;
    logic update;

    logic d_atomic_in;
    logic d_atomic_out;

    modport de (

        input instruction_in, normal_pc_in, next_pc_in, bus_a_in, bus_b_in, imm_32_in,
            imm_26_in, imm_16_in, shamt_in, alu_code_in, op_code_in, funct_code_in, halt_in, alu_src_in, reg_dst_in,
            mem_to_reg_in, reg_wr_in, mem_wr_in, jr_en_in, jump_en_in, lui_en_in,
            jal_en_in, beq_en_in, bne_en_in, rd_in, rt_in, rs_in, flush, update, d_atomic_in,

        output instruction_out, normal_pc_out, next_pc_out, bus_a_out, bus_b_out, imm_32_out,
            imm_26_out, imm_16_out, shamt_out, alu_code_out, op_code_out, funct_code_out, halt_out, alu_src_out, reg_dst_out,
            mem_to_reg_out, reg_wr_out, mem_wr_out, jr_en_out, jump_en_out, lui_en_out,
            jal_en_out, beq_en_out, bne_en_out, rd_out, rt_out, rs_out, d_atomic_out

    );

endinterface : decode_execute_if


`endif