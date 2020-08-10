onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ffd_vector_tb/clk_i
add wave -noupdate /ffd_vector_tb/a_reset_ni
add wave -noupdate /ffd_vector_tb/data_o
add wave -noupdate /ffd_vector_tb/data_i
add wave -noupdate /ffd_vector_tb/enable_t_i
add wave -noupdate /ffd_vector_tb/N
add wave -noupdate /ffd_vector_tb/C_CLK_PERIOD
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
