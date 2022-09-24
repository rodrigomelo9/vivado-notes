# Verilog Configuration

A configuration is employed to specify the module/source to be used by one/all the instance/s of a module in a design.

Syntax:
```verilog
config CONFIG_NAME;
  design [ LIB_NAME. ]TOP;
  [ default liblist LIB_NAME LIB_NAME ...; ]
  [ instance_or_cell INSTANCE_OR_CELL_NAME location; ]
endconfig

instance_or_cell = instance | cell
location = liblist LIB_NAME | use what_to_use
what_to_use = [ LIB_NAME. ]instance [ : CONFIG_NAME ] | CONFIG_NAME
```

Example code [here](top.v).

The applied configuration can be appreciated under the Design Sources, as well as the replaced module

![Sources](images/sources.png)

After the elaboration, you can appreciate how the second AND cell was replaced by an OR cell

![Elaboration](images/elaboration.png)