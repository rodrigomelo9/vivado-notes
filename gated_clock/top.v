module top (
  input      clk,
  input      clk_en,
  input      data_in,
  output reg data_out
);

  wire clk_gated;

  assign clk_gated = clk & clk_en;

  always @(posedge clk_gated) begin
    data_out = data_in;
  end

endmodule
