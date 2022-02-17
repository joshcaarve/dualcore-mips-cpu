onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /alu_tb/PROG/tb_test_case
add wave -noupdate /alu_tb/PROG/tb_test_num
add wave -noupdate -divider <NULL>
add wave -noupdate /alu_tb/tb_blip
add wave -noupdate /alu_tb/CLK
add wave -noupdate -divider <NULL>
add wave -noupdate /alu_tb/aluif/aluop
add wave -noupdate /alu_tb/aluif/portA
add wave -noupdate /alu_tb/aluif/portB
add wave -noupdate -divider <NULL>
add wave -noupdate /alu_tb/aluif/portOut
add wave -noupdate /alu_tb/aluif/zero
add wave -noupdate /alu_tb/aluif/overflow
add wave -noupdate /alu_tb/aluif/negative
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7 ns} 0}
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
WaveRestoreZoom {2 ns} {16 ns}
