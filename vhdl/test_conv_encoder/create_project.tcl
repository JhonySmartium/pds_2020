set src_dir [pwd]
set prj_name vivado_project

#Create project.
create_project $prj_name [file join $src_dir/$prj_name] -part xc7z010clg400-1
set_property board_part digilentinc.com:arty-z7-10:part0:1.0 [current_project]

#Agregar las fuentes

add_files -norecurse [file join $src_dir/conv_encoder_2p_rtl.vhd]
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse [file join $src_dir/conv_encoder_2p_rtl_tb.vhd]

set_property target_language VHDL [current_project]

set_property file_type {VHDL 2008} [get_files  "conv_encoder_2p_rtl.vhd"]
set_property file_type {VHDL 2008} [get_files  "conv_encoder_2p_rtl_tb.vhd"]

update_compile_order -fileset sim_1

#Actualizar. Despues si quieren pueden poner para simullar