onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider GENERICOS
add wave -noupdate /promediator_rtl_tb/DUT/N
add wave -noupdate /promediator_rtl_tb/DUT/M
add wave -noupdate -divider CONSTANTES
add wave -noupdate /promediator_rtl_tb/DUT/MUL_FACTOR_REAL
add wave -noupdate /promediator_rtl_tb/DUT/MUL_FACTOR
add wave -noupdate -divider SYSTEM
add wave -noupdate /promediator_rtl_tb/DUT/clk_i
add wave -noupdate /promediator_rtl_tb/DUT/a_reset_ni
add wave -noupdate -divider {S AXIS}
add wave -noupdate /promediator_rtl_tb/DUT/s_axis_tdata_i
add wave -noupdate /promediator_rtl_tb/DUT/s_axis_tvalid_i
add wave -noupdate /promediator_rtl_tb/DUT/s_axis_tready_o
add wave -noupdate -divider {M AXIS}
add wave -noupdate /promediator_rtl_tb/DUT/m_axis_tdata_o
add wave -noupdate /promediator_rtl_tb/DUT/m_axis_tvalid_o
add wave -noupdate /promediator_rtl_tb/DUT/m_axis_tready_i
add wave -noupdate -divider INTERNAL
add wave -noupdate -expand /promediator_rtl_tb/DUT/input_vector_reg
add wave -noupdate /promediator_rtl_tb/DUT/result_w
add wave -noupdate /promediator_rtl_tb/DUT/enable_dsp
add wave -noupdate /promediator_rtl_tb/DUT/regs
add wave -noupdate /promediator_rtl_tb/DUT/regs_in
add wave -noupdate -divider {FOR GENERATE REG 0}
add wave -noupdate /promediator_rtl_tb/DUT/generate_array(0)/reg_inst/clk_i
add wave -noupdate /promediator_rtl_tb/DUT/generate_array(0)/reg_inst/a_reset_ni
add wave -noupdate /promediator_rtl_tb/DUT/generate_array(0)/reg_inst/data_i
add wave -noupdate /promediator_rtl_tb/DUT/generate_array(0)/reg_inst/data_o
add wave -noupdate /promediator_rtl_tb/DUT/generate_array(0)/reg_inst/enable_t_i
add wave -noupdate /promediator_rtl_tb/DUT/generate_array(0)/reg_inst/reg_in
add wave -noupdate -divider {FOR GENERATE REG 1}
add wave -noupdate /promediator_rtl_tb/DUT/generate_array(1)/reg_inst/clk_i
add wave -noupdate /promediator_rtl_tb/DUT/generate_array(1)/reg_inst/a_reset_ni
add wave -noupdate /promediator_rtl_tb/DUT/generate_array(1)/reg_inst/data_i
add wave -noupdate /promediator_rtl_tb/DUT/generate_array(1)/reg_inst/data_o
add wave -noupdate /promediator_rtl_tb/DUT/generate_array(1)/reg_inst/enable_t_i
add wave -noupdate /promediator_rtl_tb/DUT/generate_array(1)/reg_inst/reg_in
add wave -noupdate -divider {FOR GENERATE REG 2}
add wave -noupdate /promediator_rtl_tb/DUT/generate_array(2)/reg_inst/clk_i
add wave -noupdate /promediator_rtl_tb/DUT/generate_array(2)/reg_inst/a_reset_ni
add wave -noupdate /promediator_rtl_tb/DUT/generate_array(2)/reg_inst/data_i
add wave -noupdate /promediator_rtl_tb/DUT/generate_array(2)/reg_inst/data_o
add wave -noupdate /promediator_rtl_tb/DUT/generate_array(2)/reg_inst/enable_t_i
add wave -noupdate /promediator_rtl_tb/DUT/generate_array(2)/reg_inst/reg_in
add wave -noupdate -divider {FOR GENERATE REG 3}
add wave -noupdate /promediator_rtl_tb/DUT/generate_array(3)/reg_inst/clk_i
add wave -noupdate /promediator_rtl_tb/DUT/generate_array(3)/reg_inst/a_reset_ni
add wave -noupdate /promediator_rtl_tb/DUT/generate_array(3)/reg_inst/data_i
add wave -noupdate /promediator_rtl_tb/DUT/generate_array(3)/reg_inst/data_o
add wave -noupdate /promediator_rtl_tb/DUT/generate_array(3)/reg_inst/enable_t_i
add wave -noupdate /promediator_rtl_tb/DUT/generate_array(3)/reg_inst/reg_in
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {41460 ps} 0}
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
WaveRestoreZoom {0 ps} {1555769 ps}
