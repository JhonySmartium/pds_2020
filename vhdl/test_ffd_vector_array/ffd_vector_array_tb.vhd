library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

-----------------------------------------------------------

entity ffd_vector_array_tb is

end entity ffd_vector_array_tb;

-----------------------------------------------------------

architecture testbench of ffd_vector_array_tb is

    -- Testbench DUT generics
    constant N : integer := 8;
    constant M : integer := 4;

    -- Testbench DUT ports
    signal clk_i      : std_logic;
    signal a_reset_ni : std_logic;
    signal data_i     : std_logic_vector(N-1 downto 0);
    signal enable_t_i : std_logic;
    --Data O
    signal data_struct_o           : std_logic_vector(N-1 downto 0);
    signal data_verbose_struc_o    : std_logic_vector(N-1 downto 0);
    signal data_one_process_rtl_o  : std_logic_vector(N-1 downto 0);
    signal data_two_process_rtl_o  : std_logic_vector(N-1 downto 0);

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
        --Lo asignamos siempre por defecto a '1'
        enable_t_i <= '0';
        if (i mod 10 = 0) then
            data_i     <= std_logic_vector(to_unsigned(i,data_i'LENGTH));
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
    DUT_STRUC : entity work.ffd_vector_array(struct)
        generic map (
            N => N,
            M => M
        )
        port map (
            clk_i      => clk_i,
            a_reset_ni => a_reset_ni,
            data_i     => data_i,
            enable_t_i => enable_t_i,
            data_o     => data_struct_o
        );


    DUT_VERBOSE_STRUC : entity work.ffd_vector_array(verbose_struc)
        generic map (
            N => N,
            M => M
        )
        port map (
            clk_i      => clk_i,
            a_reset_ni => a_reset_ni,
            data_i     => data_i,
            enable_t_i => enable_t_i,
            data_o     => data_verbose_struc_o
        );

    DUT_1_P : entity work.ffd_vector_array(one_process_rtl)
        generic map (
            N => N,
            M => M
        )
        port map (
            clk_i      => clk_i,
            a_reset_ni => a_reset_ni,
            data_i     => data_i,
            enable_t_i => enable_t_i,
            data_o     => data_one_process_rtl_o
        );

    DUT_2_P : entity work.ffd_vector_array(two_process_rtl)
        generic map (
            N => N,
            M => M
        )
        port map (
            clk_i      => clk_i,
            a_reset_ni => a_reset_ni,
            data_i     => data_i,
            enable_t_i => enable_t_i,
            data_o     => data_two_process_rtl_o
        );

end architecture testbench;