from jinja2 import Environment, FileSystemLoader
import os



def calc_next_offset(curr_addr, curr_size, next_size):
    """ Check if the next address is going to break the alignment
        and calculate the next address accordingly
    """
    next_addr = curr_addr+1024*curr_size
    if((next_addr%(2**16))!=0):
        wall = ((next_addr>>16)+1)<<16
        flag = wall-(next_addr+next_size*1024)
        if(flag<0):
            next_addr = wall
    return next_addr

def gen_parameters(slave_addr_size=[], slave_base_addr=0x43c00000, incon_name="intercon0", 
        hp_addr_offset=[],hp_addr_size=[], hp_size=32, ipi_dma_write=0, ipi_dma_read=0,
        dma_read_clk='axi_clock', dma_write_clk='axi_clock'):
    """
        slave_addr_sizes: list with nslaves items. Sizes are in kB.
        hp_addr_offset  : list with n_hp_ports items with the base addr of the hp ports
        hp_addr_size    : list with n_hp_ports items with the addr size of the hp ports in MB
        hp_size         : the hp port bit width
    """

    if((hp_size!=32) and (hp_size!=64)):
        raise Exception("hp_size could be 32 or 64!")
    
    #AXI lite slaves

    nslaves = len(slave_addr_size)
    if(nslaves>0):
        port = ["M%02d_AXI" % x for x in range(nslaves)]
        mclk = ["M%02d_ACLK" % x for x in range(nslaves)]
        size = []; off = []

        clk_group = ""
        axil_ports = []

        next_addr = slave_base_addr
        for i in range(nslaves-1):
            off = hex(next_addr)
            size = str(slave_addr_size[i])+"K"
            clk_group = clk_group+port[i]+":"
            next_addr = calc_next_offset(int(off, base=16), slave_addr_size[i], slave_addr_size[i+1])
            dic = {"port": port[i], "offset":off, "size":size, "mclk":mclk[i]}
            axil_ports.append(dic)
        size = str(slave_addr_size[-1])+"K"
        off = hex(next_addr)
        dic = {"port": port[-1], "offset":off, "size":size, "mclk":mclk[-1]}
        axil_ports.append(dic)
        clk_group = clk_group+port[-1]

    #AXI full HP
    n_hp_ports = len(hp_addr_size)
    hp_ports = []
    for i in range(n_hp_ports):
        dic = {"offset":hp_addr_offset[i], "size":(str(hp_addr_size[i])+'M')}
        hp_ports.append(dic)

    #IPI DMA
    dma_num = (ipi_dma_write | ipi_dma_read)
    
    config= {
        "nslaves"       : nslaves,
        "incon_name"    : incon_name,
        "axi_ports"     : axil_ports,
        "clk_group"     : clk_group,
        "n_hp_ports"    : n_hp_ports,
        "hp_ports"      : hp_ports,
        "hp_size"       : hp_size,
        "ipi_dma_num"   : dma_num, 
        "ipi_dma_write" : ipi_dma_write,
        "dma_write_clk" : dma_write_clk,
        "ipi_dma_read"  : ipi_dma_read,
        "dma_read_clk"  : dma_read_clk
        }
    
    return config


    

if __name__ =='__main__':
    templates_dir = os.path.dirname(os.path.abspath('templates'))
    j2_env = Environment(loader=FileSystemLoader(templates_dir),
                             trim_blocks=True)

    slave_addr_size = [64, 64, 64, 64, 64, 64,32]
    hp_addr_offset = []#[0x0]
    hp_addr_size = []#[512]
    hp_size = 64
    ipi_dma_write = 0
    ipi_dma_read = 0
    dma_write_clk = 'axi_clock'
    dma_read_clk = 'axi_clock'
    
    axilite = gen_parameters(slave_addr_size=slave_addr_size, hp_addr_offset=hp_addr_offset,
            hp_addr_size=hp_addr_size, hp_size=hp_size, ipi_dma_write=ipi_dma_write,
            dma_write_clk=dma_write_clk, ipi_dma_read=ipi_dma_read, dma_read_clk=dma_read_clk)

    parsed_code=j2_env.get_template('templates/axi_lite.tcl').render(axilite=axilite);

    with open("rp_template.tcl", "w") as f:
        f.write(parsed_code)


    parsed_top = j2_env.get_template('templates/fpga.v').render(axilite=axilite);

    with open("top_template.v", "w") as f:
        f.write(parsed_top)
