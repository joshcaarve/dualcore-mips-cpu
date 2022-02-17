/*
    Joshua Brard && Rohan Prabhu
    jbrard@purdue.edu Prabhu4@purdue.edu

    forwarding_unit testbench
*/

// include statements
`include "include/forwarding_unit_if.vh"
`include "include/cpu_types_pkg.vh"
`include "include/my_types_pkg.vh"
`timescale 1 ns / 1 ns

module forwarding_unit_tb;

    import cpu_types_pkg::*;
    import my_types_pkg::*;
    parameter PERIOD = 10;

    logic CLK = 0;
    logic nRST = 1'b1;

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
        input integer test_case_num;

        input bus_a_control_t exp_bus_a_in;
        input bus_a_control_t act_bus_a_in;

        input bus_b_control_t exp_bus_b_in;
        input bus_b_control_t act_bus_b_in;

        begin
            tb_blip = 1'b1;
            assert (
                    exp_bus_a_in == act_bus_a_in &&
                    exp_bus_b_in == act_bus_b_in
                ) begin
                $display("Correct output for in test case %s (%d)", test_case, test_case_num);
            end
            else begin
                $display("Incorrect output in test case %s (%d)", test_case, test_case_num);
            end
            #(0.2);
            tb_blip = 1'b0;
        end
    endtask : check_output
    // interface
    forwarding_unit_if fuif ();
    // test program
    test PROG (fuif);

    `ifndef MAPPED
    forwarding_unit DUT(fuif);
    `else
    forwarding_unit DUT (
    .\fuif.execute_instruction                (fuif.execute_instruction),
    .\fuif.execute_rt                         (fuif.execute_rt),
    .\fuif.execute_rs                         (fuif.execute_rs),
    .\fuif.execute_alu_src                    (fuif.execute_alu_src),
    .\fuif.execute_reg_dst                    (fuif.execute_reg_dst),
    .\fuif.execute_reg_wr_en                  (fuif.execute_reg_wr_en),
    .\fuif.memory_reg_wr_en                   (fuif.memory_reg_wr_en),
    .\fuif.memory_reg_wr_addr                 (fuif.memory_reg_wr_addr),
    .\fuif.write_back_reg_wr_en               (fuif.write_bacK_reg_wr_en),
    .\fuif.write_back_reg_wr_addr             (fuif.write_back_reg_wr_addr),

    .\fuif.bus_a_control                      (fuif.bus_a_control),
    .\fuif.bus_b_control                      (fuif.bus_b_control)
    );
    `endif

endmodule : forwarding_unit_tb

program test (
    forwarding_unit_if.tb fuif
);
    parameter PERIOD = 10;
    import cpu_types_pkg::*;
    import my_types_pkg::*;
    string tb_test_case;
    integer tb_test_num;

    initial begin

        tb_test_case = "INIT";
        tb_test_num = 0;
        #(PERIOD);
        reset_dut();

        // Test Case 1 (raw_hazard_fix_fowarding_1.asm)
        tb_test_num = tb_test_num + 1;
        tb_test_case = "raw_hazard_fix_fowarding_1.asm";

        fuif.execute_instruction = {RTYPE, 5'd0, 5'd10, 5'd11, 5'd0, ADD};
        fuif.execute_rt = regbits_t' (5'd0);
        fuif.execute_rs = regbits_t' (5'd10);
        fuif.execute_reg_dst = regbits_t' (5'd11);
        fuif.execute_alu_src = 1'b0;
        fuif.execute_reg_wr_en = 1'b1;

        fuif.memory_mem_to_reg = 1'b0;
        fuif.memory_reg_wr_en = 1'b1;
        fuif.memory_reg_wr_addr = regbits_t' (5'd10);

        fuif.write_back_reg_wr_en = 1'b0;
        fuif.write_back_reg_wr_addr = regbits_t' (5'd0);

        #(PERIOD);
        check_output (

            tb_test_case, tb_test_num,
            A_MEM_ALU_OUT,          fuif.bus_a_control,
            B_BUS_B,                fuif.bus_b_control

            );
        #(PERIOD);

        // Test Case 2 (raw_hazard_fix_forwarding_2.asm)
        tb_test_num = tb_test_num + 1;
        tb_test_case = "raw_hazard_fix_forwarding_2.asm";

        fuif.execute_instruction = {RTYPE, 5'd0, 5'd10, 5'd11, 5'd0, ADD};
        fuif.execute_rt = regbits_t' (5'd0);
        fuif.execute_rs = regbits_t' (5'd10);
        fuif.execute_reg_dst = regbits_t' (5'd11);
        fuif.execute_alu_src = 1'b0;
        fuif.execute_reg_wr_en = 1'b1;

        fuif.memory_mem_to_reg = 1'b0;
        fuif.memory_reg_wr_en = 1'b1;
        fuif.memory_reg_wr_addr = regbits_t' (5'd9);


        fuif.write_back_reg_wr_en = 1'b1;
        fuif.write_back_reg_wr_addr = regbits_t' (5'd10);

        #(PERIOD);
        check_output (

            tb_test_case, tb_test_num,
            A_WB_BUS_W,             fuif.bus_a_control,
            B_BUS_B,                fuif.bus_b_control

            );
        #(PERIOD);

        // Test Case 3 (raw_hazard_fix_forwarding_3.asm)
        tb_test_num = tb_test_num + 1;
        tb_test_case = "raw_hazard_fix_forwarding_3.asm";

        fuif.execute_instruction = {ADDI, 5'd10, 5'd10, 16'd1};
        fuif.execute_rt = regbits_t' (5'd10);
        fuif.execute_rs = regbits_t' (5'd10);
        fuif.execute_reg_dst = regbits_t' (5'd10);
        fuif.execute_alu_src = 1'b1;
        fuif.execute_reg_wr_en = 1'b1;

        fuif.memory_mem_to_reg = 1'b0;
        fuif.memory_reg_wr_en = 1'b1;
        fuif.memory_reg_wr_addr = regbits_t' (5'd10);

        fuif.write_back_reg_wr_en = 1'b0;
        fuif.write_back_reg_wr_addr = regbits_t' (5'd0);

        #(PERIOD);
        check_output (

            tb_test_case, tb_test_num,
            A_MEM_ALU_OUT,           fuif.bus_a_control,
            B_MEM_ALU_OUT,                fuif.bus_b_control

            );
        #(PERIOD);

        // Test Case 4 (raw_hazard_fix_forwarding_4.asm)
        tb_test_num = tb_test_num + 1;
        tb_test_case = "raw_hazard_fix_forwarding_4.asm";

        fuif.execute_instruction = {ADDI, 5'd10, 5'd10, 16'd1};
        fuif.execute_rt = regbits_t' (5'd10);
        fuif.execute_rs = regbits_t' (5'd10);
        fuif.execute_reg_dst = regbits_t' (5'd10);
        fuif.execute_alu_src = 1'b1;
        fuif.execute_reg_wr_en = 1'b1;

        fuif.memory_mem_to_reg = 1'b0;
        fuif.memory_reg_wr_en = 1'b1;
        fuif.memory_reg_wr_addr = regbits_t' (5'd10);

        fuif.write_back_reg_wr_en = 1'b1;
        fuif.write_back_reg_wr_addr = regbits_t' (5'd10);

        #(PERIOD);
        check_output (

            tb_test_case, tb_test_num,
            A_MEM_ALU_OUT,           fuif.bus_a_control,
            B_MEM_ALU_OUT,                fuif.bus_b_control

            );
        #(PERIOD);

        // Test Case 5 (raw_hazard_not_fix_forwarding_1.asm)
        tb_test_num = tb_test_num + 1;
        tb_test_case = "raw_hazard_not_fix_forwarding_1.asm";

        fuif.execute_instruction = {ADDI, 5'd3, 5'd3, 16'd1};
        fuif.execute_rt = regbits_t' (5'd3);
        fuif.execute_rs = regbits_t' (5'd3);
        fuif.execute_reg_dst = regbits_t' (5'd3);
        fuif.execute_alu_src = 1'b1;
        fuif.execute_reg_wr_en = 1'b1;

        // memory has load word so forwarding cannot occur
        fuif.memory_mem_to_reg = 1'b1;
        fuif.memory_reg_wr_en = 1'b1;
        fuif.memory_reg_wr_addr = regbits_t' (5'd3);

        fuif.write_back_reg_wr_en = 1'b1;
        fuif.write_back_reg_wr_addr = regbits_t' (5'd1);

        #(PERIOD);
        check_output (

            tb_test_case, tb_test_num,
            A_BUS_A,                 fuif.bus_a_control,
            B_BUS_B,                fuif.bus_b_control

            );

        #(PERIOD);



        // Test Case 6 (simple_raw_fix_1.asm)
        tb_test_num = tb_test_num + 1;
        tb_test_case = "simple_raw_fix_1.asm";

        fuif.execute_instruction = {ADDI, 5'd11, 5'd10, 16'd3};
        fuif.execute_rt = regbits_t' (5'd11);
        fuif.execute_rs = regbits_t' (5'd10);
        fuif.execute_reg_dst = regbits_t' (5'd11);
        fuif.execute_alu_src = 1'b1;
        fuif.execute_reg_wr_en = 1'b1;

        // memory has load word so forwarding cannot occur
        fuif.memory_mem_to_reg = 1'b0;
        fuif.memory_reg_wr_en = 1'b1;
        fuif.memory_reg_wr_addr = regbits_t' (5'd10);

        fuif.write_back_reg_wr_en = 1'b0;
        fuif.write_back_reg_wr_addr = regbits_t' (5'd0);

        #(PERIOD);
        check_output (

            tb_test_case, tb_test_num,
            A_MEM_ALU_OUT,           fuif.bus_a_control,
            B_BUS_B,                fuif.bus_b_control

            );

        #(PERIOD);


        $finish;





    end

endprogram : test
