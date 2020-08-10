onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {TEST VECTOR}
add wave -noupdate /test_resize_tb/INPUT_VECTOR
add wave -noupdate -divider INPUT
add wave -noupdate /test_resize_tb/DUT/data_i
add wave -noupdate -radix decimal /test_resize_tb/DUT/data_i
add wave -noupdate -radix unsigned /test_resize_tb/DUT/data_i
add wave -noupdate -divider UNSIGNED
add wave -noupdate /test_resize_tb/DUT/unsigned_o
add wave -noupdate -radix decimal /test_resize_tb/DUT/unsigned_o
add wave -noupdate -radix unsigned /test_resize_tb/DUT/unsigned_o
add wave -noupdate -divider SIGNED
add wave -noupdate /test_resize_tb/DUT/signed_o
add wave -noupdate -radix unsigned /test_resize_tb/DUT/signed_o
add wave -noupdate -radix unsigned /test_resize_tb/DUT/signed_o
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
WaveRestoreZoom {0 ps} {6643 ps}
