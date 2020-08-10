onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test_shift_tb/DUT/BIT_WIDTH
add wave -noupdate /test_shift_tb/DUT/data_i
add wave -noupdate /test_shift_tb/DUT/N_SHIFTS
add wave -noupdate /test_shift_tb/DUT/signed_rotate_left_o
add wave -noupdate /test_shift_tb/DUT/signed_rotate_right_o
add wave -noupdate /test_shift_tb/DUT/signed_shift_left_o
add wave -noupdate /test_shift_tb/DUT/signed_shift_right_o
add wave -noupdate /test_shift_tb/DUT/unsigned_rotate_left_o
add wave -noupdate /test_shift_tb/DUT/unsigned_rotate_right_o
add wave -noupdate /test_shift_tb/DUT/unsigned_shift_left_o
add wave -noupdate /test_shift_tb/DUT/unsigned_shift_right_o
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
WaveRestoreZoom {49993690 ps} {50000333 ps}
