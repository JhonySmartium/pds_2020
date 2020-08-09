Este ejeplo realiza la multiplicacion de un señal de entrada con un formato Q.15.
Por otra constante que es Q1.15. La salida da un Q2.30. 
El bloque RTL las interfaces son AXIS Stream tanto a la salida como la entrada.

Descripción de archivos:
    * generate_data.py              : Nos genera un archivo data_in.txt que es agarrado por el testbench como fuente para los estimulos. Fixed Point Q1.15.
    * analyze_data.py               : Levanta los datos dentro del archivo data_out.txt y realiza un grafico. Lo interpreta como un Q2.30.
    * generate_stimulus_signal.py   : Funcion que genera el estimulo.
    * mult_by_constant.vhd          : Codigo RTL sintetizable, con interfaz AXIS tanto de entrada como salida. Realiza la multiplicacion por una constante.
    * file_tb.vhd                   : Levanta el archivo data_in.txt y genera estimulos AXIS para el bloque mult_by_constant y luego recoge los resultados y 
                                      los guarda en el archivo data_out.txt
    * sim.do                        : Script para ejecutar la simulacion en questasim/modelsim.
    * wave.do                       : Contiene las waveform necesaria para visualizarlas.
    * create_project.tcl            : Crea un projecto en el Vivado para los que usen el Vivado.
    * file_tb_behav.wcfg            : Archivo de waveform para el Vivado.
