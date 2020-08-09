onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ejer_1_tb/clk
add wave -noupdate /ejer_1_tb/reset
add wave -noupdate /ejer_1_tb/clk_i
add wave -noupdate /ejer_1_tb/a_reset_i
add wave -noupdate /ejer_1_tb/s_reset_i
add wave -noupdate /ejer_1_tb/in_1_i
add wave -noupdate /ejer_1_tb/in_2_i
add wave -noupdate /ejer_1_tb/sel_i
add wave -noupdate /ejer_1_tb/overflow_o
add wave -noupdate /ejer_1_tb/out_reg_o
add wave -noupdate -divider {Internals Regs}
add wave -noupdate /ejer_1_tb/DUT/regs
add wave -noupdate /ejer_1_tb/DUT/regs_in
add wave -noupdate /ejer_1_tb/DUT/regs_default
add wave -noupdate -divider Variables
add wave -noupdate /ejer_1_tb/DUT/comb_process/v
add wave -noupdate /ejer_1_tb/DUT/comb_process/mux_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {510000 ps} 0}
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
WaveRestoreZoom {0 ps} {2100 ns}
