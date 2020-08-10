--------------------------------------------------------------------------------
--
-- Title    : ffd_vector.vhd
-- Project  : PDS 2020
-- Author   : Gonzalo Lavigna
--------------------------------------------------------------------------------
--
-- Description
-- 
--------------------------------------------------------------------------------
library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity ffd_vector is
  generic (
      N : integer := 8
  );
  port (
    clk_i       : in  std_logic;
    a_reset_ni  : in  std_logic;
    --Señales de datapath
    data_i      : in  std_logic_vector(N-1 downto 0);
    data_o      : out std_logic_vector(N-1 downto 0);
    --Señal de enable. Esta señal siempre esperamos que sea una señal de trigger.
    enable_t_i  : in  std_logic
  ) ;
end entity ; -- ffd_vector

architecture rtl of ffd_vector is
    signal reg_in : std_logic_vector(data_o'RANGE);
begin

    reg_process : process (a_reset_ni, clk_i)
    begin
      if (a_reset_ni = '0') then
        reg_in <= (others => '0');
      elsif (rising_edge(clk_i)) then
        if (enable_t_i = '1') then
            reg_in <= data_i;         
        end if;    
      end if;
    end process reg_process;

data_o <= reg_in;
end architecture ; -- rtl
