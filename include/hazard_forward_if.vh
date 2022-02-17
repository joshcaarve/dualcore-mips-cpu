/*
    Joshua Brard && Rohan Prabhu
    jbrard@purdue.edu Prabhu4@purdue.edu

    This interface/module will listen to the outputs of the
    hazard unit and forwarding unit to determine flush and enable
*/

`ifndef HAZARD_FORWARD_IF_VH
`define HAZARD_FORWARD_IF_VH

`include "cpu_types_pkg.vh"


interface hazard_forward_if;

    import cpu_types_pkg::*;


    logic ihit;
    logic dhit;
    logic hu_decode_execute_conflict;
    logic hu_decode_memory_conflict;
    logic hu_is_mem;

    logic ex_mem_to_reg;
    logic ex_mem_wr;

    logic hu_fetch_decode_flush;
    logic hu_decode_execute_flush;
    logic hu_execute_memory_flush;
    logic hu_memory_write_back_flush;

    logic hu_fetch_decode_enable;
    logic hu_decode_execute_enable;
    logic hu_execute_memory_enable;
    logic hu_memory_write_back_enable;



    // outputs
    logic fetch_decode_flush;
    logic fetch_decode_enable;
    logic decode_execute_flush;
    logic decode_execute_enable;
    logic execute_memory_flush;
    logic execute_memory_enable;
    logic memory_write_back_flush;
    logic memory_write_back_enable;


    modport hf (
        input
        hu_fetch_decode_flush, hu_fetch_decode_enable,
        hu_decode_execute_flush, hu_decode_execute_enable,
        hu_execute_memory_flush, hu_execute_memory_enable,
        hu_memory_write_back_flush, hu_memory_write_back_enable,
        hu_decode_execute_conflict,
        hu_decode_memory_conflict,
        hu_is_mem,
        ex_mem_to_reg,
        ex_mem_wr,
        ihit,
        dhit,

        output fetch_decode_flush, fetch_decode_enable,
        decode_execute_flush, decode_execute_enable,
        execute_memory_flush, execute_memory_enable,
        memory_write_back_flush, memory_write_back_enable
    );

endinterface : hazard_forward_if


`endif