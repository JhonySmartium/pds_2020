#Compilamos todo dentro de la libreria de 
vlib test_lib
vmap test_lib ./test_lib

vcom -2008 -check_synthesis -reportprogress 300 -mixedsvvh -work test_lib ./ffd_vector.vhd
vcom -2008 -check_synthesis -reportprogress 300 -mixedsvvh -work test_lib ./promediator_rtl.vhd
vcom -2008 -reportprogress 300 -mixedsvvh -work test_lib ./promediator_rtl_tb.vhd

vsim -L test_lib -t 1ps -novopt test_lib.promediator_rtl_tb

#Despues viene el wave y al final el run.
do wave.do
run 50 us