onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -expand -group DCACHE -color Red /system_tb/DUT/CPU/CM/DCACHE/limit
add wave -noupdate -expand -group DCACHE -color Red /system_tb/DUT/CPU/CM/DCACHE/limit
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -divider Dwait
add wave -noupdate {/system_tb/DUT/CPU/CC/\dwait~0 /lut_mask}
add wave -noupdate {/system_tb/DUT/CPU/CC/\dwait~0 /sum_lutc_input}
add wave -noupdate {/system_tb/DUT/CPU/CC/\dwait~0 /dont_touch}
add wave -noupdate {/system_tb/DUT/CPU/CC/\dwait~0 /lpm_type}
add wave -noupdate {/system_tb/DUT/CPU/CC/\dwait~0 /dataa}
add wave -noupdate {/system_tb/DUT/CPU/CC/\dwait~0 /datab}
add wave -noupdate {/system_tb/DUT/CPU/CC/\dwait~0 /datac}
add wave -noupdate {/system_tb/DUT/CPU/CC/\dwait~0 /datad}
add wave -noupdate {/system_tb/DUT/CPU/CC/\dwait~0 /cin}
add wave -noupdate {/system_tb/DUT/CPU/CC/\dwait~0 /combout}
add wave -noupdate {/system_tb/DUT/CPU/CC/\dwait~0 /cout}
add wave -noupdate {/system_tb/DUT/CPU/CC/\dwait~0 /cout_tmp}
add wave -noupdate {/system_tb/DUT/CPU/CC/\dwait~0 /combout_tmp}
add wave -noupdate {/system_tb/DUT/CPU/CC/\dwait~0 /isum_lutc_input}
add wave -noupdate {/system_tb/DUT/CPU/CC/\dwait~0 /dataa_in}
add wave -noupdate {/system_tb/DUT/CPU/CC/\dwait~0 /datab_in}
add wave -noupdate {/system_tb/DUT/CPU/CC/\dwait~0 /datac_in}
add wave -noupdate {/system_tb/DUT/CPU/CC/\dwait~0 /datad_in}
add wave -noupdate {/system_tb/DUT/CPU/CC/\dwait~0 /cin_in}
add wave -noupdate -expand -group {REAL SIGS} /system_tb/DUT/CPU/DP/dpifihit
add wave -noupdate -expand -group {REAL SIGS} /system_tb/DUT/CPU/DP/PROGRAM_COUNTER/pc_WEN
add wave -noupdate -expand -group {REAL SIGS} {/system_tb/DUT/CPU/DP/\DECODE_EXECUTE|deif.op_code_out }
add wave -noupdate -expand -group {REAL SIGS} {/system_tb/DUT/CPU/DP/\FETCH_DECODE|fdif.normal_pc_out }
add wave -noupdate -expand -group {REAL SIGS} {/system_tb/DUT/CPU/DP/\FETCH_DECODE|fdif.instruction_out }
add wave -noupdate {/system_tb/DUT/\ramREN~1 /lut_mask}
add wave -noupdate {/system_tb/DUT/\ramREN~1 /sum_lutc_input}
add wave -noupdate {/system_tb/DUT/\ramREN~1 /dont_touch}
add wave -noupdate {/system_tb/DUT/\ramREN~1 /lpm_type}
add wave -noupdate {/system_tb/DUT/\ramREN~1 /dataa}
add wave -noupdate {/system_tb/DUT/\ramREN~1 /datab}
add wave -noupdate {/system_tb/DUT/\ramREN~1 /datac}
add wave -noupdate {/system_tb/DUT/\ramREN~1 /datad}
add wave -noupdate {/system_tb/DUT/\ramREN~1 /cin}
add wave -noupdate {/system_tb/DUT/\ramREN~1 /combout}
add wave -noupdate {/system_tb/DUT/\ramREN~1 /cout}
add wave -noupdate {/system_tb/DUT/\ramREN~1 /cout_tmp}
add wave -noupdate {/system_tb/DUT/\ramREN~1 /combout_tmp}
add wave -noupdate {/system_tb/DUT/\ramREN~1 /isum_lutc_input}
add wave -noupdate {/system_tb/DUT/\ramREN~1 /dataa_in}
add wave -noupdate {/system_tb/DUT/\ramREN~1 /datab_in}
add wave -noupdate {/system_tb/DUT/\ramREN~1 /datac_in}
add wave -noupdate {/system_tb/DUT/\ramREN~1 /datad_in}
add wave -noupdate {/system_tb/DUT/\ramREN~1 /cin_in}
add wave -noupdate -divider syif.REN~input
add wave -noupdate {/system_tb/DUT/\syif.REN~input /differential_mode}
add wave -noupdate {/system_tb/DUT/\syif.REN~input /bus_hold}
add wave -noupdate {/system_tb/DUT/\syif.REN~input /simulate_z_as}
add wave -noupdate {/system_tb/DUT/\syif.REN~input /lpm_type}
add wave -noupdate {/system_tb/DUT/\syif.REN~input /i}
add wave -noupdate {/system_tb/DUT/\syif.REN~input /ibar}
add wave -noupdate {/system_tb/DUT/\syif.REN~input /o}
add wave -noupdate {/system_tb/DUT/\syif.REN~input /out_tmp}
add wave -noupdate {/system_tb/DUT/\syif.REN~input /o_tmp}
add wave -noupdate {/system_tb/DUT/\syif.REN~input /out_val}
add wave -noupdate {/system_tb/DUT/\syif.REN~input /prev_value}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {964780 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 339
configure wave -valuecolwidth 73
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
WaveRestoreZoom {0 ps} {4348708 ps}
