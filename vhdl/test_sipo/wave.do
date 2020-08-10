onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sipo_rtl_tb/DUT/N_OUTPUT_BIT_WIDTH
add wave -noupdate /sipo_rtl_tb/DUT/clk_i
add wave -noupdate /sipo_rtl_tb/DUT/a_reset_ni
add wave -noupdate /sipo_rtl_tb/DUT/data_i
add wave -noupdate /sipo_rtl_tb/DUT/load_t_i
add wave -noupdate /sipo_rtl_tb/DUT/data_o
add wave -noupdate /sipo_rtl_tb/DUT/data_valid_t_o
add wave -noupdate /sipo_rtl_tb/DUT/counter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
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
WaveRestoreZoom {0 ps} {8276 ps}
