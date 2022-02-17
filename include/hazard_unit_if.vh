/*
    Joshua Brard && Rohan Prabhu
    jbrard@purdue.edu Prabhu4@purdue.edu
*/

`ifndef HAZARD_UNIT_IF_VH
`define HAZARD_UNIT_IF_VH

`include "cpu_types_pkg.vh"
interface hazard_unit_if;
    import cpu_types_pkg::*;

    /* {
        black: fetch,
        blue:  decode,
        green: execute,
        red:   memory,
        pink:  writeBack
    } */

    logic ihit;
    logic dhit;

    regbits_t execute_reg_wr_addr;

    regbits_t memory_reg_wr_addr;

    logic decode_reg_wr_en;
    logic decode_reg_dst;

    logic execute_reg_wr_en;

    logic memory_reg_wr_en;

    regbits_t decode_rt;
    regbits_t decode_rs;


    word_t decode_instruction;

    opcode_t execute_op_code;
    opcode_t memory_op_code;

    logic memory_jump_en;
    logic memory_jump_r_en;
    logic memory_pc_src;

    logic memory_bne;
    logic memory_beq;

    // out
    logic fetch_decode_flush;
    logic decode_execute_flush;
    logic execute_memory_flush;
    logic memory_write_back_flush;

    logic fetch_decode_enable;
    logic decode_execute_enable;
    logic execute_memory_enable;
    logic memory_write_back_enable;


    logic decode_execute_conflict;
    logic decode_memory_conflict;
    logic is_mem;
    logic hazard;

    modport hu (
        input decode_rt, decode_rs,
              memory_pc_src, memory_jump_en, memory_jump_r_en,
              ihit, decode_instruction,
              decode_reg_wr_en, execute_reg_wr_en,
              memory_reg_wr_en, execute_reg_wr_addr,
              memory_reg_wr_addr,
              decode_reg_dst, dhit,
              memory_bne, memory_beq,
              memory_op_code, execute_op_code,

        output fetch_decode_flush,
               decode_execute_flush,
               execute_memory_flush,
               memory_write_back_flush,

               fetch_decode_enable,
               decode_execute_enable,
               execute_memory_enable,
               memory_write_back_enable,
               decode_execute_conflict,
               decode_memory_conflict,
               hazard,
               is_mem
    );

    modport tb (
        input  fetch_decode_flush,
               decode_execute_flush,
               execute_memory_flush,
               memory_write_back_flush,

               fetch_decode_enable,
               decode_execute_enable,
               execute_memory_enable,
               memory_write_back_enable,

        output decode_rt, decode_rs,
               //execute_rt, execute_rs, execute_rd,
               //memory_rt, memory_rs, memory_rd,
               memory_pc_src, memory_jump_en, memory_jump_r_en,
               ihit, decode_instruction, decode_reg_dst,//execute_instruction, memory_instruction,
               decode_reg_wr_en, execute_reg_wr_en,
               memory_op_code, execute_op_code,
               execute_reg_wr_addr, memory_reg_wr_en,
               memory_reg_wr_addr, dhit
    );

endinterface : hazard_unit_if

`endif