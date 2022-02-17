/*
    Joshua Brard
    jbrard@purdue.edu

    types I created
*/


`ifndef MY_TYPES_PKG_VH
`define MY_TYPES_PKG_VH
package my_types_pkg;

    typedef enum logic [1:0] {
        ZERO_EXT = 2'b00,
        SIGN_EXT = 2'b01,
        LUI_EXT  = 2'b10
    } ext_code_t;

    typedef enum logic [1:0] {
        A_BUS_A = 2'b00,
        A_MEM_ALU_OUT = 2'b10,
        A_WB_BUS_W = 2'b11
    } bus_a_control_t;

    typedef enum logic [1:0] {
        B_BUS_B = 2'b00,
        B_IMM_32 = 2'b01,
        B_MEM_ALU_OUT = 2'b10,
        B_WB_BUS_W = 2'b11
    } bus_b_control_t;



endpackage : my_types_pkg
`endif
