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
-- Two process methodology
--------------------------------------------------------------------------------


-- Librerias IEEE
library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all ;

--Esto puede servir para unificar criterios de niveles de reset y tambien de por frecuencia
--de reloj.
--library commons;
--use commons.commons_pkg.all;

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

type reg_type is record 
    acc : std_logic_vector(6 downto 0);
end record;

constant regs_default : reg_type := (
        acc => (others => '0')
    ); 

signal regs,regs_in : reg_type;

begin

    comb_process : process (all)
        variable v          : reg_type;
        variable mux_out    : std_logic_vector(3 downto 0);
    begin
        -- Assign reg out to the variable.
        v := regs;
        --Primer mux de entrada combinacion
        case (sel_i) is
            when "00" =>
                mux_out := '0' & in_2_i;
            when "01" => 
                mux_out := std_logic_vector(to_unsigned(to_integer(unsigned(in_1_i)) + to_integer(unsigned(in_2_i)),mux_out'LENGTH));
            when "10" =>
                mux_out := '0' & in_1_i;
            when others =>
                mux_out := '0' & in_1_i;
        end case;

        --Aca hacemos la suma entre las señales de salida 
        v.acc := std_logic_vector(to_unsigned(to_integer(unsigned(mux_out)) + to_integer(unsigned(regs.acc(5 downto 0))),1 + out_reg_o'LENGTH));

        --Drive Register input
        regs_in <= v;
        --Drive entity outputs
        out_reg_o   <= regs.acc(5 downto 0);
        overflow_o  <= regs.acc(6);
        --Por ejemplo si queremos que sea la señal combinacional alcanza con:
        --overflow_o  <= v.acc(6);
    end process comb_process;


    --Assign and reset registers.
    reg_proces : process (a_reset_i, clk_i)
    begin
      if (a_reset_i = '0') then
        regs <= regs_default;
      elsif (rising_edge(clk_i)) then
        if (s_reset_i = '1') then
            regs <= regs_default;
        else 
            regs <= regs_in;
        end if;
      end if;
    end process reg_proces;

end architecture ; -- rtl
