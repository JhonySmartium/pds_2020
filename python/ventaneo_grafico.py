# -*- coding: utf-8 -*-
"""
Created on Wed Jul 15 13:06:36 2020

@author: Usuario
"""

import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
from  matplotlib import patches
from matplotlib.figure import Figure
from matplotlib import rcParams


N   = 100
t_s = 1
f_s = 1./t_s 
interval_ms = 500
tt  = np.linspace(0,N,N,endpoint = False)


plt.close('all')
print('Presción en frecuencia :{} HZ'.format(f_s/N))

#Esta es la cantidad de frecuencias que vamos a generar.
f_a_0 = 0.1 + 0.01
f_a_1 = 0.1 + 0.04
n_frec = 30
freq_vector = np.linspace(f_a_0,f_a_1,n_frec,endpoint = False)
#Con este vector de frecuencias vamos a atravesar frecuencias que no son multiplos.

def get_sin(f_a):
    return np.sin(2*np.pi*f_a*tt)

#Generamos la igura
fig = plt.figure(figsize = (10,10))

#Señal en el tiempo.
ax_sin = fig.add_subplot(2,2,1)
ax_sin.set_ylim(-1.5,1.5)
ax_sin.set_xlim(0,N)
ax_sin.grid(True)
ax_sin.set_title("Señal sin ventanear")
sin_data = []
sin_line,sin_dot, = plt.plot([],[],'k',[],[],'ro')

eje_f = np.fft.fftfreq(np.size(tt),t_s)

#FFT sin ventana
ax_fft = fig.add_subplot(2,2,2)
ax_fft.grid(True)
ax_fft.set_ylim(0,40)
ax_fft.set_xlim(-0.5,0.5)
fft_data = []
fft_line,fft_dot, = plt.plot([],[],'k',[],[],'ro')
ax_fft.set_title("FFT sin ventanear")

#FFT con ventana, vamos a usar una ventana de hanning
ax_win = fig.add_subplot(2,2,3)
ax_win.set_ylim(-1.5,1.5)
ax_win.set_xlim(0,N)
ax_win.grid(True)
ax_win.set_title("Señal ventaneada")
win_data = []
win_line,win_dot, = plt.plot([],[],'k',[],[],'ro')

#FFT con ventana, vamos a usar una ventana de hanning
ax_fft_win = fig.add_subplot(2,2,4)
ax_fft_win.set_ylim(0,40)
ax_fft_win.set_xlim(-0.5,0.5)
ax_fft_win.grid(True)
ax_fft_win.set_title("FFT con ventaneo")
win_fft_data = []
fft_win_line,fft_win_dot, = plt.plot([],[],'k',[],[],'ro')


def init():
    return sin_data,fft_data,sin_line,sin_dot,fft_line,fft_dot,win_line,win_dot,fft_win_line,fft_win_dot

def update(n):
    global sin_data,eje_f,fft_data,sin_line,fft_line,fft_dot,win_line,win_dot,fft_win_line,fft_win_dot
    sin_data = get_sin(freq_vector[n])
    sin_line.set_data(tt,sin_data)
    sin_dot.set_data(tt,sin_data)
    
    X = 20*np.log10(np.abs(np.fft.fft(sin_data)))
    fft_line.set_data(np.fft.fftshift(eje_f),np.fft.fftshift(X))
    fft_dot.set_data(np.fft.fftshift(eje_f),np.fft.fftshift(X))
    fig.suptitle("Presición en frecuencia: %2.4f Hz /// F_A = %2.4f Hz " % (f_s/N,freq_vector[n]))
    
    win_data = get_sin(freq_vector[n])*np.hanning(np.size(sin_data))
    win_line.set_data(tt,win_data)
    win_dot.set_data(tt,win_data)
    
    X_win = 20*np.log10(np.abs(np.fft.fft(win_data)))
    fft_win_line.set_data(np.fft.fftshift(eje_f),np.fft.fftshift(X_win))
    fft_win_dot.set_data(np.fft.fftshift(eje_f),np.fft.fftshift(X_win))
    
    return sin_line,sin_dot,fft_line,fft_dot,win_line,win_dot,fft_win_line,fft_win_dot
    
ani=FuncAnimation(fig,update,frames = np.size(freq_vector) ,init_func = init,interval=interval_ms)
