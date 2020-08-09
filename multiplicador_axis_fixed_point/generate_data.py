# -*- coding: utf-8 -*-

from fxpoint._fixedInt import DeFixedInt
from fxpoint._fixedInt import arrayFixedInt
from generate_stimulus_signal import *

import matplotlib.pyplot as plt
from scipy import signal
import numpy as np

plt.close('all')

input_simulation_file = "data_in.txt"

[xx,yy] = generate_stimulus_signal(0.25,200,1.)

# Dibujamos la senoidal que generamos.
fig = plt.figure(1,figsize=(20,8))
plt.plot(xx,yy,'ko')
plt.plot(xx,yy,'k')
plt.grid()
#Hagamoslo con una constantes, lo pasamos a una CONSTANTE.
mul_by_constant = DeFixedInt(0,15,-0.25,roundMode='trunc')
print(mul_by_constant)
# Generamos una tupla que tenga el valor en entero y el valor en representación de punto fijo.
fixed_array = [(DeFixedInt(0,15,item,roundMode='trunc').value,DeFixedInt(0,15,item,roundMode='trunc').fValue) for item in yy]

# Generamos el archivo para realizar despues con el testbench

f= open(input_simulation_file,"w")
for item in fixed_array:
    f.write("%d\n" % item[0])
f.close()


#Alguna multiplicaciones que las use para el VHDL.
a = DeFixedInt(0,7,0.5,roundMode='trunc')
b = DeFixedInt(0,7,0.25,roundMode='trunc')
c = a*b

d = DeFixedInt(0,7,0.125,roundMode='trunc')
