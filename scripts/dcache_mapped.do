onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dcache_tb/PROG/tb_test_case
add wave -noupdate {/dcache_tb/DUT0/\dpif.dhit }
add wave -noupdate {/dcache_tb/DUT1/\dpif.dhit }
add wave -noupdate /dcache_tb/DUT0/CLK
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {31421 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 218
configure wave -valuecolwidth 234
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
WaveRestoreZoom {0 ps} {59 ns}
