onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {GENERICOS Y CONSTANTES}
add wave -noupdate /conv_encoder_2p_rtl_tb/DUT/POL_1
add wave -noupdate /conv_encoder_2p_rtl_tb/DUT/POL_2
add wave -noupdate /conv_encoder_2p_rtl_tb/DUT/CYCLES_TO_FILL_OUTPUT
add wave -noupdate /conv_encoder_2p_rtl_tb/DUT/K
add wave -noupdate /conv_encoder_2p_rtl_tb/DUT/POL1_SLV
add wave -noupdate /conv_encoder_2p_rtl_tb/DUT/POL2_SLV
add wave -noupdate -divider SYSTEM
add wave -noupdate /conv_encoder_2p_rtl_tb/DUT/clk_i
add wave -noupdate /conv_encoder_2p_rtl_tb/DUT/a_reset_ni
add wave -noupdate -divider SAXIS
add wave -noupdate /conv_encoder_2p_rtl_tb/DUT/s_axis_tdata_i
add wave -noupdate /conv_encoder_2p_rtl_tb/DUT/s_axis_tready_o
add wave -noupdate /conv_encoder_2p_rtl_tb/DUT/s_axis_tvalid_i
add wave -noupdate -divider MAXIS
add wave -noupdate /conv_encoder_2p_rtl_tb/DUT/m_axis_tdata_o
add wave -noupdate /conv_encoder_2p_rtl_tb/DUT/m_axis_tvalid_o
add wave -noupdate /conv_encoder_2p_rtl_tb/DUT/m_axis_tready_i
add wave -noupdate -divider INTERNAl
add wave -noupdate /conv_encoder_2p_rtl_tb/DUT/regs
add wave -noupdate /conv_encoder_2p_rtl_tb/DUT/regs_default
add wave -noupdate /conv_encoder_2p_rtl_tb/DUT/regs_in
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
