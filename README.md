#Red Pitaya 14

Repository with red pitaya models.

##TODO
- [x] Led controlled by axilite register.
- [x] Snapshot, using bram controlled by axilite.
- [x] IRIG-B00x GPS timestamp.
- [x] Signal generator.
- [ ] NMEA GPS timestamp.
- [ ] tcl template generator.
- [ ] sccb camera.
- [ ] DMA snapshot using axi full.
- [ ] DMA transmitter. (DMA-> FPGA-> DAC)
- [ ] mSDFT correlator.
- [ ] Spectrometer.
- [ ] Time correlator.
- [ ] Frequency counter.
- [ ] Pocket VNA.
- [ ] Radar (?)


## Setup
- Vivado 2019.1.1
- Pynq image from [here](https://github.com/dspsandbox/Pynq-Redpitaya-125)

To generate the bitfile run Make inside of one folder. You would need to have vivado in your PATH.

Some modules are taken from [here](https://github.com/sebajor/verilog_codes), also you could found the testbench there.
