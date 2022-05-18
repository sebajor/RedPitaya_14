import mmap, os, time, struct
import numpy as np

def upload_bitfile(bitfile):
    os.system('cat '+bitfile+' > /dev/xdevcfg')
    time.sleep(1)

def get_time(reg_mm):
    time_data = struct.unpack('I',reg_mm[5*4:6*4])[0]
    secs = time_data&63
    mins = (time_data&(63<<6))>>6
    hour = (time_data&(31<<12))>>12
    day = (time_data&((2**9-1)<<17))>>17
    return [secs,mins,hour,day]

def actual_time(reg_mm):
    time_data = struct.unpack('I',reg_mm[6*4:7*4])[0]
    secs = time_data&63
    mins = (time_data&(63<<6))>>6
    hour = (time_data&(31<<12))>>12
    day = (time_data&((2**9-1)<<17))>>17
    return [secs,mins,hour,day]

bitfile = 'irig_bcd.bit'
upload_bitfile(bitfile)

reg_start = 0x43c00000
reg_len = 2**3*4

##reg map
##  0(w):  [0]:start calibration
##      [1]:rst irig system
##  1(w):  one_count
##  2(w):  zero_count
##  3(w):  id_pos_count
##  4(w):  debounce
##  5(r):  time data
#   6(r):  actual time

mem_file = '/dev/mem'
mem = open(mem_file, 'r+b')

reg_mm = mmap.mmap(mem.fileno(), reg_len, offset=reg_start)

time.sleep(1)
fpga_clk = 125*10**6
sec_parameter = 1.05

#some parameters
zero_val = int(0.2*fpga_clk/100*sec_parameter)
one_val = int(0.5*fpga_clk/100*sec_parameter)
id_pos = int(0.8*fpga_clk/100*sec_parameter)

debounce = 50



###write the configuration parameters
reg_mm[:4] = struct.pack('I', 0b10)
reg_mm[4:8] = struct.pack('I', one_val)
reg_mm[8:12] = struct.pack('I', zero_val)
reg_mm[12:16] = struct.pack('I', id_pos)
reg_mm[16:20] = struct.pack('I', debounce)

time.sleep(0.5)
reg_mm[:4] = struct.pack('I', 1)

time.sleep(3)
time_data = get_time(reg_mm)
print(time_data)

time_data = actual_time(reg_mm)
print(time_data)


