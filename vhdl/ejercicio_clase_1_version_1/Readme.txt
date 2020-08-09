Este ejemplo prueba el ejercicio visto en la clase 1.
Este ejemplo utiliza como metodo de diseño el esquema de dos procesos de:
https://www.gaisler.com/doc/vhdl2proc.pdf

-Descripción de archivo:
    * ejer_1.vhd            : Archivo con codigo RTL, sintetizable. 
    * ejer_1_tb.vhd         : Archivo de testbench para probar el anterior.
    * sim.do                : Script para ejecutar la simulacion en questasim/modelsim.
    * wave.do               : Contiene las waveform necesaria para visualizarlas.
    * create_project.tcl    : Crea un projecto en el Vivado para los que usen el Vivado.