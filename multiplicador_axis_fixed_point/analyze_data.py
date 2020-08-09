# -*- coding: utf-8 -*-

from fxpoint._fixedInt import DeFixedInt
from fxpoint._fixedInt import arrayFixedInt
import matplotlib.pyplot as plt
from scipy import signal
import numpy as np

from generate_stimulus_signal import *



#Replicamos el esimulo con el generamos la informacion. La idea es poder tener un punto de referencia.
[xx,yy] = generate_stimulus_signal(0.25,200,1.)
output_simulation_file = "data_out.txt"

### Ahora con el archivo generado con el terstbench vamos a generar una señal
#Utilizamos csv porque ya podemos usar direcamente todo lo que corresponde a archivos separados por comas.
import csv

#En nuestro experimento estamos multiplicando dosn umeros Q1.15 por lo cual el resultado nos da un Q2.30.
output_fp = np.array([],dtype = np.int64)
with open(output_simulation_file) as csvfile:
    reader = csv.reader(csvfile, delimiter=' ')
    for row in reader:
        output_fp = np.append(output_fp,np.array(row[0],dtype = np.int64))
#Como multiplicamos dos numero Q1.15 lo que tenemos con maxima presicion es un Q4.7
#Aca hacemos la convversión para poder pasarlo y verlos en la misma escala.
output_float = (output_fp / 2**30)
plt.plot(xx,output_float,'ro')
plt.plot(xx,output_float ,'r')
plt.grid()