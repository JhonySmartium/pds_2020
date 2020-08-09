-- libraries
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- entity
entity adder_N is
  generic
  (
    N : integer
  );
  port
  (
    in1_i : in  std_logic_vector(N-1 downto 0);
    in2_i : in  std_logic_vector(N-1 downto 0);
    sum_o : out std_logic_vector(N   downto 0)
  );
end entity adder_N;

-- architecture
architecture rtl of adder_N is
begin

  -- También se puede resize
  sum_o <= std_logic_vector(unsigned("0" & in1_i) + unsigned("0" & in2_i));

end architecture rtl;
