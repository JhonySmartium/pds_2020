onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /test_saturation_tb/data_i
add wave -noupdate -radix binary /test_saturation_tb/data_i
add wave -noupdate -format Analog-Step -height 74 -max 126.99999999999997 -min -128.0 -radix decimal /test_saturation_tb/data_i
add wave -noupdate -divider SAT
add wave -noupdate -radix decimal /test_saturation_tb/DUT_SAT/data_o
add wave -noupdate -format Analog-Step -height 74 -max 6.9999999999999991 -min -8.0 -radix decimal /test_saturation_tb/DUT_SAT/data_o
add wave -noupdate -divider OV
add wave -noupdate /test_saturation_tb/DUT_OV/data_o
add wave -noupdate -format Analog-Step -height 74 -max 6.9999999999999991 -min -8.0 -radix decimal /test_saturation_tb/DUT_OV/data_o
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
WaveRestoreZoom {0 ps} {52500 ns}
