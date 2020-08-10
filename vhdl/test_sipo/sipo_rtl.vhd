--------------------------------------------------------------------------------
--
-- Title    : sipo_rtl.vhd
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

entity sipo_rtl is
  generic (
          N_OUTPUT_BIT_WIDTH : integer := 8
      );
  port (
    clk_i           : in std_logic;
    a_reset_ni      : in std_logic;
    data_i          : in std_logic;
    load_t_i        : in std_logic;
    --Interfaz de salida
    data_o          : out std_logic_vector(N_OUTPUT_BIT_WIDTH-1 downto 0);
    data_valid_t_o  : out std_logic
  ) ;
end entity ; -- sipo_rtl

architecture rtl of sipo_rtl is

    --Acuerdense que vamos a tener que contar hasta la cantidad de bits de salida
    signal counter : integer range 0 to N_OUTPUT_BIT_WIDTH;
begin

rtl_proc : process (a_reset_ni, clk_i)
begin
  if (a_reset_ni = '0') then
    counter         <= 0;
    data_o          <= (others => '0');
    data_valid_t_o  <= '0';
  elsif (rising_edge(clk_i)) then
    --Dato serie es valido
    if (load_t_i = '1') then
        --El bit que entra lo voy poniendo por abajo
        data_o <= data_o(data_o'LEFT-1 downto 0) & data_i;    
        if (counter >= N_OUTPUT_BIT_WIDTH - 1) then
            counter <= 0;
            data_valid_t_o <= '1';
        else
            counter <= counter + 1;
            data_valid_t_o <= '0';
        end if;
    else 
        --Por defecto siempre nos aseguramos que no tengamos el valid a la salida.
        data_valid_t_o <= '0';
    end if;
  end if;
end process rtl_proc;

end architecture ; -- rtl