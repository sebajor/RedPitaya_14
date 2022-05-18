import mmap, os, time, struct
import numpy as np


def sinewave(bram_mm, reg_mm, f1=5,f2=2,dec=0, offset=0,amp=0.5):
    """ f : normalized frequency
        dec: decimation factor
    """
    total = 8192
    t = np.arange(total)
    x1 = amp*np.sin(2*np.pi*t*f1/total)+offset
    x2 = amp*np.sin(2*np.pi*t*f2/total)+offset
    dat = np.vstack([x1,x2])
    dat = dat.T.flatten()
    ##quantize to 14 bits
    dat = (dat*2**13).astype(int)
    dat = struct.pack('16384h', *dat)
    bram_mm[:4*2**13] = dat
    reg_mm[4:8] = struct.pack('I', dec)
    reg_mm[0] = 0b101

def upload_beat(bram_mm, reg_mm, dat1,dat2,dfl_val1,dfl_val2,dec=0):
    """
    """
    reg_mm[0] = 0b010
    reg_mm[0] = 0b000
    dat = np.vstack([dfl_val1,dfl_val2])
    dat = dat.T.flatten()
    reg_mm[8:12] = struct.pack('2h', *(dat*2**13).astype(int))
    dat = np.vstack([dat1,dat2])
    dat = dat.T.flatten()
    ##quantize to 14 bits
    dat = (dat*2**13).astype(int)
    dat = struct.pack('16384h', *dat)
    bram_mm[:4*2**13] = dat
    reg_mm[4:8] = struct.pack('I', dec)
    

def beat_transfer(reg_mm, dec=0):
    reg_mm[0] = 0b010
    reg_mm[4:8] = struct.pack('I', dec)
    reg_mm[0] = 0b000
    reg_mm[0] = 0b1


def cont_transfer(reg_mm, dec=0):
    reg_mm[0] = 0b010
    reg_mm[4:8] = struct.pack('I', dec)
    reg_mm[0] = 0b000
    reg_mm[0] = 0b101


bitfile = 'signal_gen.bit'
os.system('cat '+bitfile+' > /dev/xdevcfg')
time.sleep(1)

reg_start = 0x43c00000
reg_len = 2**3*4

#reg[0]    = bit0:en read
#            bit1:rst_read
#            bit2:continous
#reg[4:8]  = dec_rate
#reg[8:12] = dac_default 

bram_start = 0x43c08000
bram_len = 2**13*4


mem_file = '/dev/mem'
mem = open(mem_file, 'r+b')

reg_mm = mmap.mmap(mem.fileno(), reg_len, offset=reg_start)
bram_mm = mmap.mmap(mem.fileno(), bram_len, offset=bram_start)

##single beat data
dat1 = np.linspace(-0.98,0.98,8192,endpoint=False)
dat2 = -dat1
dfl_val1 = 0.98
dfl_val2 = 0.5

#upload_beat(bram_mm, reg_mm, dat1, dat2, dfl_val1,dfl_val2)
#cont_transfer(reg_mm, dec=0)
#beat_transfer(reg_mm, dec=2**15)
#
sinewave(bram_mm, reg_mm,f1=5,f2=2,dec=2**10, amp=0.3, offset=0.6)
