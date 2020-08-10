Se hace el ejemplo del resize. Esto agrega bits mas significativos para generar vectores de mayor tamaño.
Por ejemplo un resize("0111",6) --> Te hace "000111".
Estas funciones tienen en cuenta que si los datos son signados o no signados. (Hay que convertir a signed o unsigned para hacer esta funcion).
Es mas facil hacer esto que agregar los bits manualmente.

    * test_resize_tb.vhd    : Testbench para excitar al resize. 
    * test_resize.vhd       : Codigo RTL con genericos para dependiendo de lo que se desee probar se pruebe la funcion de otras maneras.
    * sim.do                : Script para ejecutar la simulacion en questasim/modelsim.
    * wave.do               : Contiene las waveform necesaria para visualizarlas.