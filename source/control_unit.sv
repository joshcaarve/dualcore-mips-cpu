/*
    Joshua Brard
    jbrard@purdue.edu

    The control unit sends a lot of signals for mux operations
*/


`include "cpu_types_pkg.vh"
`include "my_types_pkg.vh"

`include "control_unit_if.vh"

module control_unit (
    control_unit_if.cu cuif
);
    import cpu_types_pkg::*;
    import my_types_pkg::*;

    // input is word_t instruction

    assign cuif.op_code = opcode_t' (cuif.instruction[31:26]);
    assign cuif.funct_code = funct_t' (cuif.instruction[5:0]);

    assign cuif.imm_16 = cuif.instruction[15:0];
    assign cuif.imm_26 = cuif.instruction[25:0];

    assign cuif.rs = regbits_t' (cuif.instruction[25:21]);
    assign cuif.rt = regbits_t' (cuif.instruction[20:16]);
    assign cuif.rd = regbits_t' (cuif.instruction[15:11]);
    assign cuif.shamt = (cuif.instruction[10:6]);

    always_comb begin
        cuif.reg_dst    = '0;
        cuif.ext_code   = ZERO_EXT;
        cuif.alu_code   = ALU_OR;
        cuif.halt       = '0;
        cuif.mem_to_reg = '0;
        cuif.alu_src    = '0;
        cuif.reg_wr     = '0;
        cuif.mem_wr     = '0;
        cuif.jr_en      = '0;
        cuif.jump_en    = '0;
        cuif.lui_en     = '0;
        cuif.jal_en     = '0;
        cuif.beq_en     = '0;
        cuif.bne_en     = '0;
        cuif.d_atomic   = '0;
        casez (cuif.op_code)
            /************************* R - type ***************************/
            RTYPE: begin
                casez (cuif.funct_code)
                    SLLV: begin
                        // SLLV   $rd,$rs,$rt   R[rd] <= R[rt] << [0:4] R[rs]
                        cuif.alu_code = ALU_SLL;
                        cuif.reg_dst = 1'b1;     // see instruction declaration
                        cuif.reg_wr = 1'b1;      // need to write to regFile[rd]
                    end
                    SRLV: begin
                        // SRLV   $rd,$rs,$rt   R[rd] <= R[rt] >> [0:4] R[rs]
                        cuif.alu_code = ALU_SRL;
                        cuif.reg_dst = 1'b1;     // see instruction declaration
                        cuif.reg_wr = 1'b1;      // need to write to regFile[rd]
                    end
                    JR: begin
                        // JR     $rs           PC <= R[rs]
                        cuif.jr_en = 1'b1;       // jump return instruction
                        //cuif.jump_en = 1'b1;
                    end
                    ADD: begin
                        // ADD    $rd,$rs,$rt   R[rd] <= R[rs] + R[rt]
                        cuif.alu_code = ALU_ADD;
                        cuif.reg_dst = 1'b1;     // see instruction declaration
                        cuif.reg_wr = 1'b1;      // need to write to regFile[rd]
                    end
                    ADDU: begin
                        // ADDU   $rd,$rs,$rt   R[rd] <= R[rs] + R[rt] (unchecked overflow)
                        cuif.alu_code = ALU_ADD;
                        cuif.reg_dst = 1'b1;     // see instruction declaration
                        cuif.reg_wr = 1'b1;      // need to write to regFile[rd]
                    end
                    SUB: begin
                        // SUB    $rd,$rs,$rt   R[rd] <= R[rs] - R[rt]
                        cuif.alu_code = ALU_SUB;
                        cuif.reg_dst = 1'b1;     // see instruction declaration
                        cuif.reg_wr = 1'b1;      // need to write to regFile[rd]
                    end
                    SUBU: begin
                        // SUBU   $rd,$rs,$rt   R[rd] <= R[rs] - R[rt] (unchecked overflow)
                        cuif.alu_code = ALU_SUB;
                        cuif.reg_dst = 1'b1;     // see nstruction declaration
                        cuif.reg_wr = 1'b1;      // need to write to regFile[rd]
                    end
                    AND: begin
                        // AND    $rd,$rs,$rt   R[rd] <= R[rs] AND R[rt]
                        cuif.alu_code = ALU_AND;
                        cuif.reg_dst = 1'b1;     // see instruction declaration
                        cuif.reg_wr = 1'b1;      // need to write to regFile[rd]
                    end
                    OR: begin
                        // OR     $rd,$rs,$rt   R[rd] <= R[rs] OR R[rt]
                        cuif.alu_code = ALU_OR;
                        cuif.reg_dst = 1'b1;     // see instruction declaration
                        cuif.reg_wr = 1'b1;      // need to write to regFile[rd]
                    end
                    XOR: begin
                        // XOR    $rd,$rs,$rt   R[rd] <= R[rs] XOR R[rt]
                        cuif.alu_code = ALU_XOR;
                        cuif.reg_dst = 1'b1;     // see instruction declaration
                        cuif.reg_wr = 1'b1;      // need to write to regFile[rd]
                    end
                    NOR: begin
                        // NOR    $rd,$rs,$rt   R[rd] <= ~(R[rs] OR R[rt])
                        cuif.alu_code = ALU_NOR;
                        cuif.reg_dst = 1'b1;     // see instruction declaration
                        cuif.reg_wr = 1'b1;      // need to write to regFile[rd]
                    end
                    SLT: begin
                        // SLT    $rd,$rs,$rt   R[rd] <= (R[rs] < R[rt]) ? 1 : 0
                        cuif.alu_code = ALU_SLT;
                        cuif.reg_dst = 1'b1;     // see instruction declaration
                        cuif.reg_wr = 1'b1;      // need to write to regFile[rd]
                    end
                    SLTU: begin
                        // SLTU   $rd,$rs,$rt   R[rd] <= (R[rs] < R[rt]) ? 1 : 0
                        cuif.alu_code = ALU_SLTU;
                        cuif.reg_dst = 1'b1;     // see instruction declaration
                        cuif.reg_wr = 1'b1;      // need to write to regFile[rd]
                    end
                endcase
            end

            /************************* I - type ***************************/
            BEQ : begin
                // BEQ    $rs,$rt,label PC <= (R[rs] == R[rt]) ? npc+BranchAddr : npc
                cuif.alu_code = ALU_SUB;
                cuif.beq_en = 1'b1;
                cuif.ext_code   = SIGN_EXT;

            end
            BNE : begin
                // $rs,$rt,label PC <= (R[rs] != R[rt]) ? npc+BranchAddr : npc
                cuif.alu_code = ALU_SUB;
                cuif.ext_code   = SIGN_EXT;
                cuif.bne_en = 1'b1;
            end
            ADDI : begin
                // ADDI   $rt,$rs,imm   R[rt] <= R[rs] + SignExtImm
                cuif.alu_code = ALU_ADD;
                cuif.alu_src = 1'b1;
                cuif.ext_code = SIGN_EXT; //
                cuif.reg_dst = 1'b0;     // see instruction declaration
                cuif.reg_wr = 1'b1;      // need to write to regFile[rt]
            end
            ADDIU : begin
                // ADDIU  $rt,$rs,imm   R[rt] <= R[rs] + SignExtImm (unchecked overflow)
                cuif.alu_code = ALU_ADD;
                cuif.alu_src = 1'b1;
                cuif.ext_code = SIGN_EXT;
                cuif.reg_dst = 1'b0;     // see instruction declaration
                cuif.reg_wr = 1'b1;      // need to write to regFile[rt]
            end
            SLTI : begin
                // SLTI   $rt,$rs,imm   R[rt] <= (R[rs] < SignExtImm) ? 1 : 0
                cuif.alu_code = ALU_SLT;
                cuif.alu_src = 1'b1;
                cuif.ext_code = SIGN_EXT;
                cuif.reg_dst = 1'b0;     // see instruction declaration
                cuif.reg_wr = 1'b1;      // need to write to regFile[rt]
            end
            SLTIU : begin
                // SLTIU  $rt,$rs,imm   R[rt] <= (R[rs] < SignExtImm) ? 1 : 0
                cuif.alu_code = ALU_SLTU;
                cuif.alu_src = 1'b1;
                cuif.ext_code = SIGN_EXT;
                cuif.reg_dst = 1'b0;     // see instruction declaration
                cuif.reg_wr = 1'b1;      // need to write to regFile[rt]
            end
            ANDI : begin
                // ANDI   $rt,$rs,imm   R[rt] <= R[rs] & ZeroExtImm
                cuif.alu_code = ALU_AND;
                cuif.alu_src = 1'b1;
                cuif.ext_code = ZERO_EXT;
                cuif.reg_dst = 1'b0;     // see instruction declaration
                cuif.reg_wr = 1'b1;      // need to write to regFile[rt]
            end
            ORI : begin
                // ORI    $rt,$rs,imm   R[rt] <= R[rs] OR ZeroExtImm
                cuif.alu_code = ALU_OR;
                cuif.alu_src = 1'b1;
                cuif.ext_code = ZERO_EXT;
                cuif.reg_dst = 1'b0;     // see instruction declaration
                cuif.reg_wr = 1'b1;      // need to write to regFile[rt]
            end
            XORI : begin
                // XORI   $rt,$rs,imm   R[rt] <= R[rs] XOR ZeroExtImm
                cuif.alu_code = ALU_XOR;
                cuif.alu_src = 1'b1;
                cuif.ext_code = ZERO_EXT;
                cuif.reg_dst = 1'b0;     // see instruction declaration
                cuif.reg_wr = 1'b1;      // need to write to regFile[rt]
            end
            LUI : begin
                // LUI    $rt,imm       R[rt] <= {imm, 16b'0}
                cuif.alu_src = 1'b1;
                cuif.ext_code = LUI_EXT;
                cuif.reg_dst = 1'b0;     // see instruction declaration
                cuif.reg_wr = 1'b1;      // need to write to regFile[rt]
                cuif.lui_en = 1'b1;      // allow output of Extender to go directly into regFile
            end
            LW : begin
                // LW     $rt,imm($rs)  R[rt] <= M[R[rs] + SignExtImm]
                cuif.alu_code = ALU_ADD;
                cuif.ext_code = SIGN_EXT;
                cuif.reg_dst = 1'b0;     // see instruction declaration
                cuif.alu_src = 1'b1;
                cuif.mem_wr = 1'b0;
                cuif.mem_to_reg = 1'b1;
                cuif.reg_wr = 1'b1;
            end
            LBU : begin
                // SKIP
            end
            LHU : begin
                // SKIP
            end
            SB : begin
                // SKIP
            end
            SH : begin
                // SKIP
            end
            LL : begin
                // LL     $rt,imm($rs)  R[rt] <= M[R[rs] + SignExtImm]; rmwstate <= addr
                cuif.alu_code = ALU_ADD;
                cuif.ext_code = SIGN_EXT;
                cuif.reg_dst = 1'b0;     // see instruction declaration
                cuif.alu_src = 1'b1;
                cuif.mem_wr = 1'b0;
                cuif.mem_to_reg = 1'b1;
                cuif.reg_wr = 1'b1;
                cuif.d_atomic = 1'b1;
            end
            SC : begin
                // SC $rt,imm($rs)if (rmw) M[R[rs] + SignExtImm] <= R[rt], R[rt] <= 1 else R[rt] <= 0
                cuif.alu_code = ALU_ADD;
                cuif.ext_code = SIGN_EXT;
                cuif.mem_wr = 1'b1;
                cuif.alu_src = 1'b1;
                cuif.reg_wr = 1'b1;
                cuif.mem_to_reg = 1'b1;
                cuif.d_atomic = 1'b1;
            end
            SW : begin
                // SW     $rt,imm($rs)  M[R[rs] + SignExtImm] <= R[rt]
                cuif.alu_code = ALU_ADD;
                cuif.ext_code = SIGN_EXT;
                cuif.mem_wr = 1'b1;
                cuif.alu_src = 1'b1;
                cuif.reg_wr = 1'b0;
                cuif.mem_to_reg = 1'b0;
            end
            HALT : begin
                cuif.halt = 1'b1;
            end

            /************************* J - type ***************************/
            J : begin
                // J      label         PC <= JumpAddr
                cuif.jump_en = 1'b1;
            end
            JAL : begin
                // JAL    label         R[31] <= npc; PC <= JumpAddr
                cuif.jump_en = 1'b1;
                cuif.jal_en = 1'b1;
                cuif.reg_wr = 1'b1;
            end
        endcase
    end  // end always_comb

endmodule : control_unit
