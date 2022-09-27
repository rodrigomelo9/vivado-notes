# Automatic Gated Clock Conversion

> **NOTE:** "Auto Gated Clock Conversion" on Quartus, "Fix Gated and Generated Clocks" on Synplify Pro.

> **ATTENTION:** this technique shouldn't be used as common practice in FPGA design. It is particularly useful when performing FPGA prototyping and clock gating can't be replaced with a wire.

If a design contains clock gating constructs that are necessary for proper operation, there are synthesis tools that can rewrite gates in the clock path as an enable in the data path.

Requisites:
* You must have constructs in the form of `assign clk_gated = clk & clk_en;` (Verilog) or `clk_gated <= clk and clk_en;` (VHDL).
  > **NOTE:** AND is one of the most common forms of gated clocks, but Vivado also supports other constructs such as OR, registered gates, and clock dividers.
* `clk_gated` must be used as the clock of an `always`/`process`.
* The gated clock must be specified as a clock with a `create_clock` constraint (**ATTENTION**).
* Enable gated clock conversion:
  * GUI: Settings -> Synthesis -> select `auto` (or `on`) for `-gated_clock_conversion`.
  * Tcl Console: `set_property STEPS.SYNTH_DESIGN.ARGS.GATED_CLOCK_CONVERSION auto [get_runs synth_1]` (or `on`).
    > **NOTE:** `auto` converts all the found constructs, while `on` needs the addition of an attribute in the clock signals to be converted (`(* gated_clock = "yes" *) input clk;`).

> **ATTENTION:** when the conversion is taking place, the tool extracts the clock from the rest of the logic and creates a new clock, and a clock enable. If the gated clock and the related registers are on different hierarchical levels, and there is something maintaining the hierarchy (`-flatten_hierarchy`, `dont_touch`, `keep_hierarchy`, etc) the tool won't be able to perform the conversion.

Example code [here](top.v) (RTL) and [here](clock.xdc) (constraint).

Before "Automatic Gated Clock conversion":

![Before](images/before.png)

After "Automatic Gated Clock conversion":

![After](images/after.png)

Drawbacks:
* More clock enables implies more control sets, which can be a problem.
* Depending on the gated clock implementation, you could have differences between simulation and synthesis code (there is an example in the ARM white paper [Prototyping ARM Cortex-A Processors using FPGA platforms](https://developer.arm.com/documentation/ecm0545815/latest)).
