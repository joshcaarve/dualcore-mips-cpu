onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Standard Signals}
add wave -noupdate /memory_control_tb/CLK
add wave -noupdate /memory_control_tb/nRST
add wave -noupdate /memory_control_tb/PROG/tb_test_case
add wave -noupdate /memory_control_tb/PROG/tb_test_num
add wave -noupdate -divider -height 25 <NULL>
add wave -noupdate -divider {CIF0 Signals}
add wave -noupdate /memory_control_tb/PROG/cif0/dREN
add wave -noupdate /memory_control_tb/PROG/cif0/dWEN
add wave -noupdate /memory_control_tb/PROG/cif0/daddr
add wave -noupdate /memory_control_tb/PROG/cif0/dload
add wave -noupdate /memory_control_tb/PROG/cif0/dstore
add wave -noupdate /memory_control_tb/PROG/cif0/dwait
add wave -noupdate /memory_control_tb/PROG/cif0/iREN
add wave -noupdate /memory_control_tb/PROG/cif0/iaddr
add wave -noupdate /memory_control_tb/PROG/cif0/iload
add wave -noupdate /memory_control_tb/PROG/cif0/iwait
add wave -noupdate -divider -height 25 <NULL>
add wave -noupdate -divider {CCIF Signals}
add wave -noupdate /memory_control_tb/PROG/ccif/ramstate
add wave -noupdate -divider -height 25 <NULL>
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {19 ns} 0}
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
WaveRestoreZoom {0 ns} {53 ns}
