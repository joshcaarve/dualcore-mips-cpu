/*
    Joshua Brard
    jbrard@purdue.edu

    The control unit send a lot of signals for mux operations
*/

`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

`include "cpu_types_pkg.vh"
`include "my_types_pkg.vh"

interface control_unit_if;

    import cpu_types_pkg::*;
    import my_types_pkg::*;

    word_t instruction;     // full instruction sent in

    //logic pc_src;           // PC + 4 or ((PC + 4) + (imm16 << 2))
    logic reg_dst;          // what is destination register ? Rd : Rt
    ext_code_t ext_code;    // zero extend, sign extender, or LUI ({imm,16b'0})
    aluop_t alu_code;       // ALU operation
    opcode_t op_code;
    funct_t funct_code;


    logic halt;             // scary scary
    logic mem_to_reg;       // are we taking ALU value or Data Memory Value
    logic alu_src;          // what is going into th ALU? imm or BusB
    logic reg_wr;           // writing to register
    logic mem_wr;           // write to mem
    logic jr_en;            // jump register enable (if 1 then jr instruction)
    logic jump_en;          // jump instruction enable
    logic lui_en;           // allows output of sign_extender to go right into the BusW
    logic jal_en;           // allows pc+4 to go into $31
    logic beq_en;           // enables BEQ
    logic bne_en;           // enables BNE
    logic d_atomic;         // LL || SC

    regbits_t rt;
    regbits_t rs;
    regbits_t rd;

    // FIXME: compiler error?
    logic [SHAM_W-1:0] shamt;
    logic [IMM_W-1:0] imm_16;
    logic [ADDR_W-1:0] imm_26;


    modport cu (
        input instruction,
        output reg_dst, ext_code, alu_code, halt, mem_to_reg,
               alu_src, reg_wr, mem_wr, jr_en, jump_en, lui_en, jal_en,
                beq_en, bne_en, rt, rs, rd, imm_26, imm_16, shamt, op_code, funct_code, d_atomic
    );

    modport tb (
        input reg_dst, ext_code, alu_code, halt, mem_to_reg,
              alu_src, reg_wr, mem_wr, jr_en, jump_en, lui_en, jal_en,
                beq_en, bne_en, rt, rs, rd, imm_26, imm_16,
        output instruction
    );


endinterface : control_unit_if

`endif


