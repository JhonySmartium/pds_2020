# -*- coding: utf-8 -*-
"""
Created on Thu Jul  9 20:37:41 2020

@author: Usuario
"""
import numpy as np

def generate_stimulus_signal(A,N,fs):
    #Por decto siempre trabajamos con frecuencia normalizada a 1Hz.
    fa = 0.01
    ## Generamos una senoidal
    xx = np.linspace(0,N*(1./fs),N,endpoint = False)
    yy = A*np.sin(2*np.pi*(fa/fs)*xx)    
    
    return xx,yy

