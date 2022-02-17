onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/DUT/CPUCLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -divider <NULL>
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/memREN
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/memWEN
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/memaddr
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/memstore
add wave -noupdate -expand -group ARIF /system_tb/DUT/CPU/CC/arif/iREN
add wave -noupdate -expand -group ARIF /system_tb/DUT/CPU/CC/arif/iwait
add wave -noupdate -expand -group ARIF /system_tb/DUT/CPU/CC/arif/iaddr
add wave -noupdate -expand -group ARIF /system_tb/DUT/CPU/CC/arif/iload
add wave -noupdate -expand -group ARIF /system_tb/DUT/CPU/CC/arif/dREN
add wave -noupdate -expand -group ARIF /system_tb/DUT/CPU/CC/arif/dWEN
add wave -noupdate -expand -group ARIF /system_tb/DUT/CPU/CC/arif/dwait
add wave -noupdate -expand -group ARIF /system_tb/DUT/CPU/CC/arif/dstore
add wave -noupdate -expand -group ARIF /system_tb/DUT/CPU/CC/arif/daddr
add wave -noupdate -expand -group ARIF /system_tb/DUT/CPU/CC/arif/dload
add wave -noupdate -expand -group ARIF /system_tb/DUT/CPU/CC/arif/ramstate
add wave -noupdate -expand -group ARIF /system_tb/DUT/CPU/CC/arif/ramstore
add wave -noupdate -expand -group ARIF /system_tb/DUT/CPU/CC/arif/ramload
add wave -noupdate -expand -group ARIF /system_tb/DUT/CPU/CC/arif/ramWEN
add wave -noupdate -expand -group ARIF /system_tb/DUT/CPU/CC/arif/ramREN
add wave -noupdate -expand -group ARIF /system_tb/DUT/CPU/CC/arif/ramaddr
add wave -noupdate -group I_BUS /system_tb/DUT/CPU/CC/I_BUS/select
add wave -noupdate -group I_BUS /system_tb/DUT/CPU/CC/I_BUS/next_select
add wave -noupdate -group I_BUS /system_tb/DUT/CPU/CC/arif/iwait
add wave -noupdate -group I_BUS -expand /system_tb/DUT/CPU/CC/I_BUS/ibif/iREN
add wave -noupdate -group I_BUS -expand /system_tb/DUT/CPU/CC/I_BUS/ibif/iaddr
add wave -noupdate -group I_BUS /system_tb/DUT/CPU/CC/I_BUS/ibif/iload
add wave -noupdate -group I_BUS /system_tb/DUT/CPU/CC/I_BUS/ibif/iwait
add wave -noupdate -group I_BUS /system_tb/DUT/CPU/CC/I_BUS/ibif/iREN_out
add wave -noupdate -group I_BUS /system_tb/DUT/CPU/CC/I_BUS/ibif/iaddr_out
add wave -noupdate -group I_BUS /system_tb/DUT/CPU/CC/I_BUS/ibif/iload_out
add wave -noupdate -group I_BUS -expand /system_tb/DUT/CPU/CC/I_BUS/ibif/iwait_out
add wave -noupdate /system_tb/DUT/CPU/CC/D_BUS/magic_mask
add wave -noupdate -expand /system_tb/DUT/CPU/ccif/dwait
add wave -noupdate -expand -group D_BUS /system_tb/DUT/CPU/CC/D_BUS/state
add wave -noupdate -expand -group D_BUS /system_tb/DUT/CPU/CC/D_BUS/next_state
add wave -noupdate -expand -group D_BUS -group CCSIGNALS /system_tb/DUT/CPU/CC/D_BUS/snoopaddr
add wave -noupdate -expand -group D_BUS -group CCSIGNALS /system_tb/DUT/CPU/CC/D_BUS/ccwrite
add wave -noupdate -expand -group D_BUS -group CCSIGNALS /system_tb/DUT/CPU/CC/D_BUS/ccwait
add wave -noupdate -expand -group D_BUS -group CCSIGNALS /system_tb/DUT/CPU/CC/D_BUS/cctrans
add wave -noupdate -expand -group D_BUS -group CCSIGNALS /system_tb/DUT/CPU/CC/D_BUS/inv
add wave -noupdate -expand -group D_BUS /system_tb/DUT/CPU/CC/D_BUS/select
add wave -noupdate -expand -group D_BUS /system_tb/DUT/CPU/CC/D_BUS/next_select
add wave -noupdate -expand -group D_BUS -expand -group {interfacing signals} /system_tb/DUT/CPU/CC/D_BUS/dbif/ramwait
add wave -noupdate -expand -group D_BUS -expand -group {interfacing signals} -expand /system_tb/DUT/CPU/CC/D_BUS/dbif/dwait
add wave -noupdate -expand -group D_BUS -expand -group {interfacing signals} -expand /system_tb/DUT/CPU/CC/D_BUS/dbif/dstore
add wave -noupdate -expand -group D_BUS -expand -group {interfacing signals} /system_tb/DUT/CPU/CC/D_BUS/dbif/dramstore
add wave -noupdate -expand -group D_BUS -expand -group {interfacing signals} /system_tb/DUT/CPU/CC/D_BUS/dbif/dramload
add wave -noupdate -expand -group D_BUS -expand -group {interfacing signals} /system_tb/DUT/CPU/CC/D_BUS/dbif/dramaddr
add wave -noupdate -expand -group D_BUS -expand -group {interfacing signals} /system_tb/DUT/CPU/CC/D_BUS/dbif/dramWEN
add wave -noupdate -expand -group D_BUS -expand -group {interfacing signals} /system_tb/DUT/CPU/CC/D_BUS/dbif/dramREN
add wave -noupdate -expand -group D_BUS -expand -group {interfacing signals} -color Orchid /system_tb/DUT/CPU/CC/D_BUS/dbif/dload
add wave -noupdate -expand -group D_BUS -expand -group {interfacing signals} -expand /system_tb/DUT/CPU/CC/D_BUS/dbif/daddr
add wave -noupdate -expand -group D_BUS -expand -group {interfacing signals} -expand /system_tb/DUT/CPU/CC/D_BUS/dbif/dWEN
add wave -noupdate -expand -group D_BUS -expand -group {interfacing signals} -expand /system_tb/DUT/CPU/CC/D_BUS/dbif/dREN
add wave -noupdate -expand -group D_BUS -expand -group {interfacing signals} -expand /system_tb/DUT/CPU/CC/D_BUS/dbif/ccwrite
add wave -noupdate -expand -group D_BUS -expand -group {interfacing signals} -expand /system_tb/DUT/CPU/CC/D_BUS/dbif/ccwait
add wave -noupdate -expand -group D_BUS -expand -group {interfacing signals} /system_tb/DUT/CPU/CC/D_BUS/dbif/cctrans
add wave -noupdate -expand -group D_BUS -expand -group {interfacing signals} /system_tb/DUT/CPU/CC/D_BUS/dbif/ccsnoopaddr
add wave -noupdate -expand -group D_BUS -expand -group {interfacing signals} /system_tb/DUT/CPU/CC/D_BUS/dbif/ccinv
add wave -noupdate /system_tb/DUT/CPU/ccif/daddr
add wave -noupdate -divider {PROCESSOR 0}
add wave -noupdate /system_tb/DUT/CPUCLK
add wave -noupdate -expand /system_tb/DUT/CPU/ccif/dwait
add wave -noupdate -expand -group DP_0_IN_OUT /system_tb/DUT/CPU/DP0/dpif/halt
add wave -noupdate -expand -group DP_0_IN_OUT /system_tb/DUT/CPU/DP0/dpif/ihit
add wave -noupdate -expand -group DP_0_IN_OUT /system_tb/DUT/CPU/DP0/dpif/imemREN
add wave -noupdate -expand -group DP_0_IN_OUT /system_tb/DUT/CPU/DP0/dpif/imemload
add wave -noupdate -expand -group DP_0_IN_OUT /system_tb/DUT/CPU/DP0/dpif/imemaddr
add wave -noupdate -expand -group DP_0_IN_OUT -color Magenta /system_tb/DUT/CPU/DP0/dpif/dhit
add wave -noupdate -expand -group DP_0_IN_OUT -color Cyan /system_tb/DUT/CPU/DP0/dpif/dmemREN
add wave -noupdate -expand -group DP_0_IN_OUT /system_tb/DUT/CPU/CM0/dcif/datomic
add wave -noupdate -expand -group DP_0_IN_OUT -color Cyan /system_tb/DUT/CPU/DP0/dpif/dmemWEN
add wave -noupdate -expand -group DP_0_IN_OUT -color Red /system_tb/DUT/CPU/DP0/dpif/flushed
add wave -noupdate -expand -group DP_0_IN_OUT /system_tb/DUT/CPU/DP0/dpif/dmemload
add wave -noupdate -expand -group DP_0_IN_OUT /system_tb/DUT/CPU/DP0/dpif/dmemstore
add wave -noupdate -expand -group DP_0_IN_OUT /system_tb/DUT/CPU/DP0/dpif/dmemaddr
add wave -noupdate -group ICACHE0 /system_tb/DUT/CPU/CM0/ICACHE/state
add wave -noupdate -group ICACHE0 /system_tb/DUT/CPU/CM0/ICACHE/next_state
add wave -noupdate -group ICACHE0 /system_tb/DUT/CPU/CM0/ICACHE/icachef
add wave -noupdate -group ICACHE0 /system_tb/DUT/CPU/CM0/ICACHE/hit
add wave -noupdate -group ICACHE0 -expand /system_tb/DUT/CPU/CM0/ICACHE/icache
add wave -noupdate -group ICACHE0 /system_tb/DUT/CPU/CM0/ICACHE/next_icache
add wave -noupdate -group ICACHE0 /system_tb/DUT/CPU/CM0/ICACHE/halt
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/dcachef
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/next_lru
add wave -noupdate -expand -group DCACHE0 -color Magenta -itemcolor White -expand -subitemconfig {{/system_tb/DUT/CPU/CM0/DCACHE/next_cache[7]} {-color Magenta -height 17 -itemcolor White} {/system_tb/DUT/CPU/CM0/DCACHE/next_cache[6]} {-color Magenta -height 17 -itemcolor White} {/system_tb/DUT/CPU/CM0/DCACHE/next_cache[5]} {-color Magenta -height 17 -itemcolor White} {/system_tb/DUT/CPU/CM0/DCACHE/next_cache[4]} {-color Magenta -height 17 -itemcolor White} {/system_tb/DUT/CPU/CM0/DCACHE/next_cache[3]} {-color Magenta -height 17 -itemcolor White} {/system_tb/DUT/CPU/CM0/DCACHE/next_cache[2]} {-color Magenta -height 17 -itemcolor White} {/system_tb/DUT/CPU/CM0/DCACHE/next_cache[1]} {-color Magenta -height 17 -itemcolor White} {/system_tb/DUT/CPU/CM0/DCACHE/next_cache[0]} {-color Magenta -height 17 -itemcolor White}} /system_tb/DUT/CPU/CM0/DCACHE/next_cache
add wave -noupdate -expand -group DCACHE0 -expand /system_tb/DUT/CPU/CM0/DCACHE/cache
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/lru
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/state
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/next_state
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/limit
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/next_limit
add wave -noupdate -expand -group DCACHE0 -color {Medium Orchid} /system_tb/DUT/CPU/CM0/DCACHE/true_addr
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/atomic_reg
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/left
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/right
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/hit
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/chosen_frame
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/match
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/active
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/snoop_addr
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/instruction_in
add wave -noupdate -group {DEIF C0} -group {branch stuff} /system_tb/DUT/CPU/DP0/deif/normal_pc_in
add wave -noupdate -group {DEIF C0} -group {branch stuff} /system_tb/DUT/CPU/DP0/deif/next_pc_in
add wave -noupdate -group {DEIF C0} -group {branch stuff} /system_tb/DUT/CPU/DP0/deif/jr_en_in
add wave -noupdate -group {DEIF C0} -group {branch stuff} /system_tb/DUT/CPU/DP0/deif/jump_en_in
add wave -noupdate -group {DEIF C0} -group {branch stuff} /system_tb/DUT/CPU/DP0/deif/jal_en_in
add wave -noupdate -group {DEIF C0} -group {branch stuff} /system_tb/DUT/CPU/DP0/deif/beq_en_in
add wave -noupdate -group {DEIF C0} -group {branch stuff} /system_tb/DUT/CPU/DP0/deif/bne_en_in
add wave -noupdate -group {DEIF C0} -group {branch stuff} /system_tb/DUT/CPU/DP0/deif/normal_pc_out
add wave -noupdate -group {DEIF C0} -group {branch stuff} /system_tb/DUT/CPU/DP0/deif/jr_en_out
add wave -noupdate -group {DEIF C0} -group {branch stuff} /system_tb/DUT/CPU/DP0/deif/jump_en_out
add wave -noupdate -group {DEIF C0} -group {branch stuff} /system_tb/DUT/CPU/DP0/deif/lui_en_out
add wave -noupdate -group {DEIF C0} -group {branch stuff} /system_tb/DUT/CPU/DP0/deif/jal_en_out
add wave -noupdate -group {DEIF C0} -group {branch stuff} /system_tb/DUT/CPU/DP0/deif/beq_en_out
add wave -noupdate -group {DEIF C0} -group {branch stuff} /system_tb/DUT/CPU/DP0/deif/bne_en_out
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/bus_a_in
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/bus_b_in
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/imm_32_in
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/imm_26_in
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/imm_16_in
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/shamt_in
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/op_code_in
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/alu_code_in
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/funct_code_in
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/halt_in
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/alu_src_in
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/reg_dst_in
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/mem_to_reg_in
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/reg_wr_in
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/mem_wr_in
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/lui_en_in
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/rd_in
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/rt_in
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/rs_in
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/instruction_out
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/next_pc_out
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/bus_a_out
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/bus_b_out
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/imm_32_out
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/imm_26_out
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/imm_16_out
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/shamt_out
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/op_code_out
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/alu_code_out
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/funct_code_out
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/halt_out
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/alu_src_out
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/reg_dst_out
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/mem_to_reg_out
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/reg_wr_out
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/mem_wr_out
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/rd_out
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/rt_out
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/rs_out
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/flush
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/update
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/d_atomic_in
add wave -noupdate -group {DEIF C0} /system_tb/DUT/CPU/DP0/deif/d_atomic_out
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} /system_tb/DUT/CPU/DP0/emif/flush
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} /system_tb/DUT/CPU/DP0/emif/update
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} /system_tb/DUT/CPU/DP0/emif/dhit
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/jal_en_in
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/jal_en_out
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/beq_en_in
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/beq_en_out
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/bne_en_in
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/bne_en_out
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/jr_en_in
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/jr_en_out
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/jump_en_in
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/jump_en_out
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/equal_in
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/equal_out
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/imm_26
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/instruction_in
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/instruction_out
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/alu_out_in
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/alu_out_out
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/imm_32_in
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/imm_32_out
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/normal_pc_in
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/normal_pc_out
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/branch_pc_in
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/branch_pc_out
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/jump_pc_in
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/jump_pc_out
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/jump_r_pc_in
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/jump_r_pc_out
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/imm_16_in
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group {Branch/PC resolve} /system_tb/DUT/CPU/DP0/emif/imm_16_out
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group ALU_SIGNALS /system_tb/DUT/CPU/DP0/emif/bus_b_in
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group ALU_SIGNALS /system_tb/DUT/CPU/DP0/emif/bus_b_out
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group ALU_SIGNALS /system_tb/DUT/CPU/DP0/emif/funct_code_in
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group ALU_SIGNALS /system_tb/DUT/CPU/DP0/emif/funct_code_out
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} /system_tb/DUT/CPU/DP0/emif/mem_to_reg_in
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} /system_tb/DUT/CPU/DP0/emif/mem_to_reg_out
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} /system_tb/DUT/CPU/DP0/emif/mem_wr_in
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} /system_tb/DUT/CPU/DP0/emif/mem_wr_out
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} /system_tb/DUT/CPU/DP0/emif/lui_en_in
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} /system_tb/DUT/CPU/DP0/emif/lui_en_out
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} /system_tb/DUT/CPU/DP0/emif/halt_in
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} /system_tb/DUT/CPU/DP0/emif/halt_out
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group Registers /system_tb/DUT/CPU/DP0/emif/rt_in
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group Registers /system_tb/DUT/CPU/DP0/emif/rt_out
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group Registers /system_tb/DUT/CPU/DP0/emif/rs_in
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group Registers /system_tb/DUT/CPU/DP0/emif/rs_out
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group Registers /system_tb/DUT/CPU/DP0/emif/reg_wr_addr_in
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group Registers /system_tb/DUT/CPU/DP0/emif/reg_wr_addr_out
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group Registers /system_tb/DUT/CPU/DP0/emif/reg_wr_in
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group Registers /system_tb/DUT/CPU/DP0/emif/reg_wr_out
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group Registers /system_tb/DUT/CPU/DP0/emif/reg_dst_in
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} -group Registers /system_tb/DUT/CPU/DP0/emif/reg_dst_out
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} /system_tb/DUT/CPU/DP0/emif/next_pc_in
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} /system_tb/DUT/CPU/DP0/emif/next_pc_out
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} /system_tb/DUT/CPU/DP0/emif/op_code_in
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} /system_tb/DUT/CPU/DP0/emif/op_code_out
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} /system_tb/DUT/CPU/DP0/emif/shamt_in
add wave -noupdate -expand -group {EMIF-MEM LATCH-C0} /system_tb/DUT/CPU/DP0/emif/shamt_out
add wave -noupdate -group {FORWARDING UNIT} /system_tb/DUT/CPU/DP0/fuif/execute_instruction
add wave -noupdate -group {FORWARDING UNIT} /system_tb/DUT/CPU/DP0/fuif/execute_rt
add wave -noupdate -group {FORWARDING UNIT} /system_tb/DUT/CPU/DP0/fuif/execute_rs
add wave -noupdate -group {FORWARDING UNIT} /system_tb/DUT/CPU/DP0/fuif/execute_alu_src
add wave -noupdate -group {FORWARDING UNIT} /system_tb/DUT/CPU/DP0/fuif/execute_reg_dst
add wave -noupdate -group {FORWARDING UNIT} /system_tb/DUT/CPU/DP0/fuif/execute_reg_wr_en
add wave -noupdate -group {FORWARDING UNIT} /system_tb/DUT/CPU/DP0/fuif/memory_reg_wr_addr
add wave -noupdate -group {FORWARDING UNIT} /system_tb/DUT/CPU/DP0/fuif/memory_reg_wr_en
add wave -noupdate -group {FORWARDING UNIT} /system_tb/DUT/CPU/DP0/fuif/memory_mem_to_reg
add wave -noupdate -group {FORWARDING UNIT} /system_tb/DUT/CPU/DP0/fuif/write_back_reg_wr_addr
add wave -noupdate -group {FORWARDING UNIT} /system_tb/DUT/CPU/DP0/fuif/write_back_reg_wr_en
add wave -noupdate -group {FORWARDING UNIT} /system_tb/DUT/CPU/DP0/fuif/bus_a_control
add wave -noupdate -group {FORWARDING UNIT} /system_tb/DUT/CPU/DP0/fuif/bus_b_control
add wave -noupdate -expand -group REGFILE0 -expand /system_tb/DUT/CPU/DP0/REGISTER_FILE/regFile
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/ihit
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/dhit
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/execute_reg_wr_addr
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/memory_reg_wr_addr
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/decode_reg_wr_en
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/decode_reg_dst
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/execute_reg_wr_en
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/memory_reg_wr_en
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/decode_rt
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/decode_rs
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/decode_instruction
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/execute_op_code
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/memory_op_code
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/memory_jump_en
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/memory_jump_r_en
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/memory_pc_src
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/memory_bne
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/memory_beq
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/fetch_decode_flush
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/decode_execute_flush
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/execute_memory_flush
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/memory_write_back_flush
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/fetch_decode_enable
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/decode_execute_enable
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/execute_memory_enable
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/memory_write_back_enable
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/decode_execute_conflict
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/decode_memory_conflict
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/is_mem
add wave -noupdate -group HAZARDUNIT /system_tb/DUT/CPU/DP0/huif/hazard
add wave -noupdate -divider {PROCESSOR 1}
add wave -noupdate /system_tb/DUT/CPUCLK
add wave -noupdate -expand -group DP_1_IN_OUT /system_tb/DUT/CPU/DP1/dpif/halt
add wave -noupdate -expand -group DP_1_IN_OUT /system_tb/DUT/CPU/DP1/dpif/ihit
add wave -noupdate -expand -group DP_1_IN_OUT /system_tb/DUT/CPU/DP1/dpif/imemREN
add wave -noupdate -expand -group DP_1_IN_OUT /system_tb/DUT/CPU/DP1/dpif/imemload
add wave -noupdate -expand -group DP_1_IN_OUT /system_tb/DUT/CPU/DP1/dpif/imemaddr
add wave -noupdate -expand -group DP_1_IN_OUT /system_tb/DUT/CPU/DP1/dpif/dhit
add wave -noupdate -expand -group DP_1_IN_OUT /system_tb/DUT/CPU/DP1/dpif/dmemREN
add wave -noupdate -expand -group DP_1_IN_OUT /system_tb/DUT/CPU/DP1/dpif/dmemWEN
add wave -noupdate -expand -group DP_1_IN_OUT -color Red /system_tb/DUT/CPU/DP1/dpif/flushed
add wave -noupdate -expand -group DP_1_IN_OUT /system_tb/DUT/CPU/CM1/dcif/datomic
add wave -noupdate -expand -group DP_1_IN_OUT /system_tb/DUT/CPU/DP1/dpif/dmemload
add wave -noupdate -expand -group DP_1_IN_OUT /system_tb/DUT/CPU/DP1/dpif/dmemstore
add wave -noupdate -expand -group DP_1_IN_OUT /system_tb/DUT/CPU/DP1/dpif/dmemaddr
add wave -noupdate -expand -group ICACHE1 /system_tb/DUT/CPU/CM1/ICACHE/state
add wave -noupdate -expand -group ICACHE1 /system_tb/DUT/CPU/CM1/ICACHE/next_state
add wave -noupdate -expand -group ICACHE1 /system_tb/DUT/CPU/CM1/ICACHE/next_icache
add wave -noupdate -expand -group ICACHE1 /system_tb/DUT/CPU/CM1/ICACHE/icachef
add wave -noupdate -expand -group ICACHE1 /system_tb/DUT/CPU/CM1/ICACHE/icache
add wave -noupdate -expand -group ICACHE1 /system_tb/DUT/CPU/CM1/ICACHE/hit
add wave -noupdate -expand -group ICACHE1 /system_tb/DUT/CPU/CM1/ICACHE/halt
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/dcachef
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/ccif/dWEN
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/ccif/dREN
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/ccif/dstore
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/ccif/dload
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/ccif/daddr
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_lru
add wave -noupdate -expand -group DCACHE1 -color Magenta -expand -subitemconfig {{/system_tb/DUT/CPU/CM1/DCACHE/next_cache[7]} {-color Magenta -height 17} {/system_tb/DUT/CPU/CM1/DCACHE/next_cache[6]} {-color Magenta -height 17} {/system_tb/DUT/CPU/CM1/DCACHE/next_cache[5]} {-color Magenta -height 17} {/system_tb/DUT/CPU/CM1/DCACHE/next_cache[4]} {-color Magenta -height 17} {/system_tb/DUT/CPU/CM1/DCACHE/next_cache[3]} {-color Magenta -height 17} {/system_tb/DUT/CPU/CM1/DCACHE/next_cache[2]} {-color Magenta -height 17} {/system_tb/DUT/CPU/CM1/DCACHE/next_cache[1]} {-color Magenta -height 17} {/system_tb/DUT/CPU/CM1/DCACHE/next_cache[0]} {-color Magenta -height 17}} /system_tb/DUT/CPU/CM1/DCACHE/next_cache
add wave -noupdate -expand -group DCACHE1 -expand -subitemconfig {{/system_tb/DUT/CPU/CM1/DCACHE/cache[0]} -expand} /system_tb/DUT/CPU/CM1/DCACHE/cache
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/lru
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/state
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_state
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/true_addr
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/snoop_addr
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/chosen_frame
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/active
add wave -noupdate -expand -group DCACHE1 -color Cyan /system_tb/DUT/CPU/CM1/DCACHE/hit
add wave -noupdate -expand -group DCACHE1 -color {Cornflower Blue} /system_tb/DUT/CPU/CM1/DCACHE/match
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/atomic_reg
add wave -noupdate -expand -group DCACHE1 -color {Medium Orchid} /system_tb/DUT/CPU/CM1/DCACHE/limit
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_limit
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/left
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/right
add wave -noupdate -group {HZU C1} /system_tb/DUT/CPU/DP1/HAZARD_UNIT/decode_funct_code
add wave -noupdate -group {HZU C1} /system_tb/DUT/CPU/DP1/HAZARD_UNIT/decode_op_code
add wave -noupdate -group {HZU C1} /system_tb/DUT/CPU/DP1/HAZARD_UNIT/operand1
add wave -noupdate -group {HZU C1} /system_tb/DUT/CPU/DP1/HAZARD_UNIT/operand2
add wave -noupdate -group {HZU C1} /system_tb/DUT/CPU/DP1/HAZARD_UNIT/result_execute
add wave -noupdate -group {HZU C1} /system_tb/DUT/CPU/DP1/HAZARD_UNIT/result_memory
add wave -noupdate -group {HZU C1} /system_tb/DUT/CPU/DP1/huif/hazard
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/decode_execute_conflict
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/decode_execute_enable
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/decode_execute_flush
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/decode_instruction
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/decode_memory_conflict
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/decode_reg_dst
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/decode_reg_wr_en
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/decode_rs
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/decode_rt
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/dhit
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/execute_memory_enable
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/execute_memory_flush
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/execute_op_code
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/execute_reg_wr_addr
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/execute_reg_wr_en
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/fetch_decode_enable
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/fetch_decode_flush
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/ihit
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/is_mem
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/memory_beq
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/memory_bne
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/memory_jump_en
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/memory_jump_r_en
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/memory_op_code
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/memory_pc_src
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/memory_reg_wr_addr
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/memory_reg_wr_en
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/memory_write_back_enable
add wave -noupdate -group {HZU C1} -group Sub-sigs /system_tb/DUT/CPU/DP1/huif/memory_write_back_flush
add wave -noupdate -expand -group REGFILE1 -expand /system_tb/DUT/CPU/DP1/REGISTER_FILE/regFile
add wave -noupdate -group FORWU-C1 /system_tb/DUT/CPU/DP1/fuif/execute_instruction
add wave -noupdate -group FORWU-C1 /system_tb/DUT/CPU/DP1/fuif/execute_rt
add wave -noupdate -group FORWU-C1 /system_tb/DUT/CPU/DP1/fuif/execute_rs
add wave -noupdate -group FORWU-C1 /system_tb/DUT/CPU/DP1/fuif/execute_alu_src
add wave -noupdate -group FORWU-C1 /system_tb/DUT/CPU/DP1/fuif/execute_reg_dst
add wave -noupdate -group FORWU-C1 /system_tb/DUT/CPU/DP1/fuif/execute_reg_wr_en
add wave -noupdate -group FORWU-C1 /system_tb/DUT/CPU/DP1/fuif/memory_reg_wr_addr
add wave -noupdate -group FORWU-C1 /system_tb/DUT/CPU/DP1/fuif/memory_reg_wr_en
add wave -noupdate -group FORWU-C1 /system_tb/DUT/CPU/DP1/fuif/memory_mem_to_reg
add wave -noupdate -group FORWU-C1 /system_tb/DUT/CPU/DP1/fuif/write_back_reg_wr_addr
add wave -noupdate -group FORWU-C1 /system_tb/DUT/CPU/DP1/fuif/write_back_reg_wr_en
add wave -noupdate -group FORWU-C1 /system_tb/DUT/CPU/DP1/fuif/bus_a_control
add wave -noupdate -group FORWU-C1 /system_tb/DUT/CPU/DP1/fuif/bus_b_control
add wave -noupdate -expand -group {EMIF-MEMORY C1} /system_tb/DUT/CPU/DP1/emif/shamt_out
add wave -noupdate -expand -group {EMIF-MEMORY C1} /system_tb/DUT/CPU/DP1/emif/shamt_in
add wave -noupdate -expand -group {EMIF-MEMORY C1} /system_tb/DUT/CPU/DP1/emif/funct_code_out
add wave -noupdate -expand -group {EMIF-MEMORY C1} /system_tb/DUT/CPU/DP1/emif/funct_code_in
add wave -noupdate -expand -group {EMIF-MEMORY C1} -color Magenta /system_tb/DUT/CPU/DP1/emif/op_code_out
add wave -noupdate -expand -group {EMIF-MEMORY C1} /system_tb/DUT/CPU/DP1/emif/op_code_in
add wave -noupdate -expand -group {EMIF-MEMORY C1} /system_tb/DUT/CPU/DP1/emif/rs_out
add wave -noupdate -expand -group {EMIF-MEMORY C1} /system_tb/DUT/CPU/DP1/emif/rs_in
add wave -noupdate -expand -group {EMIF-MEMORY C1} /system_tb/DUT/CPU/DP1/emif/rt_out
add wave -noupdate -expand -group {EMIF-MEMORY C1} /system_tb/DUT/CPU/DP1/emif/rt_in
add wave -noupdate -expand -group {EMIF-MEMORY C1} /system_tb/DUT/CPU/DP1/emif/halt_in
add wave -noupdate -expand -group {EMIF-MEMORY C1} /system_tb/DUT/CPU/DP1/emif/lui_en_in
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group RegSignals /system_tb/DUT/CPU/DP1/emif/reg_wr_addr_out
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group RegSignals /system_tb/DUT/CPU/DP1/emif/reg_wr_addr_in
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group RegSignals /system_tb/DUT/CPU/DP1/emif/reg_dst_out
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group RegSignals /system_tb/DUT/CPU/DP1/emif/reg_dst_in
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group RegSignals /system_tb/DUT/CPU/DP1/emif/reg_wr_out
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group RegSignals /system_tb/DUT/CPU/DP1/emif/reg_wr_in
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group RegSignals /system_tb/DUT/CPU/DP1/emif/mem_wr_out
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group RegSignals /system_tb/DUT/CPU/DP1/emif/mem_wr_in
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group RegSignals /system_tb/DUT/CPU/DP1/emif/mem_to_reg_out
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group RegSignals /system_tb/DUT/CPU/DP1/emif/mem_to_reg_in
add wave -noupdate -expand -group {EMIF-MEMORY C1} -expand -group ALU /system_tb/DUT/CPU/DP1/emif/bus_b_out
add wave -noupdate -expand -group {EMIF-MEMORY C1} -expand -group ALU /system_tb/DUT/CPU/DP1/emif/bus_b_in
add wave -noupdate -expand -group {EMIF-MEMORY C1} -expand -group ALU /system_tb/DUT/CPU/DP1/emif/alu_out_out
add wave -noupdate -expand -group {EMIF-MEMORY C1} -expand -group ALU /system_tb/DUT/CPU/DP1/emif/alu_out_in
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group {Branhc Sigs} /system_tb/DUT/CPU/DP1/emif/next_pc_out
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group {Branhc Sigs} /system_tb/DUT/CPU/DP1/emif/next_pc_in
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group {Branhc Sigs} /system_tb/DUT/CPU/DP1/emif/imm_16_out
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group {Branhc Sigs} /system_tb/DUT/CPU/DP1/emif/imm_16_in
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group {Branhc Sigs} /system_tb/DUT/CPU/DP1/emif/bne_en_out
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group {Branhc Sigs} /system_tb/DUT/CPU/DP1/emif/bne_en_in
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group {Branhc Sigs} /system_tb/DUT/CPU/DP1/emif/beq_en_out
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group {Branhc Sigs} /system_tb/DUT/CPU/DP1/emif/beq_en_in
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group {Branhc Sigs} /system_tb/DUT/CPU/DP1/emif/jal_en_out
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group {Branhc Sigs} /system_tb/DUT/CPU/DP1/emif/jal_en_in
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group {Branhc Sigs} /system_tb/DUT/CPU/DP1/emif/lui_en_out
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group {Branhc Sigs} /system_tb/DUT/CPU/DP1/emif/jump_en_out
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group {Branhc Sigs} /system_tb/DUT/CPU/DP1/emif/jump_en_in
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group {Branhc Sigs} /system_tb/DUT/CPU/DP1/emif/jr_en_out
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group {Branhc Sigs} /system_tb/DUT/CPU/DP1/emif/jr_en_in
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group {Branhc Sigs} /system_tb/DUT/CPU/DP1/emif/equal_out
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group {Branhc Sigs} /system_tb/DUT/CPU/DP1/emif/equal_in
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group {Branhc Sigs} /system_tb/DUT/CPU/DP1/emif/jump_r_pc_out
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group {Branhc Sigs} /system_tb/DUT/CPU/DP1/emif/jump_r_pc_in
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group {Branhc Sigs} /system_tb/DUT/CPU/DP1/emif/jump_pc_out
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group {Branhc Sigs} /system_tb/DUT/CPU/DP1/emif/jump_pc_in
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group {Branhc Sigs} /system_tb/DUT/CPU/DP1/emif/branch_pc_out
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group {Branhc Sigs} /system_tb/DUT/CPU/DP1/emif/branch_pc_in
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group {Branhc Sigs} /system_tb/DUT/CPU/DP1/emif/normal_pc_out
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group {Branhc Sigs} /system_tb/DUT/CPU/DP1/emif/normal_pc_in
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group {Branhc Sigs} /system_tb/DUT/CPU/DP1/emif/imm_32_out
add wave -noupdate -expand -group {EMIF-MEMORY C1} -group {Branhc Sigs} /system_tb/DUT/CPU/DP1/emif/imm_32_in
add wave -noupdate -expand -group {EMIF-MEMORY C1} -color Magenta /system_tb/DUT/CPU/DP1/emif/instruction_out
add wave -noupdate -expand -group {EMIF-MEMORY C1} /system_tb/DUT/CPU/DP1/emif/instruction_in
add wave -noupdate -expand -group {EMIF-MEMORY C1} /system_tb/DUT/CPU/DP1/emif/dhit
add wave -noupdate -expand -group {EMIF-MEMORY C1} /system_tb/DUT/CPU/DP1/emif/update
add wave -noupdate -expand -group {EMIF-MEMORY C1} /system_tb/DUT/CPU/DP1/emif/flush
add wave -noupdate -group BUS_W_MUX_C1 /system_tb/DUT/CPU/DP1/BUSW/in_0
add wave -noupdate -group BUS_W_MUX_C1 /system_tb/DUT/CPU/DP1/BUSW/in_1
add wave -noupdate -group BUS_W_MUX_C1 /system_tb/DUT/CPU/DP1/BUSW/in_2
add wave -noupdate -group BUS_W_MUX_C1 /system_tb/DUT/CPU/DP1/BUSW/control
add wave -noupdate -group BUS_W_MUX_C1 /system_tb/DUT/CPU/DP1/BUSW/out
add wave -noupdate -group PC_MUX_C1 /system_tb/DUT/CPU/DP1/PC_MUX/in_0
add wave -noupdate -group PC_MUX_C1 /system_tb/DUT/CPU/DP1/PC_MUX/in_1
add wave -noupdate -group PC_MUX_C1 /system_tb/DUT/CPU/DP1/PC_MUX/in_2
add wave -noupdate -group PC_MUX_C1 /system_tb/DUT/CPU/DP1/PC_MUX/control
add wave -noupdate -group PC_MUX_C1 /system_tb/DUT/CPU/DP1/PC_MUX/out
add wave -noupdate -expand -group IMM_PC_CNCT_C1 /system_tb/DUT/CPU/DP1/IMM_PC_CONCATENATE/imm_26
add wave -noupdate -expand -group IMM_PC_CNCT_C1 /system_tb/DUT/CPU/DP1/IMM_PC_CONCATENATE/pc
add wave -noupdate -expand -group IMM_PC_CNCT_C1 /system_tb/DUT/CPU/DP1/IMM_PC_CONCATENATE/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2611073 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 366
configure wave -valuecolwidth 515
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
WaveRestoreZoom {2546200 ps} {2644200 ps}
