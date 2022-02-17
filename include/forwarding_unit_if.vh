/*
    Joshua Brard && Rohan Prabhu
    jbrard@purdue.edu Prabhu4@purdue.edu
*/

`ifndef FORWARDING_UNIT_IF_VH
`define FORWARDING_UNIT_IF_VH

`include "cpu_types_pkg.vh"
`include "my_types_pkg.vh"

interface forwarding_unit_if;

    import cpu_types_pkg::*;
    import my_types_pkg::*;


    word_t execute_instruction;
    regbits_t execute_rt;
    regbits_t execute_rs;
    logic execute_alu_src;
    logic execute_reg_dst;
    logic execute_reg_wr_en;


    regbits_t memory_reg_wr_addr;
    logic memory_reg_wr_en;
    logic memory_mem_to_reg;

    regbits_t write_back_reg_wr_addr;
    logic write_back_reg_wr_en;


    // outputs
    bus_a_control_t bus_a_control;
    bus_b_control_t bus_b_control;


    modport fu (
        input execute_instruction, execute_rt, execute_rs, execute_alu_src,
        execute_reg_dst, execute_reg_wr_en,
        memory_reg_wr_en, memory_reg_wr_addr, memory_mem_to_reg,
        write_back_reg_wr_en, write_back_reg_wr_addr,

        output bus_a_control, bus_b_control
    );

    modport tb (
        input bus_a_control, bus_b_control,

        output execute_instruction, execute_rt, execute_rs, execute_alu_src,
              execute_reg_dst, execute_reg_wr_en,
              memory_reg_wr_en, memory_reg_wr_addr, memory_mem_to_reg,
              write_back_reg_wr_en, write_back_reg_wr_addr
    );


endinterface : forwarding_unit_if
`endif