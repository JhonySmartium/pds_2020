set src_dir [pwd]
set prj_name vivado_project

create_project $prj_name [file join $src_dir/$prj_name] -part xc7z010clg400-1
set_property board_part digilentinc.com:arty-z7-10:part0:1.0 [current_project]
set_property target_language VHDL [current_project]
add_files -norecurse [file join $src_dir/ejer_1.vhd]
set_property file_type {VHDL 2008} [get_files  $src_dir/ejer_1.vhd]
update_compile_order -fileset sources_1
synth_design -rtl -name rtl_1