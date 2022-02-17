/*
	Joshua Brard && Rohan Prabhu
	jbrard@purdue.edu, prabhu4@purdue.edu

	datapath contains register file, control, hazard,
	forwarding, muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"
`include "my_types_pkg.vh"
`include "caches_types_pkg.vh"

`include "program_counter_if.vh"
`include "control_unit_if.vh"
`include "register_file_if.vh"
`include "fetch_decode_if.vh"
`include "decode_execute_if.vh"
`include "execute_memory_if.vh"
`include "memory_write_back_if.vh"
`include "alu_if.vh"
`include "forwarding_unit_if.vh"
`include "hazard_forward_if.vh"


module datapath (
	input logic CLK, nRST,
	datapath_cache_if.dp dpif
);

	// import types
	import cpu_types_pkg::*;
	import my_types_pkg::*;
	import caches_types_pkg::*;
	// pc init
	parameter PC_INIT = 0;

	// interface declarations
	program_counter_if pcif();
	control_unit_if cuif();
	alu_if alif();
	register_file_if rgif();
	fetch_decode_if fdif();
	decode_execute_if deif();
	execute_memory_if emif();
	memory_write_back_if mwif();
	hazard_unit_if huif();
	forwarding_unit_if fuif();
	hazard_forward_if hfif();

	word_t next_pc;
	word_t normal_pc;
	word_t blue_branch_addr;
	logic red_pc_src;
	logic lw_sw;
	assign lw_sw = (emif.op_code_out == LW) || (emif.op_code_out == SW) ||
					(emif.op_code_out == LL) ||(emif.op_code_out == SC);
	// edited
	assign blue_branch_addr = (deif.imm_32_in << 2) + fdif.normal_pc_out;

	// assign pcif.pc_in = mwif.pc_in; edited

	word_t first_pc_mux_out;
	mux_2
	FIRST_PC (
		.in_0  (normal_pc),
		.in_1  (blue_branch_addr),
		.control ((cuif.beq_en || cuif.bne_en)),

		.out	(first_pc_mux_out)
	);


	logic second_pc_en;
	assign second_pc_en = (!red_pc_src && (emif.beq_en_out || emif.bne_en_out)) || emif.jr_en_out || emif.jump_en_out;

	mux_2
	SECOND_PC (
		.in_0  (first_pc_mux_out),
		.in_1  (mwif.pc_in),
		.control (second_pc_en),

		.out	(pcif.pc_in)
	);


	// Before first
	assign hfif.ihit = dpif.ihit;
	assign hfif.dhit = dpif.dhit;

	assign huif.ihit = dpif.ihit;
	assign huif.dhit = dpif.dhit;

	assign huif.memory_op_code = deif.op_code_out;
	assign huif.execute_op_code = emif.op_code_out;

	program_counter #(
		.PC_INIT (PC_INIT)
	) PROGRAM_COUNTER (
		.clk	(CLK),
		.nRst	(nRST),
		.pcif	(pcif)
	);
	assign next_pc = pcif.pc_out;
	assign normal_pc = next_pc + 4;

	assign dpif.imemaddr = next_pc;
	assign dpif.imemREN = 1'b1 && !emif.halt_out && !dpif.halt;
	// Before first pipeline END


	always_comb begin : LATCH_CONTROL
		// FIXME (Rohan extra instruction)
		pcif.pc_WEN = 0;//(hfif.fetch_decode_enable) && (dpif.ihit && !lw_sw) && (!dpif.halt) && (!dpif.dhit);

		fdif.update = 0;
		fdif.flush = 0;

		deif.update = 0;
		deif.flush = 0;

		emif.update = 0;
		emif.flush = 0;

		mwif.update = 0;
		mwif.flush = 0;

		if((dpif.ihit && dpif.dhit) || dpif.ihit && (!lw_sw)) begin
			if(!huif.hazard || (hfif.hu_is_mem == 1'b0 && (hfif.hu_decode_execute_conflict || hfif.hu_decode_memory_conflict))) begin
				pcif.pc_WEN = 1;// && !cuif.halt;

				fdif.update = 1; // && !cuif.halt;
				fdif.flush = (cuif.beq_en || cuif.bne_en);

				deif.update = 1;
				deif.flush = 0;

				emif.update = 1 && !emif.halt_out;
				emif.flush = 0;

				mwif.update = 1;
				mwif.flush = 0;
			end
			else begin
				pcif.pc_WEN = (hfif.fetch_decode_enable) && (dpif.ihit && !lw_sw) && (!dpif.halt) && (!dpif.dhit);

				fdif.update = hfif.fetch_decode_enable;// && !cuif.halt;
				fdif.flush = hfif.fetch_decode_flush;

				deif.update = hfif.decode_execute_enable;
				deif.flush = hfif.decode_execute_flush;

				emif.update = hfif.execute_memory_enable && !emif.halt_out;
				emif.flush = hfif.execute_memory_flush;

				mwif.update = hfif.memory_write_back_enable;
				mwif.flush = hfif.memory_write_back_flush;
			end

		end

		else if (dpif.dhit && !dpif.ihit) begin

			if(!huif.hazard || (hfif.hu_is_mem == 1'b0 && (hfif.hu_decode_execute_conflict || hfif.hu_decode_memory_conflict))) begin

				pcif.pc_WEN = 1'b0;

				fdif.update = 0;
				fdif.flush = 0;

				deif.update = 0;
				deif.flush = 1;  // FIXME

				emif.update = 1 && !emif.halt_out;//(hfif.execute_memory_enable && !lw_sw) || dpif.dhit;
				emif.flush = 0;//hfif.execute_memory_flush && (dpif.ihit || dpif.dhit);  // FIXME

				mwif.update = 1;// (hfif.memory_write_back_enable && !lw_sw) || dpif.dhit;
				mwif.flush = 0;

			end
			else begin
				pcif.pc_WEN = (hfif.fetch_decode_enable) && (dpif.ihit && !lw_sw) && (!dpif.halt) && (!dpif.dhit);// && !cuif.halt;

				fdif.update = hfif.fetch_decode_enable;// && !cuif.halt;
				fdif.flush = hfif.fetch_decode_flush;

				deif.update = hfif.decode_execute_enable;
				deif.flush = hfif.decode_execute_flush;

				emif.update = hfif.execute_memory_enable && !emif.halt_out;
				emif.flush = hfif.execute_memory_flush;

				mwif.update = hfif.memory_write_back_enable;
				mwif.flush = hfif.memory_write_back_flush;
			end

		end
 	end : LATCH_CONTROL

	// Fetch - Decode Latch



	assign fdif.normal_pc_in = normal_pc;
	assign fdif.instruction_in = dpif.imemload;
	assign fdif.next_pc_in = next_pc;

	fetch_decode
	FETCH_DECODE (
		.CLK	(CLK),
		.nRST	(nRST),
		.fdif	(fdif)
	);

	// Fetch - Decode Latch END

	// Control Unit
	assign cuif.instruction = fdif.instruction_out;
	control_unit
	CONTROL_UNIT (
		.cuif	(cuif)
	);

	//Register File Block Begin

	word_t pink_bus_w;  // need

	word_t final_bus_w;  // pls
	mux_3 #(
		.NUM_BITS	(32)
	) BUSW (
		.in_0		(pink_bus_w),
		.in_1		(mwif.normal_pc_out),
		.in_2		(mwif.imm_32_out),
		.control	({mwif.lui_en_out, mwif.jal_en_out}),

		.out		(final_bus_w)
	);

	assign rgif.wdat = final_bus_w;

	assign rgif.WEN = mwif.reg_wr_out;

	assign rgif.rsel1 = cuif.rs;
	assign rgif.rsel2 = cuif.rt;

	register_file
	REGISTER_FILE (
		.CLK	(CLK),
		.nRST	(nRST),
		.rfif	(rgif)
	);

	sign_extender
	SIGN_EXTENDER (
		.immediate_16	(cuif.imm_16),
		.ext_code		(cuif.ext_code),

		.out_32			(deif.imm_32_in)
	);
	//Register File Block End

	// decode-execute interface begin

	assign deif.d_atomic_in = cuif.d_atomic;  // NEW
	assign deif.instruction_in = fdif.instruction_out;
	assign deif.normal_pc_in = fdif.normal_pc_out;
	assign deif.next_pc_in = fdif.next_pc_out;
	assign deif.bus_a_in = rgif.rdat1;
	assign deif.bus_b_in = rgif.rdat2;
	//imm_32 assigned from sign extender
	assign deif.imm_26_in = cuif.imm_26;
	assign deif.imm_16_in = cuif.imm_16;
	assign deif.shamt_in = cuif.shamt;
	assign deif.alu_code_in = cuif.alu_code;
	assign deif.op_code_in = cuif.op_code;
	assign deif.funct_code_in = cuif.funct_code;
	assign deif.halt_in = cuif.halt;
	assign deif.alu_src_in = cuif.alu_src;
	assign deif.reg_dst_in = cuif.reg_dst;
	assign deif.mem_to_reg_in = cuif.mem_to_reg;
	assign deif.reg_wr_in = cuif.reg_wr;
	assign deif.mem_wr_in = cuif.mem_wr;
	assign deif.jr_en_in = cuif.jr_en;
	assign deif.jump_en_in = cuif.jump_en;
	assign deif.lui_en_in = cuif.lui_en;
	assign deif.jal_en_in = cuif.jal_en;
	assign deif.beq_en_in = cuif.beq_en;
	assign deif.bne_en_in = cuif.bne_en;
	assign deif.rd_in = cuif.rd;
	assign deif.rt_in = cuif.rt;
	assign deif.rs_in = cuif.rs;

	//Hazard unit wire butting in
	assign huif.decode_reg_wr_en = deif.reg_wr_in;
	assign huif.decode_instruction = deif.instruction_in;
	assign huif.decode_rs = deif.rs_in;
	assign huif.decode_rt = deif.rt_in;
	assign huif.decode_reg_dst = deif.reg_dst_in;

	assign huif.memory_beq = emif.beq_en_out;
	assign huif.memory_bne = emif.bne_en_out;

	hazard_unit
	HAZARD_UNIT(
		.huif(huif)
	);

	// hazard_forward

	assign hfif.hu_is_mem = huif.is_mem;
	assign hfif.ex_mem_to_reg = deif.mem_to_reg_out;
	assign hfif.ex_mem_wr = deif.mem_wr_out;

	assign hfif.hu_decode_execute_conflict = huif.decode_execute_conflict;
	assign hfif.hu_decode_memory_conflict = huif.decode_memory_conflict;


	assign hfif.hu_fetch_decode_flush = huif.fetch_decode_flush;
	assign hfif.hu_fetch_decode_enable = huif.fetch_decode_enable;

	assign hfif.hu_decode_execute_flush = huif.decode_execute_flush;
	assign hfif.hu_decode_execute_enable = huif.decode_execute_enable;

	assign hfif.hu_execute_memory_flush = huif.execute_memory_flush;
	assign hfif.hu_execute_memory_enable = huif.execute_memory_enable;

	assign hfif.hu_memory_write_back_flush = huif.memory_write_back_flush;
	assign hfif.hu_memory_write_back_enable = huif.memory_write_back_enable;


	hazard_forward
	HAZARD_FORWARD (
		.hfif		(hfif)
	);


	decode_execute
	DECODE_EXECUTE (
		.CLK	(CLK),
		.nRST	(nRST),
		.deif	(deif)
	);

	// Forwarding Unit Inputs
	// execute
	assign fuif.execute_instruction = deif.instruction_out;
	assign fuif.execute_rt = deif.rt_out;
	assign fuif.execute_rs = deif.rs_out;
	assign fuif.execute_alu_src = deif.alu_src_out;
	assign fuif.execute_reg_dst = deif.reg_dst_out;
	assign fuif.execute_reg_wr_en = deif.reg_wr_out;
	// memory
	assign fuif.memory_mem_to_reg = emif.mem_to_reg_out;
	assign fuif.memory_reg_wr_en = emif.reg_wr_out;
	assign fuif.memory_reg_wr_addr = emif.reg_wr_addr_out;
	// write back
	assign fuif.write_back_reg_wr_en = mwif.reg_wr_out;
	assign fuif.write_back_reg_wr_addr = mwif.reg_wr_addr_out;


	forwarding_unit
	FORWARDING_UNIT (
		.fuif		(fuif)
	);

	//decode-execute interface begin


	//execute section begin
	assign emif.d_atomic_in = deif.d_atomic_out;
	assign emif.instruction_in = deif.instruction_out;
	//assign emif.bus_b_in = deif.bus_b_out;
	assign emif.beq_en_in = deif.beq_en_out;
	assign emif.bne_en_in = deif.bne_en_out;
	assign emif.imm_16_in = deif.imm_16_out;
	assign emif.imm_32_in = deif.imm_32_out;
	assign emif.reg_dst_in = deif.reg_dst_out;
	assign emif.mem_to_reg_in = deif.mem_to_reg_out;
	assign emif.reg_wr_in = deif.reg_wr_out;
	assign emif.mem_wr_in = deif.mem_wr_out;
	assign emif.jr_en_in = deif.jr_en_out;
	assign emif.jump_en_in = deif.jump_en_out;
	assign emif.lui_en_in = deif.lui_en_out;
	assign emif.jal_en_in = deif.jal_en_out;
	assign emif.halt_in = deif.halt_out;
	assign emif.next_pc_in = deif.next_pc_out;
	assign emif.op_code_in = deif.op_code_out;
	assign emif.funct_code_in = deif.funct_code_out;
	assign emif.rt_in = deif.rt_out;
	assign emif.rs_in = deif.rs_out;
	assign emif.shamt_in = deif.shamt_out;

	//Hazard unit wire butting in
	assign huif.execute_reg_wr_en = emif.reg_wr_in;
	assign huif.execute_reg_wr_addr = emif.reg_wr_addr_in;

	//J,B,PC Address assignments
    word_t real_bus_a;
	word_t bus_b_before_alu_src;
	word_t j_addr;

	assign emif.dhit = dpif.dhit;
	assign emif.normal_pc_in = deif.normal_pc_out;
	assign emif.branch_pc_in = (deif.imm_32_out << 2) + deif.normal_pc_out;
	assign emif.jump_r_pc_in = real_bus_a;  // edited

	imm_pc_concatenate
	IMM_PC_CONCATENATE (
		.imm_26	(deif.imm_26_out),
		.pc		(deif.normal_pc_out[31 : 28]),

		.out	(j_addr)
	);
	assign emif.jump_pc_in = j_addr;

	//J,B,PC Address assignments end

	// ALU begin
	// BUS A

	always_comb begin
		real_bus_a = deif.bus_a_out;
		casez(fuif.bus_a_control)
			A_BUS_A: begin
				real_bus_a = deif.bus_a_out;
			end
			A_MEM_ALU_OUT: begin
				real_bus_a = emif.alu_out_out;
			end
			A_WB_BUS_W: begin
				real_bus_a = pink_bus_w;
   			end
		endcase
    end

	assign alif.portA = real_bus_a;

	// BUS B
	always_comb begin
		bus_b_before_alu_src = deif.bus_b_out;
		casez (fuif.bus_b_control)
			B_BUS_B: begin
				bus_b_before_alu_src = deif.bus_b_out;
			end
			B_MEM_ALU_OUT: begin
				bus_b_before_alu_src = emif.alu_out_out;
			end
			B_WB_BUS_W: begin
				bus_b_before_alu_src = pink_bus_w;
   			end
        endcase
 	end
	assign emif.bus_b_in = bus_b_before_alu_src;


	assign alif.portB = deif.alu_src_out ? deif.imm_32_out : bus_b_before_alu_src;

	assign alif.aluop = deif.alu_code_out;

	alu
	ALU (
		.aluif(alif)
	);

	assign emif.alu_out_in = alif.portOut;
	assign emif.equal_in = alif.zero;

	//ALU end

	//Mux for RegWr location
	mux_3 #(
		.NUM_BITS	(5)
	) WSEL (
		.in_0		(deif.rt_out),
		.in_1		(deif.rd_out),
		.in_2		(5'd31),
		.control	({deif.jal_en_out, deif.reg_dst_out}),

		.out		(emif.reg_wr_addr_in)
	);
	//Mux end

	execute_memory
	EXECUTE_MEMORY (
		.CLK	(CLK),
		.nRST	(nRST),
		.emif	(emif)
	);

	// execute-memory begin

    // Memory - Write-Back Start

    assign red_pc_src = (emif.equal_out && emif.beq_en_out) ||
        (!(emif.equal_out) && emif.bne_en_out);
    mux_3
    PC_MUX (
        .in_0		(emif.normal_pc_out),
        .in_1 		(emif.jump_pc_out),
        .in_2		(emif.jump_r_pc_out),
        .control	({emif.jr_en_out, emif.jump_en_out}),

        .out		(mwif.pc_in)
    );


    // mwif.pc_in from mux_4
    assign mwif.normal_pc_in = emif.normal_pc_out;
    assign mwif.next_pc_in = emif.next_pc_out;
    assign mwif.branch_pc_in = emif.branch_pc_out;
    assign mwif.halt_in = emif.halt_out;
    assign mwif.bus_b_in = emif.bus_b_out;
    assign mwif.alu_out_in = emif.alu_out_out;
	assign mwif.dhit = dpif.dhit;


	assign dpif.dmemREN = emif.mem_to_reg_out && !emif.halt_out && !dpif.halt && !emif.mem_wr_out;
	assign dpif.dmemWEN = emif.mem_wr_out && !emif.halt_out && !dpif.halt;
	assign dpif.datomic = emif.d_atomic_out && !emif.halt_out && !dpif.halt;

	assign mwif.mem_to_reg_in = emif.mem_to_reg_out;
	assign mwif.read_data_in = dpif.dmemload;

    assign mwif.imm_32_in = emif.imm_32_out;
    assign mwif.imm_16_in = emif.imm_16_out;
    assign mwif.reg_wr_in = emif.reg_wr_out;
    assign mwif.reg_dst_in = emif.reg_dst_out;
    assign mwif.lui_en_in = emif.lui_en_out;
    assign mwif.jal_en_in = emif.jal_en_out;
    assign mwif.reg_wr_addr_in = emif.reg_wr_addr_out;
    assign mwif.op_code_in = emif.op_code_out;
    assign mwif.funct_code_in = emif.funct_code_out;
    assign mwif.rt_in = emif.rt_out;
    assign mwif.rs_in = emif.rs_out;
    assign mwif.shamt_in = emif.shamt_out;
	assign mwif.instruction_in = emif.instruction_out;

    assign dpif.dmemstore = emif.bus_b_out;


    assign dpif.dmemaddr = emif.alu_out_out;

	//Hazard unit wire butting in
	assign huif.memory_jump_en = emif.jump_en_out;
	assign huif.memory_jump_r_en = emif.jr_en_out;
	assign huif.memory_reg_wr_en = emif.reg_wr_out;
	assign huif.memory_reg_wr_addr = emif.reg_wr_addr_out;
	assign huif.memory_pc_src = red_pc_src;
	//assign huif.memory_mem_to_meg = emif.mem_ro_reg_out;

	//


    memory_write_back
    MEMORY_WRITE_BACK (
        .CLK		(CLK),
        .nRST		(nRST),
        .mwif		(mwif)
    );
	assign rgif.wsel = mwif.reg_wr_addr_out;
    // Memory - Write-Back END
    mux_2
    TOBUSW (
		.in_0		(mwif.alu_out_out),
        .in_1		(mwif.read_data_out),

        .control	(mwif.mem_to_reg_out),

        .out		(pink_bus_w)  // this goes into MUX3
    );

	
	//assign dpif.halt = 1'b1;
	
	// halt latch
    always_ff @ (posedge CLK, negedge nRST) begin
        if(nRST == 1'b0) begin
			// reset
            dpif.halt <= 1'b0;
        end
        else if (emif.halt_out == 1'b1) begin
			// update
            dpif.halt <= 1'b1;
        end
        else begin
			// latch
            dpif.halt <= dpif.halt;
        end
    end
	


endmodule : datapath
