En este caso vamos a tener un ejemplo con un registro. Se puede por generico la longitud.
Esto tiene un enable = '1' para habilitar el latcheo de los datos.

    * ffd_vector.vhd            : Registro de N Bits con enable.
    * ffd_vector_tb.vhd         : Testbench,que genera un enable cada 10 ciclos de reloj.
    * sim.do                    : Script para ejecutar la simulacion en questasim/modelsim.
    * wave.do                   : Contiene las waveform necesaria para visualizarlas.