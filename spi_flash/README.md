# SPI Flash

Instructions to configure the bitstream and generate an MCS file compatible with QSPI for UltraScale devices.

With an Open Implementated Design, set the following properties and then, generate a new bitstream:
```tcl
set_property BITSTREAM.CONFIG.CONFIGRATE 63.8 [current_design]
set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR YES [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
set_property CONFIG_VOLTAGE 1.8 [current_design]
set_property CFGBVS GND [current_design]
```

When the new bitstream is available, you can run the following to generate the MCS file:
```tcl
write_cfgmem -format mcs -size <MBYTES> -interface SPIx4 -loadbit "up 0x00000000 <PATHNAME>.bit" -file <PATHNAME>.mcs
```

> **NOTES:**
> * MBYTES is the SIZE of the memory in MB (must be power of 2).
> * This example (property values) is based on a VCU128 board.
> * More info at [SPI Configuration and Flash Programming in UltraScale FPGAs (XAPP1233)](https://docs.xilinx.com/v/u/en-US/xapp1233-spi-config-ultrascale).

## Further explanation

* `BITSTREAM.CONFIG.CONFIGRATE 63.8`: configuration rate in MHz (`list_property_value BITSTREAM.CONFIG.CONFIGRATE [current_design]`)
* `BITSTREAM.CONFIG.SPI_32BIT_ADDR YES`: to issue 4-byte addressing commands (set YES for densities >= 256 Mb)
* `BITSTREAM.CONFIG.SPI_BUSWIDTH 4`: set data width (4 is the recommended for UltraScale)
* `BITSTREAM.CONFIG.SPI_FALL_EDGE YES`: set to YES causes the read data to be clocked on the following edge, improving the timing margins (faster clock rates)
* `BITSTREAM.GENERAL.COMPRESS TRUE`: compress the generated bitstream (recommended)
* `CONFIG_MODE SPIx4`: should match SPI_BUSWIDTH (DRC check)
* `CONFIG_VOLTAGE 1.8`: set this to the voltage being used on the configuration banks (bank 0 or bank 65 if using EMCCLK)
* `CFGBVS GND`: voltage driving the CFGBVS pin (`GND` or `VCCO`, depends on the board, so check the schematic)
