/*
    Joshua Brard && Rohan Prabhu
    jbrard@purdue.edu Prabhu4@purdue.edu

    hazard_unit testbench
*/

// include statements
`include "include/hazard_unit_if.vh"
`include "include/cpu_types_pkg.vh"

`timescale 1 ns / 1 ns

module hazard_unit_tb;

    import cpu_types_pkg::*;
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
        // fetch decode
        input logic ex_fd_flush;
        input logic act_fd_flush;

        input logic ex_fd_enable;
        input logic act_fd_enable;


        // decode_execute
        input logic ex_de_flush;
        input logic act_de_flush;

        input logic ex_de_enable;
        input logic act_de_enable;


        // execute_memory
        input logic ex_em_flush;
        input logic act_em_flush;

        input logic ex_em_enable;
        input logic act_em_enable;


        // memory_write_back
        input logic ex_mwb_flush;
        input logic act_mwb_flush;

        input logic ex_mwb_enable;
        input logic act_mwb_enable;

        begin
            tb_blip = 1'b1;
            assert (
                    ex_fd_flush == act_fd_flush &&
                    ex_fd_enable == act_fd_enable &&
                    ex_de_flush == act_de_flush &&
                    ex_de_enable == act_de_enable &&
                    ex_em_flush == act_em_flush &&
                    ex_em_enable == act_em_enable &&
                    ex_mwb_flush == act_mwb_flush &&
                    ex_mwb_enable == act_mwb_enable) begin
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
    hazard_unit_if huif ();
    // test program
    test PROG (huif);

    `ifndef MAPPED
        hazard_unit DUT(huif);
    `else
        hazard_unit DUT (
        .\huif.decode_rt                (huif.decode_rt),
        .\huif.decode_rs                (huif.decode_rs),
        .\huif.memory_pc_src            (huif.memory_pc_src),
        .\huif.memory_jump_en           (huif.memory_jump_en),
        .\huif.memory_jump_r_en         (huif.memory_jump_r_en),
        .\huif.ihit                     (huif.ihit),
        .\huif.decode_instruction       (huif.decode_instruction),
        .\huif.decode_reg_wr_en         (huif.decode_reg_wr_en),
        .\huif.execute_reg_wr_en        (huif.execute_reg_wr_en),
        .\huif.memory_reg_wr_en         (huif.memory_reg_wr_en),
        .\huif.execute_reg_wr_addr      (huif.execute_reg_wr_addr),
        .\huif.memory_reg_wr_addr       (huif.memory_reg_wr_addr),
        .\huif.decode_reg_dst           (huif.decode_reg_dst),


        .\huif.fetch_decode_flush       (huif.fetch_decode_flush),
        .\huif.decode_execute_flush     (huif.decode_execute_flush),
        .\huif.execute_memory_flush     (huif.execute_memory_flush),
        .\huif.memory_write_back_flush  (huif.memory_write_back_flush),
        .\huif.fetch_decode_enable      (huif.fetch_decode_enable),
        .\huif.decode_execute_enable    (huif.decode_execute_enable),
        .\huif.execute_memory_enable    (huif.execute_memory_enable),
        .\huif.memory_write_back_enable (huif.memory_write_back_enable),

        );
    `endif

endmodule : hazard_unit_tb

