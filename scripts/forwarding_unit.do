onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /forwarding_unit_tb/CLK
add wave -noupdate /forwarding_unit_tb/nRST
add wave -noupdate /forwarding_unit_tb/PROG/tb_test_num
add wave -noupdate /forwarding_unit_tb/PROG/tb_test_case
add wave -noupdate /forwarding_unit_tb/tb_blip
add wave -noupdate -expand -group FUIF /forwarding_unit_tb/DUT/fuif/write_back_reg_wr_en
add wave -noupdate -expand -group FUIF /forwarding_unit_tb/DUT/fuif/write_back_reg_wr_addr
add wave -noupdate -expand -group FUIF /forwarding_unit_tb/DUT/fuif/memory_reg_wr_en
add wave -noupdate -expand -group FUIF /forwarding_unit_tb/DUT/fuif/memory_reg_wr_addr
add wave -noupdate -expand -group FUIF /forwarding_unit_tb/DUT/fuif/execute_rt
add wave -noupdate -expand -group FUIF /forwarding_unit_tb/DUT/fuif/execute_rs
add wave -noupdate -expand -group FUIF /forwarding_unit_tb/DUT/fuif/execute_reg_wr_en
add wave -noupdate -expand -group FUIF /forwarding_unit_tb/DUT/fuif/execute_reg_dst
add wave -noupdate -expand -group FUIF /forwarding_unit_tb/DUT/fuif/execute_instruction
add wave -noupdate -expand -group FUIF /forwarding_unit_tb/DUT/fuif/execute_alu_src
add wave -noupdate -expand -group FUIF /forwarding_unit_tb/DUT/fuif/bus_b_control
add wave -noupdate -expand -group FUIF /forwarding_unit_tb/DUT/fuif/bus_a_control
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {32 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {21 ns} {84 ns}
