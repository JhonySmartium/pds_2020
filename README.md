# PDS 2020:
Repositorio Materia PDS 2020. MESE UBA.

## Codigo de referencia:
* [Digital Design HQ](https://github.com/digital-design-hq/Digital-Resources). Aca tienen muchas referencia a código ya implementado yendo desde lo mas basico a lo mas avanzado.
* [EDA PLAYGROUND](https://www.edaplayground.com/playgrounds?searchString=&language=VHDL&simulator=&methodologies=&_libraries=on&_svx=on&_easierUVM=on&curated=true&_curated=on). Esta plataforma aparte de tener ejemplo de implementacion les va a permitir correr ejemplos. Ya que tienen disponibles distintos simuladores.
* [Doulos Referencia VHDL](https://www.doulos.com/knowhow/vhdl_designers_guide/#resources)
* [AXI STREAM TUTORIAL 1](http://fpgasite.blogspot.com/2017/07/xilinx-axi-stream-tutorial-part-1.html)
* [AXI STREAM TUTORIAL 2](http://www.googoolia.com/wp/2014/05/31/lesson-7-axi-stream-interface-in-detail-rtl-flow/)

## Ejemplo de VHDL
[Link](./vhdl/):

Todos los ejemplos incluyen: Codigo RTL, testbench y script para cargar la simulación.

* **Clase 1**
  * Ejercicio Clase 1- 2 Proceso.[Link](./vhdl/ejercicio_clase_1_version_1) 
  * Ejercicio Clase 1- 1 Proceso. [Link](./vhdl/ejercicio_clase_1_version_2) 
  * Ejercicio Clase 1- Estructural. [Link](./vhdl/ejercicio_clase_1_version_3) 

* **Ejemplos complejidad simple**:
  * FFD con enable  [Link](./vhdl/test_ffd_vector)
  * Linea de retardo    [Link](./vhdl/test_ffd_vector_array)
  * Resize      [Link](./vhdl/test_resize)
  * Saturación  [Link](./vhdl/test_saturation)
  * Redondeo    [Link](./vhdl/test_round)
  * Shift   [Link](./vhdl/test_shift)
* **Ejemplos complejidad media:**
  * Multiplicador AXIS [Link](./vhdl/multiplicador_axis_fixed_point)
    * Entrada con Slave AXIS y salida Master AXIS. 
    * Lectura de datos del testbench desde un archivo.
    * Scripts de python para generar y analizar informacion.
  * Encoder Convolucional AXIS [Link](./vhdl/test_conv_encoder)
    * Entrada con Slave AXIS y salida Master AXIS. 
    * Entrada de 1 bit salida de 4 bits.
    * 2 bits de entrada para producir una salida valida de 4 bits.
    * Testbench que envia un contador de 0 a 15.
    * Script de Python utiliza scikit-dsp
  * Filtro Promediador AXIS [Link](./vhdl/test_promediador)
    * Entrada con Slave AXIS (8 bits) y salida AXIS.
    * Configuracion orden del promediador.
    * Excitación con respuesta impulsiva.
    * Truncamiento a la salida.


## Ejemplos de Python
[Link](./vhdl/python):
* **ventaneo_grafico.py**: Prueba el efecto del spreading con fun animation.
* **transformada_z_grafico.py**: Forma grafica de interpretar el efecto del diagrama de polos en Z en la respuesta de magnitud y de fase.
* **test_npy.py**: Prueba carga los archivos .npy que se obtienen con el pyfda.
* **generate_conv_data.py**: Archivo de utilidad para el Ejercicio 2 del TP1. Toma datos de 32 bits y los pasar por un encoder convolucional en python. Tener en mente que en su implementacion dependera el orden que tome si es LSB o MSB.
  * Instalar las dependedencia: [scikit-dsp-comm](https://scikit-dsp-comm.readthedocs.io/en/latest/readme.html)
* **Modulo de punto fijo:** [Link](./python/fxpoint)


## FAQ:
