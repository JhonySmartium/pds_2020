# -*- coding: utf-8 -*-
"""
Created on Wed Jul 29 04:06:50 2020

@author: Usuario
"""

import numpy as np

data = np.load('fir_win_kaiser.npz')
#Esto si queremos ver los archivos.
print(data.files)

#Extraemos los coeficientes de los archivos.
b = data['ba'][0]
a = data['ba'][1]
