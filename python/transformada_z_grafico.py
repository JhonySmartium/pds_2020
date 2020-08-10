# -*- coding: utf-8 -*-
"""
Created on Wed Jul 15 10:10:54 2020

@author: Usuario
"""

import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
from  matplotlib import patches
from matplotlib.figure import Figure
from matplotlib import rcParams

N = 128
interval_ms = 250
f_s = 1.
t_s = 1.


def circle(w):
    return np.exp(1j*w)

w = np.linspace(0,2*np.pi,N,endpoint=False)
circle_point = np.array([circle(item) for item in w])


plt.close('all')

fig = plt.figure(figsize = (4,30))

ax_uc = fig.add_subplot(3,1,1)
ax_uc.set_xlim(-1.5,1.5)
ax_uc.set_ylim(-1.5,1.5)
uc    = patches.Circle((0,0), radius=1, fill=False,color='black', ls='dashed')
ax_uc.add_patch(uc)
ax_uc.grid(True)

#Declaración del cero.
z = 0.75 + 1j*0
#Dibujamos el cero.
t1 = ax_uc.plot(z.real, z.imag, 'go', ms=10)
plt.setp( t1, markersize=10.0, markeredgewidth=1.0,markeredgecolor='k',markerfacecolor='g')
# set the ticks
ticks = [-1, -.5, 0 , .5, 1]; plt.xticks(ticks); plt.yticks(ticks)
### Recorremos el circulo uinitario en algunas frecuencia equidistantes
circleLn,circleLn_solid, = plt.plot([],[],'bo',[],[],'r')
circleData  = []
circleLg=ax_uc.legend()
### Dibujamos la magnitud en función de la distancia con la singularidad.
ax_mag = fig.add_subplot(3,1,2)
ax_mag.set_ylim(0,2.5)
ax_mag.set_xlim(0,w[-1])
ax_mag.grid(True)
ax_mag.set_title("Magnitud")

#Este es la respuesta en magnitud total
#Este es el punto actual que corresponde con la transformada Z
#Este es una linea vertical del mismo tamaño que la del plano Z
mag_line,mag_point,mag_bar, = plt.plot([],[],'k',[],[],'bo',[],[],'r')
mag_data = []

ax_angle = fig.add_subplot(3,1,3)
ax_angle.set_ylim(-3,3)
ax_angle.set_title("Fase")
ax_angle.set_xlim(0,w[-1])
ax_angle.grid(True)

ang_line,ang_point,ang_bar, = plt.plot([],[],'k-',[],[],'bo',[],[],'r')
ang_data = []


def init():
    return circleLn,circleLg,circleLn_solid,mag_line,mag_point,mag_bar,mag_data,ang_line,ang_point,ang_bar

def update(n):
    global circleLn,circleLg,circleLn_solid,mag_line,mag_point,mag_bar,mag_data,ang_data,ang_line,ang_point,ang_bar
    #circleData.append(circle_point[n])
    circleData = circle_point[n]
    circleLn.set_data(np.real(circleData),np.imag(circleData))
    circleLn_solid.set_data([np.real(circleData),np.real(z)],[np.imag(circleData),np.imag(z)])
    
    mag_data.append(np.abs(circleData-z))
    mag_line.set_data(w[0:n+1],mag_data)
    mag_point.set_data(w[n],mag_data[n])
    mag_bar.set_data([w[n],w[n]],[0,mag_data[n]])
    
    ang_data.append(np.angle(circleData-z))
    ang_line.set_data(w[0:n+1],ang_data)
    ang_point.set_data(w[n],ang_data[n])
    ang_bar.set_data([w[n],w[n]],[0,ang_data[n]])
    
    fig.suptitle("Mag = %2.2f, Angle = %2.2f" % (np.abs(circleData-z),np.angle(circleData-z)), fontsize=12)
    if n==N-1:
        circleData = []
        mag_data   = []
        ang_data   = []

    return circleLn,circleLn_solid,mag_line,mag_point,mag_bar

ani=FuncAnimation(fig,update,frames = N ,init_func = init,interval=interval_ms  )
plt.show()

#circleLn[].set_data(1,0)