### Vector de prueba para testbench de encoder convolucional
### Se piensa el sistema como LSB Firt, o sea empezamos a recorrer usando el primer LSB.
### Instalar sk_dsp_comm con pypi.https://scikit-dsp-comm.readthedocs.io/en/latest/

import numpy as np
import sk_dsp_comm.sigsys as ss
import scipy.signal as signal
import scipy.special as special
import sk_dsp_comm.digitalcom as dc
import sk_dsp_comm.fec_conv as fec

#Como siempre gracias stackoverflow
#https://stackoverflow.com/questions/10321978/integer-to-bitfield-as-a-list
def bitfield(n):
    return [int(digit) for digit in '{0:016b}'.format(n)] 

cc1 = fec.fec_conv(('1111001','1011011'))
state = '0000000'
result = np.array([],dtype=np.uint8)
int_array = np.array([0x8001,0xD511,0x0181],dtype=np.uint64)
for item in int_array:
    bit_array =  bitfield(item)
    bit_array = bit_array[::-1]
    #El state siempre nos lo llevamos para el proximo word de 16 bits.
    print("Entrada\n",bit_array)
    y,state = cc1.conv_encoder(bit_array,state)
    print("Salida\n",y)
    y = np.packbits(y[::-1].astype(np.int64),bitorder = 'big')
    result = np.concatenate([result,y])

#Ahora lo imprimimos de una manera coherencia
result = result.reshape(result.size//4,4).astype(dtype = np.int64)

for item in result:    
    print('0x' + hex(int.from_bytes(list(item),byteorder = 'big'))[2:].zfill(8))    
    
     