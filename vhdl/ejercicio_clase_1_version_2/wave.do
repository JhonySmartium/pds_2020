onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ejer_1_tb/DUT/clk_i
add wave -noupdate /ejer_1_tb/DUT/a_reset_i
add wave -noupdate /ejer_1_tb/DUT/s_reset_i
add wave -noupdate /ejer_1_tb/DUT/in_1_i
add wave -noupdate /ejer_1_tb/DUT/in_2_i
add wave -noupdate /ejer_1_tb/DUT/sel_i
add wave -noupdate /ejer_1_tb/DUT/overflow_o
add wave -noupdate /ejer_1_tb/DUT/out_reg_o
add wave -noupdate /ejer_1_tb/DUT/acc_r
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
