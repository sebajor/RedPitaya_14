import os, mmap, time
import struct
import numpy as np

class mmio():
    def __init__(self, base_addr, length):
        mmap_file = os.open('/dev/mem',  os.O_RDWR | os.O_SYNC)
        self.mem = mmap.mmap(mmap_file, length,
                        mmap.MAP_SHARED,
                        mmap.PROT_READ | mmap.PROT_WRITE,
                        offset=base_addr)
        os.close(mmap_file)

    def read_binary(self, offset, length):
        out = self.mem[offset:offset+length]
        return out

    def write_binary(self, offset, data):
        self.mem[offset:offset+len(data)] = data

    def read(self, offset, length, dtype='i4'):
        bin_data = self.read_binary(offset, length)
        out = np.frombuffer(bin_data, dtype=dtype)
        return out

    def write(self, offset, data, dtype='i4'):
        """data is a numpy array
        """
        dat = data.astype(dtype)
        bin_data = dat.tostring()
        self.write_binary(offset, bin_data)


def float2fixed(data, nbits, binpt, signed=True):
    """
    Convert an array of floating points to fixed points, with width number of
    bits nbits, and binary point binpt. Optional warinings can be printed
    to check for overflow in conversion.
    :param data: data to convert.
    :param nbits: number of bits of the fixed point format.
    :param binpt: binary point of the fixed point format.
    :param signed: if true use signed representation, else use unsigned.
    :param warn: if true print overflow warinings.
    :return: data in fixed point format.
    """
    nbytes = int(np.ceil(nbits/8))
    dtype = '>i'+str(nbytes) if signed else '>u'+str(nbytes)
    fixedpoint_data = (2**binpt * data).astype(dtype)
    return fixedpoint_data


