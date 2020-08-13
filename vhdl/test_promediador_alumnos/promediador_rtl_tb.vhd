library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

-----------------------------------------------------------

entity promediador_rtl_tb is

end entity promediador_rtl_tb;

-----------------------------------------------------------

architecture testbench of promediador_rtl_tb is

    -- Testbench DUT generics


    -- Testbench DUT ports
    signal clk_i          : std_logic;
    signal a_reset_ni     : std_logic;
    signal data_i         : std_logic_vector(7 downto 0);
    signal enable_dsp_t_i : std_logic;
    signal data_o         : std_logic_vector(7 downto 0);

    -- Other constants
    constant C_CLK_PERIOD : real := 10.0e-9; -- NS

    --Procedimiento para generar retardos de M ciclos de reloj.
    procedure generate_delay (
        signal      clk_i   : in std_logic;
        constant    M_CYCLE : in integer 
    ) is    
    begin
        wait_ncycle : for i in 0 to M_CYCLE-1 loop
            wait until rising_edge(clk_i);                                    
        end loop;
    end procedure generate_delay;

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
        a_reset_ni <=   '0',
                        '1' after 20.0*C_CLK_PERIOD * (1 SEC);
        wait;
    end process RESET_GEN;

    -----------------------------------------------------------
    -- Testbench Stimulus
    -----------------------------------------------------------
    generate_stimulus : process is
    begin
        data_i          <= (others => '0');        
        enable_dsp_t_i  <= '0';
        wait until a_reset_ni = '1';
        -- Esto espera 20 ciclos de reloj.
        generate_delay(clk_i,20);
        
        -- '0.5' '0' '0' '0' '0' '0'.

        -- x"40", esto es 64 en hexadecimal. 0.5 en Q1.7
        data_i          <= std_logic_vector(to_signed(64,data_i'LENGTH));
        enable_dsp_t_i  <= '1';
        wait until (rising_edge(clk_i));
        data_i          <= (others => '0');
        enable_dsp_t_i  <= '0';
        generate_delay(clk_i,20);

        --Les decimos que procese un 0
        data_i          <= (others => '0');
        enable_dsp_t_i  <= '1';
        wait until (rising_edge(clk_i));
        data_i          <= (others => '0');
        enable_dsp_t_i  <= '0';
        generate_delay(clk_i,20);

        --Les decimos que procese un 0
        data_i          <= (others => '0');
        enable_dsp_t_i  <= '1';
        wait until (rising_edge(clk_i));
        data_i          <= (others => '0');
        enable_dsp_t_i  <= '0';
        generate_delay(clk_i,20);

        --Les decimos que procese un 0
        data_i          <= (others => '0');
        enable_dsp_t_i  <= '1';
        wait until (rising_edge(clk_i));
        data_i          <= (others => '0');
        enable_dsp_t_i  <= '0';
        generate_delay(clk_i,20);

        --Les decimos que procese un 0
        data_i          <= (others => '0');
        enable_dsp_t_i  <= '1';
        wait until (rising_edge(clk_i));
        data_i          <= (others => '0');
        enable_dsp_t_i  <= '0';
        generate_delay(clk_i,20);

        --Les decimos que procese un 0
        data_i          <= (others => '0');
        enable_dsp_t_i  <= '1';
        wait until (rising_edge(clk_i));
        data_i          <= (others => '0');
        enable_dsp_t_i  <= '0';
        generate_delay(clk_i,20);
        
        wait;
    end process; -- generate_stimulus

    -----------------------------------------------------------
    -- Entity Under Test
    -----------------------------------------------------------
    DUT : entity work.promediador_rtl
        port map (
            clk_i          => clk_i,
            a_reset_ni     => a_reset_ni,
            data_i         => data_i,
            enable_dsp_t_i => enable_dsp_t_i,
            data_o         => data_o
        );

end architecture testbench;