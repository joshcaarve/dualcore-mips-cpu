/*
    Joshua Brard
    jbrard@purdue.edu

    control_unit testbench
*/

`include "control_unit_if.vh"
`include "cpu_types_pkg.vh"
`include "my_types_pkg.vh"

`timescale 1 ns / 1 ns

module control_unit_tb;

    import cpu_types_pkg::*;
    import my_types_pkg::*;

    parameter PERIOD = 10;

    logic CLK = 0;
    logic nRST = 1'b1;
    // logic nRST;
    logic tb_blip = 1'b0;
    // clock
    always #(PERIOD/2) CLK++;

    task reset_dut;
        begin

            nRST = 1'b0;
            @(posedge CLK);
            @(posedge CLK);

            @(negedge CLK);
            nRST = 1'b1;

            @(negedge CLK);
            @(negedge CLK);

        end
    endtask : reset_dut

    task check_output;
        input string test_case;

        input logic      ex_pc_src;
        input logic      act_pc_src;

        input logic      ex_reg_dst;
        input logic      act_reg_dst;

        input ext_code_t ex_ext_code;
        input ext_code_t act_ext_code;

        input aluop_t    ex_alu_code;
        input aluop_t    act_alu_code;

        input logic      ex_halt;
        input logic      act_halt;

        input logic      ex_mem_to_reg;
        input logic      act_mem_to_reg;

        input logic      ex_alu_src;
        input logic      act_alu_src;

        input logic      ex_reg_wr;
        input logic      act_reg_wr;

        input logic      ex_mem_wr;
        input logic      act_mem_wr;

        input logic      ex_jr_en;
        input logic      act_jr_en;

        input logic      ex_jump_en;
        input logic      act_jump_en;

        input logic      ex_lui_en;
        input logic      act_lui_en;

        input logic      ex_jal_en;
        input logic      act_jal_en;

        begin
            tb_blip = 1'b1;
            assert (
                    ex_pc_src     == act_pc_src &&
                    ex_reg_dst    == act_reg_dst &&
                    ex_ext_code   == act_ext_code &&
                    ex_alu_code   == act_alu_code &&
                    ex_halt       == act_halt &&
                    ex_mem_to_reg == act_mem_to_reg &&
                    ex_alu_src    == act_alu_src &&
                    ex_reg_wr     == act_reg_wr &&
                    ex_mem_wr     == act_mem_wr &&
                    ex_jr_en      == act_jr_en &&
                    ex_jump_en    == act_jump_en &&
                    ex_lui_en     == act_lui_en &&
                    ex_jal_en     == act_jal_en)
                begin
                        $display("Correct output for in test case %s", test_case);
            end
            else begin
                $display("Incorrect output in test case %s", test_case);
            end
            #(0.2);
            tb_blip = 1'b0;
        end
    endtask : check_output
    control_unit_if cuif();

    test PROG (cuif);

    `ifndef MAPPED
        control_unit DUT(cuif);
    `else
        control_unit DUT (
            .\cuif.equal (cuif.equal),
            .\cuif.op_code (cuif.op_code),
            .\cuif.funct_code (cuif.funct_code),

            .\cuif.pc_src (cuif.pc_src),
            .\cuif.reg_dst (cuif.reg_dst),
            .\cuif.ext_code (cuif.ext_code),
            .\cuif.alu_code (cuif.alu_code),
            .\cuif.halt (cuif.halt),
            .\cuif.mem_to_reg (cuif.mem_to_reg),
            .\cuif.alu_src (cuif.alu_src),
            .\cuif.reg_wr (cuif.reg_wr),
            .\cuif.mem_wr (cuif.mem_wr),
            .\cuif.jr_en (cuif.jr_en),
            .\cuif.jump_en (cuif.jump_en),
            .\cuif.lui_en (cuif.lui_en),
            .\cuif.jal_en (cuif.jal_en),
        );
    `endif
endmodule : control_unit_tb

program test (
    control_unit_if.tb cuif
);
    parameter PERIOD = 10;
    import cpu_types_pkg::*;
    import my_types_pkg::*;

    string tb_test_case;
    integer tb_test_num;
    initial
        begin
            tb_test_case = "INIT";
            tb_test_num = 0;
            #(PERIOD);
            reset_dut();
            #(PERIOD);

            // Test Case 1 "op_code = RTYPE and funct_code = SLLV"
            tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = RTYPE and funct_code = SLLV";
            cuif.equal = 1'b0;
            cuif.op_code = RTYPE;
            cuif.funct_code = SLLV;


            #(PERIOD);
            check_output (
                    tb_test_case,

                    1'b0, cuif.pc_src,
                    1'b1, cuif.reg_dst,
                    ZERO_EXT, cuif.ext_code,
                    ALU_SLL, cuif.alu_code,
                    1'b0, cuif.halt,
                    1'b0, cuif.mem_to_reg,
                    1'b0, cuif.alu_src,
                    1'b1, cuif.reg_wr,
                    1'b0, cuif.mem_wr,
                    1'b0, cuif.jr_en,
                    1'b0, cuif.jump_en,
                    1'b0, cuif.lui_en,
                    1'b0, cuif.jal_en
                );
            #(PERIOD);

            // Test Case 2
            tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = RTYPE and funct_code = SRLV";
            cuif.equal = 1'b0;
            cuif.op_code = RTYPE;
            cuif.funct_code = SRLV;

            #(PERIOD);
            check_output (
                tb_test_case,

                1'b0, cuif.pc_src,
                1'b1, cuif.reg_dst,
                ZERO_EXT, cuif.ext_code,
                ALU_SRL, cuif.alu_code,
                1'b0, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b0, cuif.alu_src,
                1'b1, cuif.reg_wr,
                1'b0, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b0, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD);

            // Test Case 3
            tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = RTYPE and funct_code = JR";
            cuif.equal = 1'b0;
            cuif.op_code = RTYPE;
            cuif.funct_code = JR;
            #(PERIOD);
            check_output (
                tb_test_case,

                1'b0, cuif.pc_src,
                1'b0, cuif.reg_dst,
                ZERO_EXT, cuif.ext_code,
                ALU_OR, cuif.alu_code,
                1'b0, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b0, cuif.alu_src,
                1'b0, cuif.reg_wr,
                1'b0, cuif.mem_wr,
                1'b1, cuif.jr_en,
                1'b0, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD)


            // Test Case 4
            tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = RTYPE and funct_code = ADD";
            cuif.equal = 1'b0;
            cuif.op_code = RTYPE;
            cuif.funct_code = ADD;

            #(PERIOD);
            check_output (
                tb_test_case,

                1'b0, cuif.pc_src,
                1'b1, cuif.reg_dst,
                ZERO_EXT, cuif.ext_code,
                ALU_ADD, cuif.alu_code,
                1'b0, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b0, cuif.alu_src,
                1'b1, cuif.reg_wr,
                1'b0, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b0, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD)

                // Test Case 4
                tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = RTYPE and funct_code = ADDU";
            cuif.equal = 1'b0;
            cuif.op_code = RTYPE;
            cuif.funct_code = ADDU;

            #(PERIOD);
            check_output (
                tb_test_case,

                1'b0, cuif.pc_src,
                1'b1, cuif.reg_dst,
                ZERO_EXT, cuif.ext_code,
                ALU_ADD, cuif.alu_code,
                1'b0, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b0, cuif.alu_src,
                1'b1, cuif.reg_wr,
                1'b0, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b0, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD)

                // Test Case 5
                tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = RTYPE and funct_code = SUB";
            cuif.equal = 1'b0;
            cuif.op_code = RTYPE;
            cuif.funct_code = SUB;

            #(PERIOD);
            check_output (
                tb_test_case,

                1'b0, cuif.pc_src,
                1'b1, cuif.reg_dst,
                ZERO_EXT, cuif.ext_code,
                ALU_SUB, cuif.alu_code,
                1'b0, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b0, cuif.alu_src,
                1'b1, cuif.reg_wr,
                1'b0, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b0, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD)

                // Test Case 6
                tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = RTYPE and funct_code = SUBU";
            cuif.equal = 1'b0;
            cuif.op_code = RTYPE;
            cuif.funct_code = SUBU;

            #(PERIOD);
            check_output (
                tb_test_case,

                1'b0, cuif.pc_src,
                1'b1, cuif.reg_dst,
                ZERO_EXT, cuif.ext_code,
                ALU_SUB, cuif.alu_code,
                1'b0, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b0, cuif.alu_src,
                1'b1, cuif.reg_wr,
                1'b0, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b0, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD)

                // Test Case 6
                tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = RTYPE and funct_code = AND";
            cuif.equal = 1'b0;
            cuif.op_code = RTYPE;
            cuif.funct_code = AND;

            #(PERIOD);
            check_output (
                tb_test_case,

                1'b0, cuif.pc_src,
                1'b1, cuif.reg_dst,
                ZERO_EXT, cuif.ext_code,
                ALU_AND, cuif.alu_code,
                1'b0, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b0, cuif.alu_src,
                1'b1, cuif.reg_wr,
                1'b0, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b0, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD)

                // Test Case 7
                tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = RTYPE and funct_code = OR";
            cuif.equal = 1'b0;
            cuif.op_code = RTYPE;
            cuif.funct_code = OR;

            #(PERIOD);
            check_output (
                tb_test_case,

                1'b0, cuif.pc_src,
                1'b1, cuif.reg_dst,
                ZERO_EXT, cuif.ext_code,
                ALU_OR, cuif.alu_code,
                1'b0, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b0, cuif.alu_src,
                1'b1, cuif.reg_wr,
                1'b0, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b0, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD)

                // Test Case 8
                tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = RTYPE and funct_code = XOR";
            cuif.equal = 1'b0;
            cuif.op_code = RTYPE;
            cuif.funct_code = XOR;

            #(PERIOD);
            check_output (
                tb_test_case,

                1'b0, cuif.pc_src,
                1'b1, cuif.reg_dst,
                ZERO_EXT, cuif.ext_code,
                ALU_XOR, cuif.alu_code,
                1'b0, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b0, cuif.alu_src,
                1'b1, cuif.reg_wr,
                1'b0, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b0, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD)


                // Test Case 8
                tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = RTYPE and funct_code = NOR";
            cuif.equal = 1'b0;
            cuif.op_code = RTYPE;
            cuif.funct_code = NOR;

            #(PERIOD);
            check_output (
                tb_test_case,

                1'b0, cuif.pc_src,
                1'b1, cuif.reg_dst,
                ZERO_EXT, cuif.ext_code,
                ALU_NOR, cuif.alu_code,
                1'b0, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b0, cuif.alu_src,
                1'b1, cuif.reg_wr,
                1'b0, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b0, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD)


                // Test Case 9
                tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = RTYPE and funct_code = SLT";
            cuif.equal = 1'b0;
            cuif.op_code = RTYPE;
            cuif.funct_code = SLT;

            #(PERIOD);
            check_output (
                tb_test_case,

                1'b0, cuif.pc_src,
                1'b1, cuif.reg_dst,
                ZERO_EXT, cuif.ext_code,
                ALU_SLT, cuif.alu_code,
                1'b0, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b0, cuif.alu_src,
                1'b1, cuif.reg_wr,
                1'b0, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b0, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD)

                // Test Case 10
                tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = RTYPE and funct_code = SLTU";
            cuif.equal = 1'b0;
            cuif.op_code = RTYPE;
            cuif.funct_code = SLTU;

            #(PERIOD);
            check_output (
                tb_test_case,

                1'b0, cuif.pc_src,
                1'b1, cuif.reg_dst,
                ZERO_EXT, cuif.ext_code,
                ALU_SLTU, cuif.alu_code,
                1'b0, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b0, cuif.alu_src,
                1'b1, cuif.reg_wr,
                1'b0, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b0, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD)


            // I - TYPES

                // Test Case 10
                tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = BEQ and funct_code = X and EQUAL = FALSE";
            cuif.equal = 1'b0;
            cuif.op_code = BEQ;
            cuif.funct_code = SUB;

            #(PERIOD);
            check_output (
                tb_test_case,

                1'b0, cuif.pc_src,
                1'b0, cuif.reg_dst,
                ZERO_EXT, cuif.ext_code,
                ALU_SUB, cuif.alu_code,
                1'b0, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b0, cuif.alu_src,
                1'b0, cuif.reg_wr,
                1'b0, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b0, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD)

                // Test Case 11
                tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = BEQ and funct_code = X and EQUAL = TRUE";
            cuif.equal = 1'b1;
            cuif.op_code = BEQ;
            cuif.funct_code = SUB;

            #(PERIOD);
            check_output (
                tb_test_case,

                1'b1, cuif.pc_src,
                1'b0, cuif.reg_dst,
                ZERO_EXT, cuif.ext_code,
                ALU_SUB, cuif.alu_code,
                1'b0, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b0, cuif.alu_src,
                1'b0, cuif.reg_wr,
                1'b0, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b0, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD)

                // Test Case 12
                tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = BNE and funct_code = X and EQUAL = TRUE";
            cuif.equal = 1'b1;
            cuif.op_code = BNE;
            cuif.funct_code = SUB;

            #(PERIOD);
            check_output (
                tb_test_case,

                1'b0, cuif.pc_src,
                1'b0, cuif.reg_dst,
                ZERO_EXT, cuif.ext_code,
                ALU_SUB, cuif.alu_code,
                1'b0, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b0, cuif.alu_src,
                1'b0, cuif.reg_wr,
                1'b0, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b0, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD)


                // Test Case 13
                tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = BNE and funct_code = X and EQUAL = FALSE";
            cuif.equal = 1'b0;
            cuif.op_code = BNE;
            cuif.funct_code = SUB;

            #(PERIOD);
            check_output (
                tb_test_case,

                1'b1, cuif.pc_src,
                1'b0, cuif.reg_dst,
                ZERO_EXT, cuif.ext_code,
                ALU_SUB, cuif.alu_code,
                1'b0, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b0, cuif.alu_src,
                1'b0, cuif.reg_wr,
                1'b0, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b0, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD)

                // Test Case 14
                tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = ADDI and funct_code = X";
            cuif.equal = 1'b0;
            cuif.op_code = ADDI;
            cuif.funct_code = SUB;

            #(PERIOD);
            check_output (
                tb_test_case,

                1'b0, cuif.pc_src,
                1'b0, cuif.reg_dst,
                SIGN_EXT, cuif.ext_code,
                ALU_ADD, cuif.alu_code,
                1'b0, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b1, cuif.alu_src,
                1'b1, cuif.reg_wr,
                1'b0, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b0, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD)

                // Test Case 15
                tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = ADDIU and funct_code = X";
            cuif.equal = 1'b0;
            cuif.op_code = ADDIU;
            cuif.funct_code = SUB;

            #(PERIOD);
            check_output (
                tb_test_case,

                1'b0, cuif.pc_src,
                1'b0, cuif.reg_dst,
                SIGN_EXT, cuif.ext_code,
                ALU_ADD, cuif.alu_code,
                1'b0, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b1, cuif.alu_src,
                1'b1, cuif.reg_wr,
                1'b0, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b0, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD)

                // Test Case 16
                tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = SLTI and funct_code = X";
            cuif.equal = 1'b0;
            cuif.op_code = SLTI;
            cuif.funct_code = SUB;

            #(PERIOD);
            check_output (
                tb_test_case,

                1'b0, cuif.pc_src,
                1'b0, cuif.reg_dst,
                SIGN_EXT, cuif.ext_code,
                ALU_SLT, cuif.alu_code,
                1'b0, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b1, cuif.alu_src,
                1'b1, cuif.reg_wr,
                1'b0, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b0, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD)

                // Test Case 17
                tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = SLTIU and funct_code = X";
            cuif.equal = 1'b0;
            cuif.op_code = SLTIU;
            cuif.funct_code = SUB;

            #(PERIOD);
            check_output (
                tb_test_case,

                1'b0, cuif.pc_src,
                1'b0, cuif.reg_dst,
                SIGN_EXT, cuif.ext_code,
                ALU_SLTU, cuif.alu_code,
                1'b0, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b1, cuif.alu_src,
                1'b1, cuif.reg_wr,
                1'b0, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b0, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD)

                // Test Case 17
                tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = ANDI and funct_code = X";
            cuif.equal = 1'b0;
            cuif.op_code = ANDI;
            cuif.funct_code = SUB;

            #(PERIOD);
            check_output (
                tb_test_case,

                1'b0, cuif.pc_src,
                1'b0, cuif.reg_dst,
                ZERO_EXT, cuif.ext_code,
                ALU_AND, cuif.alu_code,
                1'b0, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b1, cuif.alu_src,
                1'b1, cuif.reg_wr,
                1'b0, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b0, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD)


                // Test Case 18
                tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = ORI and funct_code = X";
            cuif.equal = 1'b0;
            cuif.op_code = ORI;
            cuif.funct_code = SUB;

            #(PERIOD);
            check_output (
                tb_test_case,

                1'b0, cuif.pc_src,
                1'b0, cuif.reg_dst,
                ZERO_EXT, cuif.ext_code,
                ALU_OR, cuif.alu_code,
                1'b0, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b1, cuif.alu_src,
                1'b1, cuif.reg_wr,
                1'b0, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b0, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD)


                // Test Case 18
                tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = XORI and funct_code = X";
            cuif.equal = 1'b0;
            cuif.op_code = XORI;
            cuif.funct_code = SUB;

            #(PERIOD);
            check_output (
                tb_test_case,

                1'b0, cuif.pc_src,
                1'b0, cuif.reg_dst,
                ZERO_EXT, cuif.ext_code,
                ALU_XOR, cuif.alu_code,
                1'b0, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b1, cuif.alu_src,
                1'b1, cuif.reg_wr,
                1'b0, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b0, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD)

                // Test Case 18
                tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = LUI and funct_code = X";
            cuif.equal = 1'b0;
            cuif.op_code = LUI;
            cuif.funct_code = SUB;

            #(PERIOD);
            check_output (
                tb_test_case,

                1'b0, cuif.pc_src,
                1'b0, cuif.reg_dst,
                LUI_EXT, cuif.ext_code,
                ALU_OR, cuif.alu_code,
                1'b0, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b1, cuif.alu_src,
                1'b1, cuif.reg_wr,
                1'b0, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b0, cuif.jump_en,
                1'b1, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD)

                // Test Case 18
                tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = LW and funct_code = X";
            cuif.equal = 1'b0;
            cuif.op_code = LW;
            cuif.funct_code = SUB;

            #(PERIOD);
            check_output (
                tb_test_case,

                1'b0, cuif.pc_src,
                1'b0, cuif.reg_dst,
                SIGN_EXT, cuif.ext_code,
                ALU_ADD, cuif.alu_code,
                1'b0, cuif.halt,
                1'b1, cuif.mem_to_reg,
                1'b1, cuif.alu_src,
                1'b1, cuif.reg_wr,
                1'b1, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b0, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD)


                // Test Case ? :P
                tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = SW and funct_code = X";
            cuif.equal = 1'b0;
            cuif.op_code = SW;
            cuif.funct_code = SUB;

            #(PERIOD);
            check_output (
                tb_test_case,

                1'b0, cuif.pc_src,
                1'b0, cuif.reg_dst,
                SIGN_EXT, cuif.ext_code,
                ALU_ADD, cuif.alu_code,
                1'b0, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b1, cuif.alu_src,
                1'b0, cuif.reg_wr,
                1'b1, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b0, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD)


                // Test Case 28
                tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = HALT and funct_code = X";
            cuif.equal = 1'b0;
            cuif.op_code = HALT;
            cuif.funct_code = SUB;

            #(PERIOD);
            check_output (
                tb_test_case,

                1'b0, cuif.pc_src,
                1'b0, cuif.reg_dst,
                ZERO_EXT, cuif.ext_code,
                ALU_OR, cuif.alu_code,
                1'b1, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b0, cuif.alu_src,
                1'b0, cuif.reg_wr,
                1'b0, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b0, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD)


            // J - TYPE


                // Test Case ? :P
                tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = JAL and funct_code = X";
            cuif.equal = 1'b0;
            cuif.op_code = JAL;
            cuif.funct_code = SUB;

            #(PERIOD);
            check_output (
                tb_test_case,

                1'b0, cuif.pc_src,
                1'b0, cuif.reg_dst,
                ZERO_EXT, cuif.ext_code,
                ALU_OR, cuif.alu_code,
                1'b0, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b0, cuif.alu_src,
                1'b1, cuif.reg_wr,
                1'b0, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b1, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b1, cuif.jal_en
                );
            #(PERIOD)
                // Test Case ? :P
                tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = J and funct_code = X";
            cuif.equal = 1'b0;
            cuif.op_code = J;
            cuif.funct_code = SUB;


            #(PERIOD);
            check_output (
                tb_test_case,

                1'b0, cuif.pc_src,
                1'b0, cuif.reg_dst,
                ZERO_EXT, cuif.ext_code,
                ALU_OR, cuif.alu_code,
                1'b0, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b0, cuif.alu_src,
                1'b0, cuif.reg_wr,
                1'b0, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b1, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD)



                // Test Case 28
                tb_test_num = tb_test_num + 1;
            tb_test_case = "op_code = HALT and funct_code = X";
            cuif.equal = 1'b0;
            cuif.op_code = HALT;
            cuif.funct_code = SUB;

            #(PERIOD);
            check_output (
                tb_test_case,

                1'b0, cuif.pc_src,
                1'b0, cuif.reg_dst,
                ZERO_EXT, cuif.ext_code,
                ALU_OR, cuif.alu_code,
                1'b1, cuif.halt,
                1'b0, cuif.mem_to_reg,
                1'b0, cuif.alu_src,
                1'b0, cuif.reg_wr,
                1'b0, cuif.mem_wr,
                1'b0, cuif.jr_en,
                1'b0, cuif.jump_en,
                1'b0, cuif.lui_en,
                1'b0, cuif.jal_en
                );
            #(PERIOD)

                $finish;
        end


endprogram : test
