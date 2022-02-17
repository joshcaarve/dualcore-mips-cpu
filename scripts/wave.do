onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -group RegFile -expand /system_tb/DUT/CPU/DP/REGISTER_FILE/regFile
add wave -noupdate -expand -group ALU_Signals /system_tb/DUT/CPU/DP/alif/aluop
add wave -noupdate -expand -group ALU_Signals /system_tb/DUT/CPU/DP/alif/portOut
add wave -noupdate -expand -group ALU_Signals /system_tb/DUT/CPU/DP/alif/portB
add wave -noupdate -expand -group ALU_Signals /system_tb/DUT/CPU/DP/alif/portA
add wave -noupdate -group {final latch REG signals} /system_tb/DUT/CPU/DP/mwif/reg_wr_out
add wave -noupdate -group {final latch REG signals} /system_tb/DUT/CPU/DP/mwif/reg_wr_addr_out
add wave -noupdate -group {final latch REG signals} /system_tb/DUT/CPU/DP/mwif/reg_dst_out
add wave -noupdate -group {final latch REG signals} /system_tb/DUT/CPU/DP/mwif/imm_16_out
add wave -noupdate -group {final latch REG signals} /system_tb/DUT/CPU/DP/mwif/halt_out
add wave -noupdate /system_tb/DUT/CPU/DP/mwif/op_code_out
add wave -noupdate -expand -group {Control Unit Signals} /system_tb/DUT/CPU/DP/cuif/instruction
add wave -noupdate -expand -group {Control Unit Signals} /system_tb/DUT/CPU/DP/cuif/reg_dst
add wave -noupdate -expand -group {Control Unit Signals} /system_tb/DUT/CPU/DP/cuif/ext_code
add wave -noupdate -expand -group {Control Unit Signals} /system_tb/DUT/CPU/DP/cuif/alu_code
add wave -noupdate -expand -group {Control Unit Signals} /system_tb/DUT/CPU/DP/cuif/op_code
add wave -noupdate -expand -group {Control Unit Signals} /system_tb/DUT/CPU/DP/cuif/funct_code
add wave -noupdate -expand -group {Control Unit Signals} /system_tb/DUT/CPU/DP/cuif/halt
add wave -noupdate -expand -group {Control Unit Signals} /system_tb/DUT/CPU/DP/cuif/mem_to_reg
add wave -noupdate -expand -group {Control Unit Signals} /system_tb/DUT/CPU/DP/cuif/alu_src
add wave -noupdate -expand -group {Control Unit Signals} /system_tb/DUT/CPU/DP/cuif/reg_wr
add wave -noupdate -expand -group {Control Unit Signals} /system_tb/DUT/CPU/DP/cuif/mem_wr
add wave -noupdate -expand -group {Control Unit Signals} /system_tb/DUT/CPU/DP/cuif/jr_en
add wave -noupdate -expand -group {Control Unit Signals} /system_tb/DUT/CPU/DP/cuif/jump_en
add wave -noupdate -expand -group {Control Unit Signals} /system_tb/DUT/CPU/DP/cuif/lui_en
add wave -noupdate -expand -group {Control Unit Signals} /system_tb/DUT/CPU/DP/cuif/jal_en
add wave -noupdate -expand -group {Control Unit Signals} /system_tb/DUT/CPU/DP/cuif/beq_en
add wave -noupdate -expand -group {Control Unit Signals} /system_tb/DUT/CPU/DP/cuif/bne_en
add wave -noupdate -expand -group {Control Unit Signals} /system_tb/DUT/CPU/DP/cuif/rt
add wave -noupdate -expand -group {Control Unit Signals} /system_tb/DUT/CPU/DP/cuif/rs
add wave -noupdate -expand -group {Control Unit Signals} /system_tb/DUT/CPU/DP/cuif/rd
add wave -noupdate -expand -group {Control Unit Signals} /system_tb/DUT/CPU/DP/cuif/shamt
add wave -noupdate -expand -group {Control Unit Signals} /system_tb/DUT/CPU/DP/cuif/imm_16
add wave -noupdate -expand -group {Control Unit Signals} /system_tb/DUT/CPU/DP/cuif/imm_26
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/dpif/halt
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/dpif/flushed
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/dpif/dmemaddr
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate -expand -group Fetch/Decode /system_tb/DUT/CPU/DP/fdif/update
add wave -noupdate -expand -group Fetch/Decode /system_tb/DUT/CPU/DP/fdif/flush
add wave -noupdate -expand -group Fetch/Decode /system_tb/DUT/CPU/DP/fdif/normal_pc_in
add wave -noupdate -expand -group Fetch/Decode /system_tb/DUT/CPU/DP/fdif/instruction_in
add wave -noupdate -expand -group Fetch/Decode /system_tb/DUT/CPU/DP/fdif/next_pc_in
add wave -noupdate -expand -group Fetch/Decode /system_tb/DUT/CPU/DP/fdif/instruction_out
add wave -noupdate -expand -group Fetch/Decode /system_tb/DUT/CPU/DP/fdif/normal_pc_out
add wave -noupdate -expand -group Fetch/Decode /system_tb/DUT/CPU/DP/fdif/next_pc_out
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/bus_a_out
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/bus_a_in
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/halt_out
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/op_code_in
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/op_code_out
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/normal_pc_out
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/normal_pc_in
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/flush
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/update
add wave -noupdate -group Execute/Memory /system_tb/DUT/CPU/DP/emif/op_code_in
add wave -noupdate -group Execute/Memory /system_tb/DUT/CPU/DP/emif/halt_in
add wave -noupdate -group Execute/Memory /system_tb/DUT/CPU/DP/emif/halt_out
add wave -noupdate -group Execute/Memory /system_tb/DUT/CPU/DP/emif/op_code_out
add wave -noupdate -group Execute/Memory /system_tb/DUT/CPU/DP/emif/flush
add wave -noupdate -group Execute/Memory /system_tb/DUT/CPU/DP/emif/alu_out_out
add wave -noupdate -group Execute/Memory /system_tb/DUT/CPU/DP/emif/mem_to_reg_in
add wave -noupdate -group Execute/Memory /system_tb/DUT/CPU/DP/emif/mem_to_reg_out
add wave -noupdate -group Execute/Memory /system_tb/DUT/CPU/DP/emif/update
add wave -noupdate -expand -group mem/WB /system_tb/DUT/CPU/DP/mwif/instruction_in
add wave -noupdate -expand -group mem/WB /system_tb/DUT/CPU/DP/mwif/instruction_out
add wave -noupdate -expand -group mem/WB /system_tb/DUT/CPU/DP/mwif/mem_to_reg_in
add wave -noupdate -expand -group mem/WB /system_tb/DUT/CPU/DP/mwif/mem_to_reg_out
add wave -noupdate -expand -group mem/WB /system_tb/DUT/CPU/DP/mwif/read_data_out
add wave -noupdate -expand -group mem/WB /system_tb/DUT/CPU/DP/mwif/reg_wr_out
add wave -noupdate -expand -group mem/WB /system_tb/DUT/CPU/DP/mwif/reg_wr_addr_in
add wave -noupdate -expand -group mem/WB /system_tb/DUT/CPU/DP/mwif/reg_wr_addr_out
add wave -noupdate -expand -group mem/WB /system_tb/DUT/CPU/DP/mwif/op_code_in
add wave -noupdate -expand -group mem/WB /system_tb/DUT/CPU/DP/mwif/op_code_out
add wave -noupdate -expand -group mem/WB /system_tb/DUT/CPU/DP/mwif/flush
add wave -noupdate -expand -group mem/WB /system_tb/DUT/CPU/DP/mwif/update
add wave -noupdate -expand -group mem/WB /system_tb/DUT/CPU/DP/mwif/imm_16_in
add wave -noupdate -expand -group mem/WB /system_tb/DUT/CPU/DP/mwif/imm_16_out
add wave -noupdate -expand -group mem/WB /system_tb/DUT/CPU/DP/mwif/halt_out
add wave -noupdate /system_tb/DUT/CPU/DP/CLK
add wave -noupdate -expand -group HAZARD_UNIT /system_tb/DUT/CPU/DP/huif/ihit
add wave -noupdate -expand -group HAZARD_UNIT /system_tb/DUT/CPU/DP/huif/execute_reg_wr_addr
add wave -noupdate -expand -group HAZARD_UNIT /system_tb/DUT/CPU/DP/huif/memory_reg_wr_addr
add wave -noupdate -expand -group HAZARD_UNIT /system_tb/DUT/CPU/DP/huif/decode_reg_wr_en
add wave -noupdate -expand -group HAZARD_UNIT /system_tb/DUT/CPU/DP/huif/decode_reg_dst
add wave -noupdate -expand -group HAZARD_UNIT /system_tb/DUT/CPU/DP/huif/execute_reg_wr_en
add wave -noupdate -expand -group HAZARD_UNIT /system_tb/DUT/CPU/DP/huif/memory_reg_wr_en
add wave -noupdate -expand -group HAZARD_UNIT /system_tb/DUT/CPU/DP/huif/decode_rt
add wave -noupdate -expand -group HAZARD_UNIT /system_tb/DUT/CPU/DP/huif/decode_rs
add wave -noupdate -expand -group HAZARD_UNIT /system_tb/DUT/CPU/DP/huif/decode_instruction
add wave -noupdate -expand -group HAZARD_UNIT /system_tb/DUT/CPU/DP/huif/memory_jump_en
add wave -noupdate -expand -group HAZARD_UNIT /system_tb/DUT/CPU/DP/huif/memory_jump_r_en
add wave -noupdate -expand -group HAZARD_UNIT /system_tb/DUT/CPU/DP/huif/memory_pc_src
add wave -noupdate -expand -group HAZARD_UNIT /system_tb/DUT/CPU/DP/huif/fetch_decode_flush
add wave -noupdate -expand -group HAZARD_UNIT /system_tb/DUT/CPU/DP/huif/decode_execute_flush
add wave -noupdate -expand -group HAZARD_UNIT /system_tb/DUT/CPU/DP/huif/execute_memory_flush
add wave -noupdate -expand -group HAZARD_UNIT /system_tb/DUT/CPU/DP/huif/memory_write_back_flush
add wave -noupdate -expand -group HAZARD_UNIT /system_tb/DUT/CPU/DP/huif/fetch_decode_enable
add wave -noupdate -expand -group HAZARD_UNIT /system_tb/DUT/CPU/DP/huif/decode_execute_enable
add wave -noupdate -expand -group HAZARD_UNIT /system_tb/DUT/CPU/DP/huif/execute_memory_enable
add wave -noupdate -expand -group HAZARD_UNIT /system_tb/DUT/CPU/DP/mwif/alu_out_out
add wave -noupdate -expand -group HAZARD_UNIT /system_tb/DUT/CPU/DP/rgif/rdat1
add wave -noupdate -expand -group HAZARD_UNIT /system_tb/DUT/CPU/DP/rgif/rsel1
add wave -noupdate -expand -group HAZARD_UNIT /system_tb/DUT/CPU/DP/rgif/rdat2
add wave -noupdate -expand -group HAZARD_UNIT /system_tb/DUT/CPU/DP/rgif/rsel2
add wave -noupdate -expand -group HAZARD_UNIT /system_tb/DUT/CPU/DP/cuif/alu_src
add wave -noupdate -expand -group HAZARD_UNIT -expand -group Comparisions /system_tb/DUT/CPU/DP/HAZARD_UNIT/operand1
add wave -noupdate -expand -group HAZARD_UNIT -expand -group Comparisions /system_tb/DUT/CPU/DP/HAZARD_UNIT/operand2
add wave -noupdate -expand -group HAZARD_UNIT -expand -group Comparisions /system_tb/DUT/CPU/DP/HAZARD_UNIT/result_execute
add wave -noupdate -expand -group HAZARD_UNIT -expand -group Comparisions /system_tb/DUT/CPU/DP/HAZARD_UNIT/result_memory
add wave -noupdate -expand -group HAZARD_UNIT /system_tb/DUT/CPU/DP/huif/memory_write_back_enable
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {482761 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 196
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {768749 ps}
