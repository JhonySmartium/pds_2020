--------------------------------------------------------------------------------
--
-- Title    : test_resize.vhd
-- Project  : PDS 2020
-- Author   : Gonzalo Lavigna
--------------------------------------------------------------------------------
--
-- Description
-- Tenemos 2 entradas una se interpreta como signed y la otra como unsigned.
-- Ver mas documentación en https://www.csee.umbc.edu/portal/help/VHDL/numeric_std.vhdl
--------------------------------------------------------------------------------
library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;


entity test_resize is
  generic (
    N_INPUT     : integer := 8;
    N_OUTPUT    : integer := 16
  );
  port (
    --Tratamiento señales signed
    data_i      : in  std_logic_vector(N_INPUT-1  downto 0);
    --Tratamiento señales unsigned
    signed_o    : out std_logic_vector(N_OUTPUT-1 downto 0);
    unsigned_o  : out std_logic_vector(N_OUTPUT-1 downto 0)
  ) ;
end entity ; -- test_resize

architecture behauvioral of test_resize is

begin

    unsigned_o <= std_logic_vector(resize(unsigned(data_i),N_OUTPUT));
    signed_o   <= std_logic_vector(resize(signed(data_i)  ,N_OUTPUT));

end architecture ; -- behauvioral
