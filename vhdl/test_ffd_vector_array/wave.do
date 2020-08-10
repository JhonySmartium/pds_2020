onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {DUT STRUCT}
add wave -noupdate /ffd_vector_array_tb/DUT_STRUC/clk_i
add wave -noupdate /ffd_vector_array_tb/DUT_STRUC/a_reset_ni
add wave -noupdate /ffd_vector_array_tb/DUT_STRUC/data_i
add wave -noupdate /ffd_vector_array_tb/DUT_STRUC/enable_t_i
add wave -noupdate /ffd_vector_array_tb/DUT_STRUC/data_o
add wave -noupdate /ffd_vector_array_tb/DUT_STRUC/reg_connection_w
add wave -noupdate -divider {DUT VERBOSE STRUCT}
add wave -noupdate /ffd_vector_array_tb/DUT_VERBOSE_STRUC/clk_i
add wave -noupdate /ffd_vector_array_tb/DUT_VERBOSE_STRUC/a_reset_ni
add wave -noupdate /ffd_vector_array_tb/DUT_VERBOSE_STRUC/data_i
add wave -noupdate /ffd_vector_array_tb/DUT_VERBOSE_STRUC/enable_t_i
add wave -noupdate /ffd_vector_array_tb/DUT_VERBOSE_STRUC/data_o
add wave -noupdate /ffd_vector_array_tb/DUT_VERBOSE_STRUC/reg_connection_w
add wave -noupdate -divider {DUT 1 P}
add wave -noupdate /ffd_vector_array_tb/DUT_1_P/a_reset_ni
add wave -noupdate /ffd_vector_array_tb/DUT_1_P/data_i
add wave -noupdate /ffd_vector_array_tb/DUT_1_P/enable_t_i
add wave -noupdate /ffd_vector_array_tb/DUT_1_P/data_o
add wave -noupdate /ffd_vector_array_tb/DUT_1_P/reg_bank_r
add wave -noupdate -divider {DUT 2 P}
add wave -noupdate /ffd_vector_array_tb/DUT_2_P/a_reset_ni
add wave -noupdate /ffd_vector_array_tb/DUT_2_P/data_i
add wave -noupdate /ffd_vector_array_tb/DUT_2_P/enable_t_i
add wave -noupdate /ffd_vector_array_tb/DUT_2_P/data_o
add wave -noupdate /ffd_vector_array_tb/DUT_2_P/regs
add wave -noupdate /ffd_vector_array_tb/DUT_2_P/regs_in
add wave -noupdate /ffd_vector_array_tb/DUT_2_P/regs_default
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
WaveRestoreZoom {0 ps} {1385255 ps}
