onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /hazard_forward_tb/CLK
add wave -noupdate /hazard_forward_tb/nRST
add wave -noupdate /hazard_forward_tb/tb_blip
add wave -noupdate -expand -group HFIF /hazard_forward_tb/DUT/hfif/fu_bus_a_control
add wave -noupdate -expand -group HFIF /hazard_forward_tb/DUT/hfif/fu_bus_b_control
add wave -noupdate -expand -group HFIF /hazard_forward_tb/DUT/hfif/hu_fetch_decode_flush
add wave -noupdate -expand -group HFIF /hazard_forward_tb/DUT/hfif/hu_decode_execute_flush
add wave -noupdate -expand -group HFIF /hazard_forward_tb/DUT/hfif/hu_execute_memory_flush
add wave -noupdate -expand -group HFIF /hazard_forward_tb/DUT/hfif/hu_memory_write_back_flush
add wave -noupdate -expand -group HFIF /hazard_forward_tb/DUT/hfif/hu_fetch_decode_enable
add wave -noupdate -expand -group HFIF /hazard_forward_tb/DUT/hfif/hu_decode_execute_enable
add wave -noupdate -expand -group HFIF /hazard_forward_tb/DUT/hfif/hu_execute_memory_enable
add wave -noupdate -expand -group HFIF /hazard_forward_tb/DUT/hfif/hu_memory_write_back_enable
add wave -noupdate -expand -group HFIF /hazard_forward_tb/DUT/hfif/fetch_decode_flush
add wave -noupdate -expand -group HFIF /hazard_forward_tb/DUT/hfif/fetch_decode_enable
add wave -noupdate -expand -group HFIF /hazard_forward_tb/DUT/hfif/decode_execute_flush
add wave -noupdate -expand -group HFIF /hazard_forward_tb/DUT/hfif/decode_execute_enable
add wave -noupdate -expand -group HFIF /hazard_forward_tb/DUT/hfif/execute_memory_flush
add wave -noupdate -expand -group HFIF /hazard_forward_tb/DUT/hfif/execute_memory_enable
add wave -noupdate -expand -group HFIF /hazard_forward_tb/DUT/hfif/memory_write_back_flush
add wave -noupdate -expand -group HFIF /hazard_forward_tb/DUT/hfif/memory_write_back_enable
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {16 ns} 0}
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
WaveRestoreZoom {0 ns} {84 ns}
