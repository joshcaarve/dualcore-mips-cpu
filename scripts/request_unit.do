onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /request_unit_tb/CLK
add wave -noupdate /request_unit_tb/nRST
add wave -noupdate /request_unit_tb/tb_blip
add wave -noupdate /request_unit_tb/PROG/tb_test_case
add wave -noupdate -divider -height 30 <NULL>
add wave -noupdate /request_unit_tb/PROG/rqif/dREN
add wave -noupdate /request_unit_tb/PROG/rqif/dWEN
add wave -noupdate /request_unit_tb/PROG/rqif/dhit
add wave -noupdate /request_unit_tb/PROG/rqif/iREN
add wave -noupdate /request_unit_tb/PROG/rqif/ihit
add wave -noupdate -divider -height 30 <NULL>
add wave -noupdate /request_unit_tb/PROG/rqif/dmemREN
add wave -noupdate /request_unit_tb/PROG/rqif/dmemWEN
add wave -noupdate /request_unit_tb/PROG/rqif/imemREN
add wave -noupdate -divider -height 30 <NULL>
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {18 ns} 0}
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
WaveRestoreZoom {0 ns} {105 ns}
