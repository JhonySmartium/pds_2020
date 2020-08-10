Este ejemplo realiza el test del redondeo. Permite por generico que uno elija si quiere hacer redondeo o si quiere hacer truncamiento.
Siempre el numero de N > M. Recordar que saturacion y overflow son metodos de reduccion.

    * saturation.vhd        : Como se hace una suma de dos numeros al final hay un crecimiento en 1 bits.
    * test_round.vhd        : Hace el ejemplo del redondeo o truncamiento. Para redondear suma un factor.
    * test_round_tb.vhd     : Hace el testbench haciendo 2 DUT, uno con truncamiento y otro con redondeo.
    * sim.do                : Script para ejecutar la simulacion en questasim/modelsim.
    * wave.do               : Contiene las waveform necesaria para visualizarlas.