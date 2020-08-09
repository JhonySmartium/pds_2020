--------------------------------------------------------------------------------
--
-- Title    : ejer_1_tb.vhd 
-- Project  : PDS 2020
-- Author   : Gonzalo Lavigna   
-- Date     : 01/JUL/2020
--------------------------------------------------------------------------------
--
-- Description
-- 
--------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

-----------------------------------------------------------

--El tb por definicion nunca tiene puertos.
entity ejer_1_tb is
end entity ejer_1_tb;

-----------------------------------------------------------

architecture testbench of ejer_1_tb is

    -- Testbench DUT generics

    -- Testbench DUT signal
    signal clk,reset : std_logic;


    -- Testbench DUT ports
    signal clk_i      : std_logic;
    signal a_reset_i  : std_logic;
    signal s_reset_i  : std_logic;
    signal in_1_i     : std_logic_vector(2 downto 0);
    signal in_2_i     : std_logic_vector(2 downto 0);
    signal sel_i      : std_logic_vector(1 downto 0);
    signal overflow_o : std_logic;
    signal out_reg_o  : std_logic_vector(5 downto 0);

    -- Other constants
    constant C_CLK_PERIOD : real := 10.0e-9; -- NS

begin
    -----------------------------------------------------------
    -- Clocks and Reset
    -----------------------------------------------------------
    CLK_GEN : process
    begin
        clk <= '1';
        wait for C_CLK_PERIOD / 2.0 * (1 SEC);
        clk <= '0';
        wait for C_CLK_PERIOD / 2.0 * (1 SEC);
    end process CLK_GEN;

    RESET_GEN : process
    begin
        reset <= '1',
                 '0' after 20.0*C_CLK_PERIOD * (1 SEC);
        wait;
    end process RESET_GEN;

    -----------------------------------------------------------
    -- Testbench Stimulus
    -----------------------------------------------------------
    --El reset asincronico le hacemos un assert con un '0'. Tener cuidado siempre con este tipo de asignaciones.
    s_reset_i   <= reset;
    a_reset_i   <= not reset;
    clk_i       <= clk;


    --Asignamos las entradas para ver como se comporta el sistema.
    in_1_i      <= std_logic_vector(to_unsigned(1, in_1_i'LENGTH));
    in_2_i      <= std_logic_vector(to_unsigned(1, in_2_i'LENGTH));


    p_sel_process : process is
    begin
        sel_i       <= "01";
        wait until reset = '0';
        wait for   400 ns;
        sel_i       <= "00"; 
        wait;
    end process; -- p_sel_process

    -----------------------------------------------------------
    -- Entity Under Test
    -----------------------------------------------------------
    DUT : entity work.ejer_1
        port map (
            clk_i      => clk_i,
            a_reset_i  => a_reset_i,
            s_reset_i  => s_reset_i,
            in_1_i     => in_1_i,
            in_2_i     => in_2_i,
            sel_i      => sel_i,
            overflow_o => overflow_o,
            out_reg_o  => out_reg_o
        );

end architecture testbench;