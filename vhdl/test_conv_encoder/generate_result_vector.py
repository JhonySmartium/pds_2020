# -*- coding: utf-8 -*-
"""
Created on Thu Jul 30 05:29:50 2020

@author: Usuario
"""

import numpy as np
import sk_dsp_comm.sigsys as ss
import scipy.signal as signal
import scipy.special as special
import sk_dsp_comm.digitalcom as dc
import sk_dsp_comm.fec_conv as fec

#Como siempre gracias stackoverflow
#https://stackoverflow.com/questions/10321978/integer-to-bitfield-as-a-list
def bitfield(n):
    return [int(digit) for digit in '{0:04b}'.format(n)] 

cc1 = fec.fec_conv(('1111001','1011011'))


#Generamos el arreglo con todos los datos necesarios en formato de bits.
#En nuestro testbench tenemos desde 0 a 15, de a 4 bits.

int_array = np.arange(0,16)
#Nos quedamos con los ultimos 4 bits o sea los menos significativos
bit_array =  np.array([bitfield(item) for item in int_array])
bit_array =  bit_array.reshape(bit_array.size,1)
#Aca todo perfectamente serializado. Siendo el orden de envio MSb FIRST+
# Cadena a enviar 0x0 0x0 ........................0xE 0xF
# Cadena a enviar 0000 0001                       1110 1111

y,state = cc1.conv_encoder(bit_array,'0000000')
y = np.array(y,dtype = np.int8)
y = y.reshape(y.size//4,4)[:,::-1]
y = [np.packbits(item,bitorder = 'little')[0] for item in y]

#Imprimimos el resultado
for item in y:
    print('%X'%(item))
  
    
cc1 = fec.fec_conv(('1111001','1011011'))
y = cc1.conv_encoder([1,0,0,0,0,0,0,0],'0000000')



#Como siempre gracias stackoverflow
#https://stackoverflow.com/questions/10321978/integer-to-bitfield-as-a-list
def bitfield(n):
    return [int(digit) for digit in '{0:016b}'.format(n)] 


cc1 = fec.fec_conv(('1111001','1011011'))
state = '0000000'
result = np.array([],dtype=np.uint8)
int_array = np.array([0x0001,0x1000,0xAAAA],dtype=np.uint64)
for item in int_array:
    bit_array =  bitfield(item)
    bit_array = bit_array[::-1]
    y,state = cc1.conv_encoder(bit_array,state)
    y = np.packbits(y[::-1].astype(np.int64),bitorder = 'big')
    result = np.concatenate([result,y])

#Ahora lo imprimimos de una manera coherencia
result = result.reshape(result.size//4,4).astype(dtype = np.int64)

for item in result:
    [hex(nibble) for nibble in item]
    
print_value = '0x' + hex(int.from_bytes(list(result[0]),byteorder = 'big'))[2:].zfill(8)