Promediador de orden 4, con entradas y salidas AXI S. 
Tener en mente que N es el orden de entrada y de salida que seria de orden 8, por ejemplo para la implementacion.
El M seria la linea de retardo.  O sea el orden del promediador.

    * promediador_rtl_tb.vhd    : Ejemplo del promediador completo. Con un testbench que excita con una respuesta al impulso.
    * promediador_rtl.vhd       : Este es el codigo RTL con el cual tenemos interfaces AXIS a la entrada y la salida.
    * ffd_vector.vhd            : Utilizamos una cadena de FFs encadenados para hacer la linea de retardo de entrada.
    * sim.do                    : Script para ejecutar la simulacion en questasim/modelsim.
    * wave.do                   : Contiene las waveform necesaria para visualizarlas.