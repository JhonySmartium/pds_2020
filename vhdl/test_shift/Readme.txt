Este ejemplo prueba el shifteo.  Esto se hacen con variable signed/unsigned. Lo bueno de este codigo es que tiene en cuenta el bit 
de signo.
Entramos con un std_logic_vector haciendo shift y rotate tanto sea signado como no signado. De esta manera podemos ver los distintos resultados.

    * test_shift            : Prueba el shifteo con codigo RTL.
    * test_shift_tb         : Generador de estimulos para el test_shift.
    * sim.do                : Script para ejecutar la simulacion en questasim/modelsim.
    * wave.do               : Contiene las waveform necesaria para visualizarlas.