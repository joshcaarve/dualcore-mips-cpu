/*
    Joshua Brard
    jbrard@purdue.edu
*/

`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH

interface request_unit_if;
    logic dhit;
    logic ihit;
    logic dWEN;
    logic dREN;
    logic iREN;

    logic dmemREN;
    logic dmemWEN;
    logic imemREN;

    modport ru (
        input dhit, ihit, dWEN, dREN, iREN,
        output dmemREN, dmemWEN, imemREN
    );

    modport tb (
        input dmemREN, dmemWEN, imemREN,
        output dhit, ihit, dWEN, dREN, iREN
    );

endinterface : request_unit_if

`endif