program test (
	hazard_unit_if.tb huif
);
    parameter PERIOD = 10;
    import cpu_types_pkg::*;
	string tb_test_case;
    integer tb_test_num;

	initial begin

        tb_test_case = "INIT";
        tb_test_num = 0;
        #(PERIOD);
        reset_dut();
        #(PERIOD);


        // Test Case 1
        tb_test_num = tb_test_num + 1;
        tb_test_case = "No Issues at all";

        huif.ihit = 1'b1;

        huif.decode_rt = regbits_t' (5'b00001);
        huif.decode_rs = regbits_t' (5'b00010);
        huif.decode_instruction = word_t' (32'b00000000010000100001000000100000);
        huif.decode_reg_wr_en = 1'b1;
        huif.decode_reg_dst = 1'b1;

        huif.memory_pc_src = 1'b0;
        huif.memory_jump_en = 1'b0;
        huif.memory_jump_r_en = 1'b0;
        huif.memory_reg_wr_en = 1'b0;
        huif.memory_reg_wr_addr = regbits_t' (5'b10000);

        huif.execute_reg_wr_en = 1'b0;
        huif.execute_reg_wr_addr = regbits_t' (5'b01000);
        #(PERIOD);
        check_output (
            tb_test_case, tb_test_num,
            1'b0, huif.fetch_decode_flush,
            1'b1, huif.fetch_decode_enable,
            1'b0, huif.decode_execute_flush,
            1'b1, huif.decode_execute_enable,
            1'b0, huif.execute_memory_flush,
            1'b1, huif.execute_memory_enable,
            1'b0, huif.memory_write_back_flush,
            1'b1, huif.memory_write_back_enable
         );
        #(PERIOD);


        // Test Case 2
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Data Hazard";

        huif.ihit = 1'b1;

        huif.decode_rt = regbits_t' (5'b00010);
        huif.decode_rs = regbits_t' (5'b00001);
        huif.decode_instruction = {RTYPE, 5'd1, 5'd2, 5'd3, 5'd0, ADD};
        huif.decode_reg_wr_en = 1'b1;
        huif.decode_reg_dst = 1'b1;

        huif.execute_reg_wr_en = 1'b1;
        huif.execute_reg_wr_addr = regbits_t' (5'd2);

        huif.memory_pc_src = 1'b0;
        huif.memory_jump_en = 1'b0;
        huif.memory_jump_r_en = 1'b0;
        huif.memory_reg_wr_en = 1'b1;
        huif.memory_reg_wr_addr = regbits_t' (5'd3);

        #(PERIOD);
        check_output (
            tb_test_case, tb_test_num,
            1'b0, huif.fetch_decode_flush,
            1'b0, huif.fetch_decode_enable,
            1'b1, huif.decode_execute_flush,
            1'b1, huif.decode_execute_enable,
            1'b0, huif.execute_memory_flush,
            1'b1, huif.execute_memory_enable,
            1'b0, huif.memory_write_back_flush,
            1'b1, huif.memory_write_back_enable
            );
        #(PERIOD);


        // Test Case 3
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Data Hazard (Again)";

        huif.ihit = 1'b1;

        huif.decode_rt = regbits_t' (5'b00010);
        huif.decode_rs = regbits_t' (5'b00001);
        huif.decode_instruction = {RTYPE, 5'd1, 5'd2, 5'd1, 5'd0, ADD};
        huif.decode_reg_wr_en = 1'b1;
        huif.decode_reg_dst = 1'b1;

        huif.execute_reg_wr_en = 1'b1;
        huif.execute_reg_wr_addr = regbits_t' (5'd6);

        huif.memory_pc_src = 1'b0;
        huif.memory_jump_en = 1'b0;
        huif.memory_jump_r_en = 1'b0;
        huif.memory_reg_wr_en = 1'b1;
        huif.memory_reg_wr_addr = regbits_t' (5'd1);

        #(PERIOD);
        check_output (
            tb_test_case, tb_test_num,
            1'b0, huif.fetch_decode_flush,
            1'b0, huif.fetch_decode_enable,
            1'b1, huif.decode_execute_flush,
            1'b1, huif.decode_execute_enable,
            1'b0, huif.execute_memory_flush,
            1'b1, huif.execute_memory_enable,
            1'b0, huif.memory_write_back_flush,
            1'b1, huif.memory_write_back_enable
            );
        #(PERIOD);

        // Test Case 3
        tb_test_num = tb_test_num + 1;
        tb_test_case = "JUMP";

        huif.ihit = 1'b1;

        huif.decode_rt = regbits_t' (5'b00010);
        huif.decode_rs = regbits_t' (5'b00001);
        huif.decode_instruction = {RTYPE, 5'd1, 5'd2, 5'd1, 5'd0, ADD};
        huif.decode_reg_wr_en = 1'b1;
        huif.decode_reg_dst = 1'b1;

        huif.execute_reg_wr_en = 1'b1;
        huif.execute_reg_wr_addr = regbits_t' (5'd1);

        huif.memory_pc_src = 1'b0;
        huif.memory_jump_en = 1'b1;
        huif.memory_jump_r_en = 1'b0;
        huif.memory_reg_wr_en = 1'b1;
        huif.memory_reg_wr_addr = regbits_t' (5'd31);

        #(PERIOD);
        check_output (
            tb_test_case, tb_test_num,
            1'b1, huif.fetch_decode_flush,
            1'b1, huif.fetch_decode_enable,
            1'b1, huif.decode_execute_flush,
            1'b1, huif.decode_execute_enable,
            1'b1, huif.execute_memory_flush,
            1'b1, huif.execute_memory_enable,
            1'b0, huif.memory_write_back_flush,
            1'b1, huif.memory_write_back_enable
            );
        #(PERIOD);

        // Test Case 4
        tb_test_num = tb_test_num + 1;
        tb_test_case = "JUMP_R";

        huif.ihit = 1'b1;

        huif.decode_rt = regbits_t' (5'b11111);
        huif.decode_rs = regbits_t' (5'b11111);
        huif.decode_instruction = {RTYPE, 5'd30, 5'd30, 5'd30, 5'd0, ADD};
        huif.decode_reg_wr_en = 1'b1;
        huif.decode_reg_dst = 1'b1;

        huif.execute_reg_wr_en = 1'b0;
        huif.execute_reg_wr_addr = regbits_t' (5'd30);

        huif.memory_pc_src = 1'b0;
        huif.memory_jump_en = 1'b0;
        huif.memory_jump_r_en = 1'b1;
        huif.memory_reg_wr_en = 1'b1;
        huif.memory_reg_wr_addr = regbits_t' (5'd0);

        #(PERIOD);
        check_output (
            tb_test_case, tb_test_num,
            1'b1, huif.fetch_decode_flush,
            1'b1, huif.fetch_decode_enable,
            1'b1, huif.decode_execute_flush,
            1'b1, huif.decode_execute_enable,
            1'b1, huif.execute_memory_flush,
            1'b1, huif.execute_memory_enable,
            1'b0, huif.memory_write_back_flush,
            1'b1, huif.memory_write_back_enable
            );
        #(PERIOD);

        // Test Case 5
        tb_test_num = tb_test_num + 1;
        tb_test_case = "BRANCH";
        huif.ihit = 1'b1;

        huif.decode_rt = regbits_t' (5'd0);
        huif.decode_rs = regbits_t' (5'd0);
        huif.decode_instruction = {RTYPE, 5'd0, 5'd0, 5'd0, 5'd31, SUB};
        huif.decode_reg_wr_en = 1'b0;
        huif.decode_reg_dst = 1'b0;

        huif.execute_reg_wr_en = 1'b0;
        huif.execute_reg_wr_addr = regbits_t' (5'd30);

        huif.memory_pc_src = 1'b1;
        huif.memory_jump_en = 1'b0;
        huif.memory_jump_r_en = 1'b0;
        huif.memory_reg_wr_en = 1'b0;
        huif.memory_reg_wr_addr = regbits_t' (5'd31);

        #(PERIOD);
        check_output (
            tb_test_case, tb_test_num,
            1'b1, huif.fetch_decode_flush,
            1'b1, huif.fetch_decode_enable,
            1'b1, huif.decode_execute_flush,
            1'b1, huif.decode_execute_enable,
            1'b1, huif.execute_memory_flush,
            1'b1, huif.execute_memory_enable,
            1'b0, huif.memory_write_back_flush,
            1'b1, huif.memory_write_back_enable
            );
        #(PERIOD);


        // Test Case 6
        tb_test_num = tb_test_num + 1;
        tb_test_case = "JUMP NORM";

        huif.ihit = 1'b1;

        huif.decode_rt = regbits_t' (5'b00010);
        huif.decode_rs = regbits_t' (5'b00001);
        huif.decode_instruction = {RTYPE, 5'd1, 5'd2, 5'd1, 5'd0, ADD};
        huif.decode_reg_wr_en = 1'b1;
        huif.decode_reg_dst = 1'b1;

        huif.execute_reg_wr_en = 1'b1;
        huif.execute_reg_wr_addr = regbits_t' (5'd1);

        huif.memory_pc_src = 1'b0;
        huif.memory_jump_en = 1'b1;
        huif.memory_jump_r_en = 1'b0;
        huif.memory_reg_wr_en = 1'b0;
        huif.memory_reg_wr_addr = regbits_t' (5'd0);

        #(PERIOD);
        check_output (
            tb_test_case, tb_test_num,
            1'b1, huif.fetch_decode_flush,
            1'b1, huif.fetch_decode_enable,
            1'b1, huif.decode_execute_flush,
            1'b1, huif.decode_execute_enable,
            1'b1, huif.execute_memory_flush,
            1'b1, huif.execute_memory_enable,
            1'b0, huif.memory_write_back_flush,
            1'b1, huif.memory_write_back_enable
            );
        #(PERIOD);

        // Test Case 7
        tb_test_num = tb_test_num + 1;
        tb_test_case = "LW HAZARD";

        huif.ihit = 1'b1;

        huif.decode_rt = regbits_t' (5'b00010);
        huif.decode_rs = regbits_t' (5'b00001);
        huif.decode_instruction = {RTYPE, 5'd1, 5'd2, 5'd1, 5'd0, ADD};
        huif.decode_reg_wr_en = 1'b1;
        huif.decode_reg_dst = 1'b1;

        huif.execute_reg_wr_en = 1'b1;
        huif.execute_reg_wr_addr = regbits_t' (5'd1);

        huif.memory_pc_src = 1'b0;
        huif.memory_jump_en = 1'b0;
        huif.memory_jump_r_en = 1'b0;
        huif.memory_reg_wr_en = 1'b0;
        huif.memory_reg_wr_addr = regbits_t' (5'd0);

        #(PERIOD);
        check_output (
            tb_test_case, tb_test_num,
            1'b0, huif.fetch_decode_flush,
            1'b0, huif.fetch_decode_enable,
            1'b1, huif.decode_execute_flush,
            1'b1, huif.decode_execute_enable,
            1'b0, huif.execute_memory_flush,
            1'b1, huif.execute_memory_enable,
            1'b0, huif.memory_write_back_flush,
            1'b1, huif.memory_write_back_enable
            );
        #(PERIOD);


        // Test Case 8
        tb_test_num = tb_test_num + 1;
        tb_test_case = "SW HAZARD";

        huif.ihit = 1'b1;

        huif.decode_rt = regbits_t' (5'b00010);
        huif.decode_rs = regbits_t' (5'b00001);
        huif.decode_instruction = {SW, 5'd1, 5'd1, 16'd100};
        huif.decode_reg_wr_en = 1'b0;
        huif.decode_reg_dst = 1'b0;

        huif.execute_reg_wr_en = 1'b1;
        huif.execute_reg_wr_addr = regbits_t' (5'd1);

        huif.memory_pc_src = 1'b0;
        huif.memory_jump_en = 1'b0;
        huif.memory_jump_r_en = 1'b0;
        huif.memory_reg_wr_en = 1'b0;
        huif.memory_reg_wr_addr = regbits_t' (5'd0);

        #(PERIOD);
        check_output (
            tb_test_case, tb_test_num,
            1'b0, huif.fetch_decode_flush,
            1'b0, huif.fetch_decode_enable,
            1'b1, huif.decode_execute_flush,
            1'b1, huif.decode_execute_enable,
            1'b0, huif.execute_memory_flush,
            1'b1, huif.execute_memory_enable,
            1'b0, huif.memory_write_back_flush,
            1'b1, huif.memory_write_back_enable
            );
        #(PERIOD);


		$finish;
	end

endprogram : test
