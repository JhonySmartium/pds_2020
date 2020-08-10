Este ejemplo es un encoder convolucional mas simple que el Ejercicio 2 del TP1.
Los datos entran en formato serial por AXI Stream y despues salen en 4 bits AXIS Stream.
Hay que instalar con pip sk_dsp_comm.

Tener en cuenta que el codigo convolucional por cada bit a la entrada salen dos bits.
Por lo tanto para llenar 4 bits a la salida tenemos que esperar 2 bits a la entrada.

Descripcion de los archivos:
    * generate_result_vector.py: Script de Python en el cual generamos un arreglo de 4 bits para verificar el funciomiento del algoritmo.