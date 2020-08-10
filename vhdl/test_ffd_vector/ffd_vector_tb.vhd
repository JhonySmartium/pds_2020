
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

-----------------------------------------------------------

entity ffd_vector_tb is

end entity ffd_vector_tb;

-----------------------------------------------------------

architecture testbench of ffd_vector_tb is

    -- Testbench DUT generics
    constant N : integer := 16;

    -- Testbench DUT ports
    signal clk_i          : std_logic;
    signal a_reset_ni     : std_logic;
    signal data_o,data_i  : std_logic_vector(N-1 downto 0);
    signal enable_t_i     : std_logic;

    -- Other constants
    constant C_CLK_PERIOD : real := 10.0e-9; -- NS

begin
    -----------------------------------------------------------
    -- Clocks and Reset
    -----------------------------------------------------------
    CLK_GEN : process
    begin
        clk_i <= '1';
        wait for C_CLK_PERIOD / 2.0 * (1 SEC);
        clk_i <= '0';
        wait for C_CLK_PERIOD / 2.0 * (1 SEC);
    end process CLK_GEN;

    RESET_GEN : process
    begin
        a_reset_ni <= '0',
                 '1' after 20.0*C_CLK_PERIOD * (1 SEC);
        wait;
    end process RESET_GEN;

    -----------------------------------------------------------
    -- Testbench Stimulus
    -----------------------------------------------------------
    gen_process : process is
    begin
    enable_t_i <= '0';
    data_i <= (others => '0');
    wait until (a_reset_ni = '1');
    --Haemos un espera en ciclos de reloj
    delay_1 : for i in 0 to 10 loop
        wait until (clk_i'event and clk_i = '1');           
    end loop;
    
    --Vamos a generar una secuencia de 100 numeros y vamos a agarrar 1 de cada 10.
    loop_gen : for i in 0 to 99 loop
        data_i <= std_logic_vector(to_unsigned(i,data_i'LENGTH));
        --Lo asignamos siempre por defecto a '1'
        enable_t_i <= '0';
        if (i mod 10 = 0) then
            enable_t_i <= '1';
        end if;
        
        wait until (clk_i'event and clk_i = '1');
    end loop;

    --Haemos un espera en ciclos de reloj
    delay_2 : for i in 0 to 10 loop
        wait until (clk_i'event and clk_i = '1');           
    end loop;

    wait;
    end process; -- gen_process
    -----------------------------------------------------------
    -- Entity Under Test
    -----------------------------------------------------------
    DUT : entity work.ffd_vector
        generic map (
            N => N
        )
        port map (
            clk_i      => clk_i,
            a_reset_ni => a_reset_ni,
            data_o     => data_o,
            data_i     => data_i,
            enable_t_i => enable_t_i
        );

end architecture testbench;