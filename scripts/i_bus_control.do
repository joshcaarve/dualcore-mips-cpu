onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /i_bus_control_tb/CLK
add wave -noupdate /i_bus_control_tb/nRST
add wave -noupdate /i_bus_control_tb/tb_blip
add wave -noupdate -expand -group IBIF /i_bus_control_tb/ibif/iREN
add wave -noupdate -expand -group IBIF /i_bus_control_tb/ibif/iaddr
add wave -noupdate -expand -group IBIF /i_bus_control_tb/ibif/iwait
add wave -noupdate -expand -group IBIF /i_bus_control_tb/ibif/iREN_out
add wave -noupdate -expand -group IBIF /i_bus_control_tb/ibif/iaddr_out
add wave -noupdate /i_bus_control_tb/DUT/select
add wave -noupdate /i_bus_control_tb/DUT/next_select
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {110 ns} 0}
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
WaveRestoreZoom {0 ns} {163 ns}
