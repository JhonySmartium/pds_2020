onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /file_tb/u_mult_by_constant/DATA_IN_WIDTH
add wave -noupdate -radix unsigned /file_tb/u_mult_by_constant/DATA_OUT_WIDTH
add wave -noupdate -radix decimal /file_tb/u_mult_by_constant/CONST_VALUE
add wave -noupdate /file_tb/u_mult_by_constant/clk_i
add wave -noupdate /file_tb/u_mult_by_constant/reset_ni
add wave -noupdate -divider {SLAVE AXIS}
add wave -noupdate -format Analog-Step -height 74 -max 8192.0 -min -8192.0 -radix decimal /file_tb/u_mult_by_constant/s_axis_tdata_i
add wave -noupdate /file_tb/u_mult_by_constant/s_axis_tvalid_i
add wave -noupdate /file_tb/u_mult_by_constant/s_axis_tready_o
add wave -noupdate -divider {MASTER AXIS}
add wave -noupdate -format Analog-Step -height 74 -max 134217728.0 -min -134217728.0 -radix decimal /file_tb/u_mult_by_constant/m_axis_tdata_o
add wave -noupdate /file_tb/u_mult_by_constant/m_axis_tvalid_o
add wave -noupdate /file_tb/u_mult_by_constant/m_axis_tready_i
add wave -noupdate /file_tb/u_mult_by_constant/CONST
add wave -noupdate /file_tb/u_mult_by_constant/regs
add wave -noupdate /file_tb/u_mult_by_constant/regs_in
add wave -noupdate /file_tb/u_mult_by_constant/regs_default
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {269196 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 154
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
