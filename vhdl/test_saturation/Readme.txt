Este ejemplo prueba la saturacion o deja hacer overflow. Esto se puede seleccionar con un generico.
    
    * test_saturation.vhd   : Ejemplo que prueba la saturacion. Se configura con generico si se quiere hacer saturacion.
    * test_saturation_tb.vhd: Prueba las dos opciones, ya sea saturando como dejando hacer overflow. Excita con un contador en el rango de la entrada.
    * sim.do                : Script para ejecutar la simulacion en questasim/modelsim.
    * wave.do               : Contiene las waveform necesaria para visualizarlas.
