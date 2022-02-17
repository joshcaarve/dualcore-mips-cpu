onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /control_unit_tb/CLK
add wave -noupdate /control_unit_tb/nRST
add wave -noupdate -radix decimal /control_unit_tb/PROG/tb_test_num
add wave -noupdate /control_unit_tb/tb_blip
add wave -noupdate /control_unit_tb/PROG/tb_test_case
add wave -noupdate -divider -height 30 <NULL>
add wave -noupdate /control_unit_tb/DUT/cuif/halt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {616 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 314
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
WaveRestoreZoom {199 ns} {684 ns}
