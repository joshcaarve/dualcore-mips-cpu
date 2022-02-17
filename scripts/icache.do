onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /icache_tb/CLK
add wave -noupdate /icache_tb/nRST
add wave -noupdate -expand -group TB_VARS /icache_tb/tb_blip
add wave -noupdate -expand -group TB_VARS /icache_tb/PROG/tb_test_num
add wave -noupdate -expand -group TB_VARS /icache_tb/PROG/tb_test_case
add wave -noupdate -expand -group DPIF /icache_tb/DUT/dpif/imemREN
add wave -noupdate -expand -group DPIF /icache_tb/DUT/dpif/imemaddr
add wave -noupdate -expand -group DPIF /icache_tb/DUT/dpif/ihit
add wave -noupdate -expand -group DPIF /icache_tb/DUT/dpif/imemload
add wave -noupdate -group CCIF /icache_tb/DUT/ccif/iwait
add wave -noupdate -group CCIF /icache_tb/DUT/ccif/iload
add wave -noupdate -group CCIF /icache_tb/DUT/ccif/iREN
add wave -noupdate -group CCIF /icache_tb/DUT/ccif/iaddr
add wave -noupdate -expand -group ICACHE -group outputs /icache_tb/PROG/dpif/ihit
add wave -noupdate -expand -group ICACHE -group outputs /icache_tb/PROG/dpif/imemload
add wave -noupdate -expand -group ICACHE -group outputs /icache_tb/PROG/chif/iaddr
add wave -noupdate -expand -group ICACHE -group outputs /icache_tb/PROG/chif/iREN
add wave -noupdate -expand -group ICACHE -expand /icache_tb/DUT/icachef
add wave -noupdate -expand -group ICACHE /icache_tb/DUT/hit
add wave -noupdate -expand -group ICACHE /icache_tb/DUT/state
add wave -noupdate -expand -group ICACHE /icache_tb/DUT/next_state
add wave -noupdate -expand -group ICACHE /icache_tb/DUT/icache
add wave -noupdate -expand -group ICACHE /icache_tb/DUT/next_icache
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {82491 ps} 0}
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
WaveRestoreZoom {20250 ps} {229094 ps}
