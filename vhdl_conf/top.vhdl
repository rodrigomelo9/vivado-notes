-------------------------------------------------------------------------------
-- Architecture to be replaced
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity opx is
  port (
    in1  :  in std_logic;
    in2  :  in std_logic;
    outx : out std_logic
  );
end entity opx;

architecture op_or of opx is
begin

  outx <= in1 or in2;

end architecture op_or;

architecture op_and of opx is
begin

  outx <= in1 and in2;

end architecture op_and;

-------------------------------------------------------------------------------
-- Auxiliary entity
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity aux is
  port (
    in1  :  in std_logic;
    in2  :  in std_logic;
    outx : out std_logic
  );
end entity aux;

architecture Structural of aux is

  component opx is
    port (
      in1  :  in std_logic;
      in2  :  in std_logic;
      outx : out std_logic
    );
  end component opx;

begin

  opx_i: opx
  port map (in1 => in1, in2 => in2, outx => outx);

end architecture Structural;

-------------------------------------------------------------------------------
-- Top-level
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity top is
  port (
    in1  :  in std_logic;
    in2  :  in std_logic;
    out1 : out std_logic;
    out2 : out std_logic
  );
end entity top;

architecture Structural of top is

  component aux is
    port (
      in1  :  in std_logic;
      in2  :  in std_logic;
      outx : out std_logic
    );
  end component aux;

begin

  aux1_i: aux
  port map (in1 => in1, in2 => in2, outx => out1);

  aux2_i: aux
  port map (in1 => in1, in2 => in2, outx => out2);

end architecture Structural;

-------------------------------------------------------------------------------
-- Configuration
-------------------------------------------------------------------------------

use WORK.all;

configuration cfg of top is
  for Structural
    for aux2_i : aux
      use entity work.aux(Structural);
      for Structural
         for opx_i : opx
          use entity work.opx(op_or);
        end for;
       end for;
    end for;
  end for;
end configuration;
