//-----------------------------------------------------------------------------
// Module to be replaced
//-----------------------------------------------------------------------------

module op_or (
  input in1,
  input in2,
  output outx
);

  assign outx = in1 | in2;

endmodule

module op_and (
  input in1,
  input in2,
  output outx
);

  assign outx = in1 & in2;

endmodule

//-----------------------------------------------------------------------------
// Auxiliary module
//-----------------------------------------------------------------------------

module aux (
  input in1,
  input in2,
  output outx
);

  op_and opx_i (.in1(in1), .in2(in2), .outx(outx));

endmodule

//-----------------------------------------------------------------------------
// Top-level
//-----------------------------------------------------------------------------

module top (
  input  in1,
  input  in2,
  output out1,
  output out2
);

  aux aux1_i (.in1(in1), .in2(in2), .outx(out1));
  aux aux2_i (.in1(in1), .in2(in2), .outx(out2));

endmodule

//-----------------------------------------------------------------------------
// Configuration
//-----------------------------------------------------------------------------

config cfg;
  design top;
  instance top.aux2_i.opx_i use op_or;
endconfig
