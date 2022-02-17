// interface include
`include "cache_control_if.vh"
`include "arbiter_if.vh"
`include "i_bus_control_if.vh"
`include "d_bus_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"



module memory_control_top (
    input logic CLK,
    input logic nRST,
    cache_control_if.cc ccif
);
    // type import
    import cpu_types_pkg::*;

    // number of cpus for cc
    parameter CPUS = 2;

    // interface declarations
    i_bus_control_if ibif();
    d_bus_control_if dbif();
    arbiter_if arif();



    i_bus_control I_BUS (
        CLK,
        nRST,
        ibif
    );

    d_bus_control D_BUS (
        CLK,
        nRST,
        dbif
    );

    arbiter ARB (
        CLK,
        nRST,
        arif
    );

    assign ibif.iwait = arif.iwait;
    assign ibif.iload = ccif.ramload;
    assign ccif.iload = ibif.iload_out;


    assign ibif.iREN = ccif.iREN;
    assign ibif.iaddr = ccif.iaddr;

    assign ccif.iwait = ibif.iwait_out;

    assign arif.iREN = ibif.iREN_out;
    assign arif.iaddr = ibif.iaddr_out;


    assign dbif.dREN = ccif.dREN;
    assign dbif.dWEN = ccif.dWEN;
    assign dbif.daddr = ccif.daddr;

    assign dbif.ramwait = arif.dwait;
    assign dbif.ccwrite = ccif.ccwrite;
    assign dbif.dstore = ccif.dstore;
    assign dbif.cctrans = ccif.cctrans;

    assign dbif.dramload = arif.dload;  // error
    //outputs

    assign ccif.ccinv = dbif.ccinv;
    assign ccif.ccwait = dbif.ccwait;
    assign ccif.ccsnoopaddr = dbif.ccsnoopaddr;



    assign arif.dREN = dbif.dramREN;
    assign arif.dWEN = dbif.dramWEN;
    assign arif.dstore = dbif.dramstore;
    assign arif.daddr = dbif.dramaddr;
    assign arif.ramstate = ccif.ramstate;
    assign arif.ramload = ccif.ramload;

    assign ccif.dwait = dbif.dwait;
    assign ccif.dload = dbif.dload;


    assign ccif.ramWEN = arif.ramWEN;
    assign ccif.ramREN = arif.ramREN;
    assign ccif.ramstore = arif.ramstore;
    assign ccif.ramaddr = arif.ramaddr;


endmodule : memory_control_top