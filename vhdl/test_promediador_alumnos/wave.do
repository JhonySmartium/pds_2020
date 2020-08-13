onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {CONSTANTE y GENERICOS}
add wave -noupdate /promediador_rtl_tb/DUT/MUL_FACTOR_SIGNED
add wave -noupdate -divider SYSTEM
add wave -noupdate /promediador_rtl_tb/DUT/clk_i
add wave -noupdate /promediador_rtl_tb/DUT/a_reset_ni
add wave -noupdate -divider INPUT
add wave -noupdate /promediador_rtl_tb/DUT/data_i
add wave -noupdate /promediador_rtl_tb/DUT/enable_dsp_t_i
add wave -noupdate -divider OUTPUT
add wave -noupdate /promediador_rtl_tb/DUT/data_o
add wave -noupdate -divider INTERNAL
add wave -noupdate /promediador_rtl_tb/DUT/delay_line_reg
add wave -noupdate /promediador_rtl_tb/DUT/mul_temp_result
add wave -noupdate -divider {SUMAS PARCIALES}
add wave -noupdate /promediador_rtl_tb/DUT/temp_stage_1_1_w
add wave -noupdate /promediador_rtl_tb/DUT/temp_stage_1_2_w
add wave -noupdate /promediador_rtl_tb/DUT/temp_stage_2_1_w
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 221
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
WaveRestoreZoom {0 ps} {4275184 ps}
