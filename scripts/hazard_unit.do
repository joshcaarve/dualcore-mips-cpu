onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /hazard_unit_tb/CLK
add wave -noupdate /hazard_unit_tb/nRST
add wave -noupdate /hazard_unit_tb/tb_blip
add wave -noupdate /hazard_unit_tb/huif/fetch_decode_flush
add wave -noupdate /hazard_unit_tb/huif/fetch_decode_enable
add wave -noupdate /hazard_unit_tb/huif/decode_execute_flush
add wave -noupdate /hazard_unit_tb/huif/decode_execute_enable
add wave -noupdate /hazard_unit_tb/huif/execute_memory_flush
add wave -noupdate /hazard_unit_tb/huif/execute_memory_enable
add wave -noupdate /hazard_unit_tb/huif/memory_write_back_flush
add wave -noupdate /hazard_unit_tb/huif/memory_write_back_enable
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {0 ns} {782 ns}
