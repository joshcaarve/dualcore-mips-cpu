onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dcache_tb/CLK
add wave -noupdate /dcache_tb/nRST
add wave -noupdate -expand -group TB_SIGNALS /dcache_tb/tb_blip
add wave -noupdate -expand -group TB_SIGNALS /dcache_tb/PROG/tb_test_case
add wave -noupdate -expand -group TB_SIGNALS /dcache_tb/PROG/tb_test_num
add wave -noupdate -expand -group DP0 /dcache_tb/dif0/halt
add wave -noupdate -expand -group DP0 /dcache_tb/dif0/dhit
add wave -noupdate -expand -group DP0 /dcache_tb/dif0/datomic
add wave -noupdate -expand -group DP0 /dcache_tb/dif0/dmemREN
add wave -noupdate -expand -group DP0 /dcache_tb/dif0/dmemWEN
add wave -noupdate -expand -group DP0 /dcache_tb/dif0/flushed
add wave -noupdate -expand -group DP0 /dcache_tb/dif0/dmemload
add wave -noupdate -expand -group DP0 /dcache_tb/dif0/dmemstore
add wave -noupdate -expand -group DP0 /dcache_tb/dif0/dmemaddr
add wave -noupdate -expand -group DP1 /dcache_tb/dif1/halt
add wave -noupdate -expand -group DP1 /dcache_tb/dif1/dhit
add wave -noupdate -expand -group DP1 /dcache_tb/dif1/datomic
add wave -noupdate -expand -group DP1 /dcache_tb/dif1/dmemREN
add wave -noupdate -expand -group DP1 /dcache_tb/dif1/dmemWEN
add wave -noupdate -expand -group DP1 /dcache_tb/dif1/flushed
add wave -noupdate -expand -group DP1 /dcache_tb/dif1/dmemload
add wave -noupdate -expand -group DP1 /dcache_tb/dif1/dmemstore
add wave -noupdate -expand -group DP1 /dcache_tb/dif1/dmemaddr
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/ccif/dload
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/ccif/dstore
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/ccif/dwait
add wave -noupdate -expand -group DCACHE0 -expand /dcache_tb/DUT0/dcachef
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/next_lru
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/lru
add wave -noupdate -expand -group DCACHE0 -color Red -expand -subitemconfig {{/dcache_tb/DUT0/next_cache[7]} {-color Red -height 17} {/dcache_tb/DUT0/next_cache[6]} {-color Red -height 17} {/dcache_tb/DUT0/next_cache[5]} {-color Red -height 17} {/dcache_tb/DUT0/next_cache[4]} {-color Red -height 17} {/dcache_tb/DUT0/next_cache[3]} {-color Red -height 17} {/dcache_tb/DUT0/next_cache[2]} {-color Red -height 17} {/dcache_tb/DUT0/next_cache[1]} {-color Red -height 17} {/dcache_tb/DUT0/next_cache[0]} {-color Red -height 17 -expand} {/dcache_tb/DUT0/next_cache[0][1]} {-color Red -height 17} {/dcache_tb/DUT0/next_cache[0][0]} {-color Red -height 17 -expand} {/dcache_tb/DUT0/next_cache[0][0].valid} {-color Red} {/dcache_tb/DUT0/next_cache[0][0].dirty} {-color Red} {/dcache_tb/DUT0/next_cache[0][0].tag} {-color Red} {/dcache_tb/DUT0/next_cache[0][0].data} {-color Red}} /dcache_tb/DUT0/next_cache
add wave -noupdate -expand -group DCACHE0 -expand -subitemconfig {{/dcache_tb/DUT0/cache[0]} -expand {/dcache_tb/DUT0/cache[0][0]} -expand} /dcache_tb/DUT0/cache
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/next_cache
add wave -noupdate -expand -group DCACHE0 -color Magenta /dcache_tb/DUT0/state
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/next_state
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/cflag
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/rflag
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/wflag
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/hflag
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/next_cflag
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/next_rflag
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/next_wflag
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/next_hflag
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/limit
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/next_limit
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/true_addr
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/halt_word
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/next_halt_word
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/left
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/right
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/match
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/hit
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/target_block
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/chosen_frame
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/active
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/snoop_addr
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/haddr
add wave -noupdate -expand -group DCACHE0 /dcache_tb/DUT0/ccif/daddr
add wave -noupdate /dcache_tb/cif1/dload
add wave -noupdate -expand -group DCACHE1 /dcache_tb/cif1/dREN
add wave -noupdate -expand -group DCACHE1 /dcache_tb/cif1/dWEN
add wave -noupdate -expand -group DCACHE1 /dcache_tb/DUT1/ccif/ccwait
add wave -noupdate -expand -group DCACHE1 /dcache_tb/DUT1/wflag
add wave -noupdate -expand -group DCACHE1 /dcache_tb/DUT1/true_addr
add wave -noupdate -expand -group DCACHE1 /dcache_tb/DUT1/target_block
add wave -noupdate -expand -group DCACHE1 -expand -subitemconfig {{/dcache_tb/DUT1/cache[0]} -expand} /dcache_tb/DUT1/cache
add wave -noupdate -expand -group DCACHE1 /dcache_tb/DUT1/next_cache
add wave -noupdate -expand -group DCACHE1 /dcache_tb/DUT1/state
add wave -noupdate -expand -group DCACHE1 -color Blue /dcache_tb/cif1/dload
add wave -noupdate -expand -group DCACHE1 /dcache_tb/DUT1/snoop_addr
add wave -noupdate -expand -group DCACHE1 /dcache_tb/DUT1/right
add wave -noupdate -expand -group DCACHE1 /dcache_tb/DUT1/next_lru
add wave -noupdate -expand -group DCACHE1 /dcache_tb/DUT1/next_limit
add wave -noupdate -expand -group DCACHE1 /dcache_tb/DUT1/next_hflag
add wave -noupdate -expand -group DCACHE1 /dcache_tb/DUT1/next_halt_word
add wave -noupdate -expand -group DCACHE1 /dcache_tb/DUT1/lru
add wave -noupdate -expand -group DCACHE1 /dcache_tb/DUT1/limit
add wave -noupdate -expand -group DCACHE1 /dcache_tb/DUT1/left
add wave -noupdate -expand -group DCACHE1 /dcache_tb/DUT1/match
add wave -noupdate -expand -group DCACHE1 /dcache_tb/DUT1/hit
add wave -noupdate -expand -group DCACHE1 /dcache_tb/DUT1/hflag
add wave -noupdate -expand -group DCACHE1 /dcache_tb/DUT1/halt_word
add wave -noupdate -expand -group DCACHE1 /dcache_tb/DUT1/haddr
add wave -noupdate -expand -group DCACHE1 /dcache_tb/DUT1/dcachef
add wave -noupdate -expand -group DCACHE1 /dcache_tb/DUT1/chosen_frame
add wave -noupdate -expand -group DCACHE1 /dcache_tb/DUT1/cflag
add wave -noupdate -expand -group DCACHE1 /dcache_tb/DUT1/active
add wave -noupdate -group CCIF -expand /dcache_tb/ccif/dwait
add wave -noupdate -group CCIF /dcache_tb/ccif/dREN
add wave -noupdate -group CCIF /dcache_tb/ccif/dWEN
add wave -noupdate -group CCIF /dcache_tb/ccif/dload
add wave -noupdate -group CCIF /dcache_tb/ccif/dstore
add wave -noupdate -group CCIF /dcache_tb/ccif/daddr
add wave -noupdate -group CCIF /dcache_tb/ccif/ccwait
add wave -noupdate -group CCIF /dcache_tb/ccif/ccinv
add wave -noupdate -group CCIF /dcache_tb/ccif/ccwrite
add wave -noupdate -group CCIF /dcache_tb/ccif/cctrans
add wave -noupdate -group CCIF /dcache_tb/ccif/ccsnoopaddr
add wave -noupdate -group CCIF /dcache_tb/ccif/ramWEN
add wave -noupdate -group CCIF /dcache_tb/ccif/ramREN
add wave -noupdate -group CCIF /dcache_tb/ccif/ramstate
add wave -noupdate -group CCIF /dcache_tb/ccif/ramaddr
add wave -noupdate -group CCIF /dcache_tb/ccif/ramstore
add wave -noupdate -group CCIF /dcache_tb/ccif/ramload
add wave -noupdate -expand -group DBIF /dcache_tb/MC/dbif/dREN
add wave -noupdate -expand -group DBIF /dcache_tb/MC/dbif/dWEN
add wave -noupdate -expand -group DBIF /dcache_tb/MC/dbif/dramREN
add wave -noupdate -expand -group DBIF /dcache_tb/MC/dbif/dramWEN
add wave -noupdate -expand -group DBIF /dcache_tb/MC/D_BUS/select
add wave -noupdate -expand -group DBIF /dcache_tb/MC/D_BUS/state
add wave -noupdate -expand -group DBIF /dcache_tb/MC/dbif/dramaddr
add wave -noupdate -expand -group DBIF /dcache_tb/MC/dbif/daddr
add wave -noupdate -expand -group DBIF /dcache_tb/MC/dbif/dload
add wave -noupdate -expand -group DBIF /dcache_tb/MC/dbif/dramload
add wave -noupdate -expand -group DBIF /dcache_tb/MC/dbif/dramstore
add wave -noupdate -expand -group DBIF -expand /dcache_tb/MC/dbif/dwait
add wave -noupdate -expand -group DBIF /dcache_tb/MC/dbif/ramwait
add wave -noupdate -expand -group DBIF /dcache_tb/MC/dbif/ccwait
add wave -noupdate -expand -group DBIF -expand /dcache_tb/MC/dbif/ccinv
add wave -noupdate -expand -group DBIF -expand /dcache_tb/MC/dbif/ccwrite
add wave -noupdate -expand -group DBIF /dcache_tb/MC/dbif/ccsnoopaddr
add wave -noupdate -expand -group DBIF /dcache_tb/MC/dbif/dstore
add wave -noupdate -expand -group DBIF /dcache_tb/MC/dbif/cctrans
add wave -noupdate -expand -group ARIF /dcache_tb/MC/arif/dREN
add wave -noupdate -expand -group ARIF /dcache_tb/MC/arif/dWEN
add wave -noupdate -expand -group ARIF /dcache_tb/MC/arif/dwait
add wave -noupdate -expand -group ARIF /dcache_tb/MC/arif/dstore
add wave -noupdate -expand -group ARIF /dcache_tb/MC/arif/daddr
add wave -noupdate -expand -group ARIF /dcache_tb/MC/arif/dload
add wave -noupdate -expand -group ARIF /dcache_tb/MC/arif/ramstate
add wave -noupdate -expand -group ARIF /dcache_tb/MC/arif/ramaddr
add wave -noupdate -expand -group ARIF /dcache_tb/MC/arif/ramstore
add wave -noupdate -expand -group ARIF /dcache_tb/MC/arif/ramload
add wave -noupdate -expand -group ARIF /dcache_tb/MC/arif/ramWEN
add wave -noupdate -expand -group ARIF /dcache_tb/MC/arif/ramREN
add wave -noupdate -expand -group RAM /dcache_tb/RAM/wren
add wave -noupdate -expand -group RAM /dcache_tb/RAM/rstate
add wave -noupdate -expand -group RAM /dcache_tb/RAM/q
add wave -noupdate -expand -group RAM /dcache_tb/RAM/en
add wave -noupdate -expand -group RAM /dcache_tb/RAM/count
add wave -noupdate -expand -group RAM /dcache_tb/RAM/addr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {407247 ps} 0}
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
WaveRestoreZoom {395100 ps} {454100 ps}
