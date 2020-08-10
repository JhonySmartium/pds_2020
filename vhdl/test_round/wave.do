onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider ROUND
add wave -noupdate /test_round_tb/DUT/SUM_MASK
add wave -noupdate /test_round_tb/DUT/data_i
add wave -noupdate /test_round_tb/DUT/ENA_ROUND
add wave -noupdate /test_round_tb/DUT/M
add wave -noupdate /test_round_tb/DUT/N
add wave -noupdate /test_round_tb/DUT/data_o
add wave -noupdate /test_round_tb/DUT/data_temp_pos_saturation
add wave -noupdate /test_round_tb/DUT/data_temp_pre_saturation
add wave -noupdate -divider TRUNC
add wave -noupdate /test_round_tb/DUT_2/SUM_MASK
add wave -noupdate /test_round_tb/DUT_2/data_i
add wave -noupdate /test_round_tb/DUT_2/ENA_ROUND
add wave -noupdate /test_round_tb/DUT_2/M
add wave -noupdate /test_round_tb/DUT_2/N
add wave -noupdate /test_round_tb/DUT_2/data_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors
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
WaveRestoreZoom {0 ps} {52500 ns}
