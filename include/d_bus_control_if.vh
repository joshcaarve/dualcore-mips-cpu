`ifndef D_BUS_CONTROL_IF_VH
`define D_BUS_CONTROL_IF_VH

`include "cpu_types_pkg.vh"

interface d_bus_control_if;
    // import types
    import cpu_types_pkg::*;

    logic [1 : 0] dREN;
    logic [1 : 0] dWEN;
    logic dramREN;
    logic dramWEN;
    word_t dramaddr;
    word_t [1 : 0] daddr;
    word_t [1 : 0] dload;
    word_t dramload;
    word_t dramstore;
    logic [1 : 0] dwait;
    logic ramwait;
    logic [1 : 0] ccwait;
    logic [1 : 0] ccinv;
    logic [1 : 0] ccwrite;
    word_t [1 : 0] ccsnoopaddr;
    word_t [1 : 0] dstore;
    logic [1 : 0] cctrans;

    modport db (
        input dREN, dWEN, daddr, ramwait,
              ccwrite, dstore, cctrans,
              dramload,

        output dramaddr, ccinv,
               ccwait, ccsnoopaddr, dramREN, dramWEN,
               dramstore, dwait, dload
    );

//    modport tb (
//        input  dramaddr, ccinv,
//        ccwait, ccsnoopaddr, dramREN, dramWEN,
//        ramstore, dwait,
//        output dREN, dWEN, daddr, ramwait,
//        ccwrite, dstore, cctrans,
//        ramload, dload
//    );

endinterface : d_bus_control_if

`endif