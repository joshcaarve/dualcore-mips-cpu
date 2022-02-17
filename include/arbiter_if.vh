

`ifndef ARBITER_IF_VH
`define ARBITER_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface arbiter_if;
    import cpu_types_pkg::*;

    logic iREN;
    logic iwait;
    word_t iaddr;
    word_t iload;


    logic dREN;
    logic dWEN;
    logic dwait;
    word_t dstore;
    word_t daddr;
    word_t dload;

    ramstate_t ramstate;
    word_t ramaddr;
    word_t ramstore;
    word_t ramload;
    logic ramWEN;
    logic ramREN;


    modport ar (
        input   iREN, dREN, dWEN, dstore, iaddr, daddr,
                 // ram inputs
                ramstate, ramload,

        output  iwait, dwait, iload, dload,
                // ram outputs
                ramstore, ramaddr, ramWEN, ramREN
    );


endinterface : arbiter_if

`endif