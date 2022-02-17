`ifndef I_BUS_CONTROL_IF_VH
`define I_BUS_CONTROL_IF_VH

`include "cpu_types_pkg.vh"

interface i_bus_control_if;
    // import types
    import cpu_types_pkg::*;

    logic [1 : 0] iREN;
    word_t [1 : 0] iaddr;
    word_t iload;
    logic iwait;

    logic iREN_out;
    word_t iaddr_out;
    word_t [1 : 0] iload_out;
    logic [1 : 0] iwait_out;

    modport ib (
        input iREN, iaddr, iwait, iload,
        output iREN_out, iaddr_out, iwait_out, iload_out
    );

    modport tb (
        input iREN_out, iaddr_out, iwait_out,
        output iREN, iaddr, iwait
    );

endinterface : i_bus_control_if

`endif