onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dcache_tb/CLK
add wave -noupdate /dcache_tb/nRST
add wave -noupdate /dcache_tb/tb_blip
add wave -noupdate -expand -group DCACHE! /dcache_tb/DUT/tag
add wave -noupdate -expand -group DCACHE! /dcache_tb/DUT/index
add wave -noupdate -expand -group DCACHE! /dcache_tb/DUT/offset
add wave -noupdate -expand -group DCACHE! /dcache_tb/DUT/cache
add wave -noupdate -expand -group DCACHE! /dcache_tb/DUT/next_cache
add wave -noupdate -expand -group DCACHE! /dcache_tb/DUT/lru_next
add wave -noupdate -expand -group DCACHE! /dcache_tb/DUT/lru
add wave -noupdate -expand -group DCACHE! /dcache_tb/DUT/current
add wave -noupdate -expand -group DCACHE! /dcache_tb/DUT/next
add wave -noupdate -expand -group DCACHE! /dcache_tb/DUT/cflag
add wave -noupdate -expand -group DCACHE! /dcache_tb/DUT/rflag
add wave -noupdate -expand -group DCACHE! /dcache_tb/DUT/wflag
add wave -noupdate -expand -group DCACHE! /dcache_tb/DUT/hflag
add wave -noupdate -expand -group DCACHE! /dcache_tb/DUT/next_cflag
add wave -noupdate -expand -group DCACHE! /dcache_tb/DUT/next_rflag
add wave -noupdate -expand -group DCACHE! /dcache_tb/DUT/next_wflag
add wave -noupdate -expand -group DCACHE! /dcache_tb/DUT/next_hflag
add wave -noupdate -expand -group DCACHE! /dcache_tb/DUT/limit
add wave -noupdate -expand -group DCACHE! /dcache_tb/DUT/next_limit
add wave -noupdate -expand -group DCACHE! /dcache_tb/DUT/left
add wave -noupdate -expand -group DCACHE! /dcache_tb/DUT/right
add wave -noupdate -expand -group DCACHE! /dcache_tb/DUT/hit
add wave -noupdate -expand -group DCACHE! /dcache_tb/DUT/target_block
add wave -noupdate -expand -group DCACHE! /dcache_tb/DUT/chosen_frame
add wave -noupdate -expand -group CC_TO_MC /dcache_tb/DUT/ccif/dwait
add wave -noupdate -expand -group CC_TO_MC /dcache_tb/DUT/ccif/dREN
add wave -noupdate -expand -group CC_TO_MC /dcache_tb/DUT/ccif/dWEN
add wave -noupdate -expand -group CC_TO_MC /dcache_tb/DUT/ccif/dload
add wave -noupdate -expand -group CC_TO_MC /dcache_tb/DUT/ccif/dstore
add wave -noupdate -expand -group CC_TO_MC /dcache_tb/DUT/ccif/daddr
add wave -noupdate -expand -group {cache to datapath} /dcache_tb/DUT/dpif/halt
add wave -noupdate -expand -group {cache to datapath} /dcache_tb/DUT/dpif/dhit
add wave -noupdate -expand -group {cache to datapath} /dcache_tb/DUT/dpif/datomic
add wave -noupdate -expand -group {cache to datapath} /dcache_tb/DUT/dpif/dmemREN
add wave -noupdate -expand -group {cache to datapath} /dcache_tb/DUT/dpif/dmemWEN
add wave -noupdate -expand -group {cache to datapath} /dcache_tb/DUT/dpif/flushed
add wave -noupdate -expand -group {cache to datapath} /dcache_tb/DUT/dpif/dmemload
add wave -noupdate -expand -group {cache to datapath} /dcache_tb/DUT/dpif/dmemstore
add wave -noupdate -expand -group {cache to datapath} /dcache_tb/DUT/dpif/dmemaddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {106105 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 229
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
WaveRestoreZoom {0 ps} {152477 ps}
