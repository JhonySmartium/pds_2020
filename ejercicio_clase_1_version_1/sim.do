#Compilamos todo dentro de la libreria de 
vlib ejer_1
vmap ejer_1 ./ejer_1

#Compilamos el archivo fuentes
vcom -2008 -reportprogress 300 -check_synthesis -mixedsvvh -work ejer_1 ./ejer_1.vhd
#Compilamosa el archivo de simulacion.
vcom -2008 -reportprogress 300 -mixedsvvh -work ejer_1 ./ejer_1_tb.vhd

vsim -L COREFIFO_LIB_TM -L RTG4 -L commons -L et_amba3_lib -t 1ps -novopt ejer_1.ejer_1_tb

#Despues viene el wave y al final el run.
do wave.do
run 2000ns