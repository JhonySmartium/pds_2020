En este caso vamos a tener un ejemplo con un registro. Se puede modificar por generico la longitud.
Esto tiene un enable = '1' para habilitar el latcheo de los datos. 
El latcho de los datos se hace con el enable. COn lo cual el retraso se lo mide en cantidad de enable.

La idea de esto es que puede utilizar 

Hay 4 arquitecturas en las cuales se implementa:
- Estructural con un for generate.
- Estructural con 4 instancias. Este codigo no es escalable.
- Utilizando la arquitecturade un proceso.
- Utilizando la arquitecturade dos procesos.

    * ffd_vector_array.vhd      : Implementa una linea de M delays, y N bits. Todo configurable por registro. 
                                    Aca lo que tenemos son las 4 arquitecturas.
    * ffd_vector_array_tb.vhd   : Testbench.
    * sim.do                    : Script para ejecutar la simulacion en questasim/modelsim.
    * wave.do                   : Contiene las waveform necesaria para visualizarlas.