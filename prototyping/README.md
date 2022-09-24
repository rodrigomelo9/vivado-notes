# FPGA prototyping

> **NOTE:** also knowns as ASIC prototyping, ASIC emulation or SoC prototyping

Prototype a SoC/ASIC designs in one or more FPGAs, for HW verification and early SW development.
Although an ASIC design in an FPGA could be slower (10:1 for 500 MHz), due to be not designed taking its architecture into account, it is still much more quicker than simulations (min/hours/days vs secs).

> **ATTENTION:** Synthesis and PnR are more complex and slower than simulations, so FPGA prototyping should start when the design is relatively stable and basic functionality was verified.

## The three “laws” of FPGA-prototyping

* Law 1: SoCs are larger than FPGAs
  * The design will probably need partitioning (or truncation)
* Law 2: SoCs are faster than FPGAs
  * The design may not be able to run at full SoC speed (not close)
* Law 3: SoC designs are FPGA-hostile
  * The design may need some rework in order to be made FPGA-friendly

## Basics

* Replace/remove analog blocks and unused logic:
  * Outputs should be driven: `1'b0` in general, `1'b1` in case of xREADY AMBA signals.
* Replace memories and IOs with FPGA resources (inference prefered).
* Remove (wire) clock gating always as possible.
  * When needed to work properly, you can use [Automatic gated clock conversion](../gated_clock).

## Tips for Synthesis

## Tips for Place & Route
