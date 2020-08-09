--------------------------------------------------------------------------------
--
-- Title    : ejer_1.vhd
-- Project  : PDS 2020
-- Author   : Gonzalo Lavigna
-- Date     : 7/1/2020 11:02:53 AM
--------------------------------------------------------------------------------
--
-- Description
-- Prueba del ejercicio 1 hecho en VHDL 2008.
-- One process methodology
--------------------------------------------------------------------------------


-- Librerias IEEE
library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all ;


--Esto puede servir para unificar criterios de niveles de reset y tambien de por frecuencia
--de reloj.
--library commons;
--use commons.commons_pkg.all;

--Vamos con la implementación one process.

entity ejer_1 is
  port (
    clk_i       : in  std_logic;
    a_reset_i   : in  std_logic;
    s_reset_i   : in  std_logic;
    in_1_i      : in  std_logic_vector(2 downto 0);
    in_2_i      : in  std_logic_vector(2 downto 0);
    sel_i       : in  std_logic_vector(1 downto 0);
    --Salida
    overflow_o  : out std_logic;
    --Ancho de la salida es 7 bits.
    out_reg_o   : out std_logic_vector(5 downto 0) 
  ) ;
end entity ; -- ejer_1


architecture rtl of ejer_1 is
    signal acc_r : std_logic_vector(6 downto 0);
begin
    
    p_one_process : process (a_reset_i, clk_i)
        variable v_mux_out : std_logic_vector(3 downto 0);
    begin
      if (a_reset_i = '0') then
        acc_r <= (others => '0');        
      elsif (rising_edge(clk_i)) then
        if (s_reset_i = '1') then
            acc_r <= (others => '0');        
        else            
            --Todo el codigo viene aca.
            case (sel_i) is
                when "00" =>
                    v_mux_out := '0' & in_2_i;
                when "01" =>
                    v_mux_out := std_logic_vector(to_unsigned(to_integer(unsigned(in_1_i)) + to_integer(unsigned(in_2_i)),v_mux_out'LENGTH));
                when "11" =>                    
                    v_mux_out := '0' & in_1_i;
                when others =>
                    v_mux_out := (others => '0');
            end case;
            --Despues hac emos el trabajo con el feedback.
           acc_r <= std_logic_vector(to_unsigned(to_integer(unsigned(v_mux_out)) + to_integer(unsigned(acc_r(5 downto 0))),1 + out_reg_o'LENGTH));
        end if;       
      end if;
    end process p_one_process;
    overflow_o  <= acc_r(6);
    out_reg_o   <= acc_r(5 downto 0);
end architecture rtl;
