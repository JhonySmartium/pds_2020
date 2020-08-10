#Compilamos todo dentro de la libreria de 
vlib ffd_lib 
vmap ffd_lib ./ffd_lib

#Aca tenemos el ffd inidividual
vcom -2008 -check_synthesis -reportprogress 300 -mixedsvvh -work ffd_lib  ./../test_ffd_vector/ffd_vector.vhd


vlib test_lib
vmap test_lib ./test_lib


vcom -2008 -check_synthesis -reportprogress 300 -mixedsvvh -work test_lib ./ffd_vector_array.vhd
vcom -2008 -reportprogress 300 -mixedsvvh -work test_lib ./ffd_vector_array_tb.vhd

#Cargamos la simulacion.
vsim -L test_lib -t 1ps -novopt test_lib.ffd_vector_array_tb

#Despues viene el wave y al final el run.
do wave.do
run 50 us