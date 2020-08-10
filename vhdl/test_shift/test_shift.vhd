--------------------------------------------------------------------------------
--
-- Title    : test_shift.vhd
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


entity test_shift is
  generic (
    BIT_WIDTH : integer := 8;
    N_SHIFTS  : integer := 1
  );
  port (
    --Tratamiento señales signed
    data_i : in std_logic_vector(BIT_WIDTH-1 downto 0);
    --Tratamiento señales unsigned
    signed_shift_left_o     : out std_logic_vector(BIT_WIDTH-1 downto 0);
    signed_shift_right_o    : out std_logic_vector(BIT_WIDTH-1 downto 0);
    signed_rotate_left_o    : out std_logic_vector(BIT_WIDTH-1 downto 0);
    signed_rotate_right_o   : out std_logic_vector(BIT_WIDTH-1 downto 0);
    unsigned_shift_left_o   : out std_logic_vector(BIT_WIDTH-1 downto 0);
    unsigned_shift_right_o  : out std_logic_vector(BIT_WIDTH-1 downto 0);
    unsigned_rotate_left_o  : out std_logic_vector(BIT_WIDTH-1 downto 0);
    unsigned_rotate_right_o : out std_logic_vector(BIT_WIDTH-1 downto 0)
  ) ;
end entity ; -- test_shift

architecture behauvioral of test_shift is

begin

  signed_shift_left_o     <= std_logic_vector(shift_left (signed(data_i),N_SHIFTS));
  signed_shift_right_o    <= std_logic_vector(shift_right(signed(data_i),N_SHIFTS));
  signed_rotate_left_o    <= std_logic_vector(rotate_left(signed(data_i),N_SHIFTS));
  signed_rotate_right_o   <= std_logic_vector(rotate_right(signed(data_i),N_SHIFTS));
  unsigned_shift_left_o   <= std_logic_vector(shift_left (unsigned(data_i),N_SHIFTS));
  unsigned_shift_right_o  <= std_logic_vector(shift_right(unsigned(data_i),N_SHIFTS));
  unsigned_rotate_left_o  <= std_logic_vector(rotate_left(unsigned(data_i),N_SHIFTS));
  unsigned_rotate_right_o <= std_logic_vector(rotate_right(unsigned(data_i),N_SHIFTS));


end architecture ; -- behauvioral
