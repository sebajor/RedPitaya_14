import numpy as np
import cocotb
from cocotb.triggers import ClockCycles, RisingEdge
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge, ClockCycles
from cocotbext.axi import AxiLiteBus, AxiLiteMaster, AxiLiteRam
from scipy.fftpack import fft
from two_comp import two_comp_unpack, two_comp_pack
import matplotlib.pyplot as plt


AXI_PERIOD = 8
FPGA_PERIOD = 16

def setup_dut(dut, default_value=4, dec_rate=9):
    ##
    cocotb.fork(Clock(dut.axi_clock, AXI_PERIOD, units='ns').start())
    dut.continous <=0
    dut.rst <= 1
    dut.s_axil_araddr <= 0
    dut.s_axil_arprot <= 0
    dut.s_axil_arvalid <= 0
    dut.s_axil_rready <= 0
    dut.rst_read <= 1;
    dut.dec_rate <= int(dec_rate-1);
    dut.default_value <= int(default_value)
    dut.en_read <= 0;
    axil_master = AxiLiteMaster(AxiLiteBus.from_prefix(dut, "s_axil"), dut.axi_clock, dut.rst)
    return axil_master


@cocotb.test()
async def axil_bram(dut, bram_addr=8):
    axil_master = setup_dut(dut, dec_rate=4)
    await RisingEdge(dut.axi_clock)
    dut.rst <= 0
    dut.rst_read <=0
    await ClockCycles(dut.axi_clock, 5)
    print("writing data into the bram")
    test_data = [x+1 for x in range(2**bram_addr)]
    wdata = await axil_master.write_dwords(0, test_data)
    await ClockCycles(dut.axi_clock, 2)
    print("start reading data")
    dut.en_read <= 1
    await ClockCycles(dut.axi_clock, 1)
    await RisingEdge(dut.finish_read)
    await ClockCycles(dut.axi_clock, 100)
    ##now we ask for read continously
    await cont_test(dut, axil_master)


async def cont_test(dut, axil_master,dec_rate=0,f=1.,fs=256):
    """Write a sinewave to the 
    """
    dat0 = np.sin(2*np.pi*f/fs*np.arange(256))
    dat = dat0#+dat1*2**16
    dat = two_comp_pack(dat, 14,12)
    dat = dat.tolist()
    wdata = await axil_master.write_dwords(0, dat)
    await ClockCycles(dut.axi_clock, 2)
    dut.continous <=1
    dut.dec_rate <= dec_rate
    data = np.zeros(2048)
    for i in range(2048):
        await ClockCycles(dut.axi_clock, 1)
        out = np.array(int(dut.dout.value))
        out = two_comp_unpack(out, 14,12)
        data[i] = out
    #np.savetxt('cont_data.txt',data)
    plt.plot(data)
    plt.grid()
    plt.savefig('out_data.png')
    plt.clf()

    
    
    
    

    
