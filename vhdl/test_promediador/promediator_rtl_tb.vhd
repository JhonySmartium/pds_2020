library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

-----------------------------------------------------------

entity promediator_rtl_tb is

end entity promediator_rtl_tb;

-----------------------------------------------------------

architecture testbench of promediator_rtl_tb is

    -- Testbench DUT generics
    constant N : integer := 8;
    constant M : integer := 4;

    -- Testbench DUT ports
    signal clk_i           : std_logic;
    signal a_reset_ni      : std_logic;
    signal s_axis_tdata_i  : std_logic_vector(N-1 downto 0);
    signal s_axis_tvalid_i : std_logic;
    signal s_axis_tready_o : std_logic;
    signal m_axis_tdata_o  : std_logic_vector(N-1 downto 0);
    signal m_axis_tvalid_o : std_logic;
    signal m_axis_tready_i : std_logic;

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
        a_reset_ni <= '0',
                 '1' after 20.0*C_CLK_PERIOD * (1 SEC);
        wait;
    end process RESET_GEN;

    -----------------------------------------------------------
    -- Testbench Stimulus
    -----------------------------------------------------------
    generate_stimulus : process is
    begin
        --Vamos a hacer simple el TB y que acepte todos los datos.
        m_axis_tready_i <= '1';
        --Valores de reset del bus de las señales
        s_axis_tdata_i  <= (others => '0');
        s_axis_tvalid_i <= '0';
        wait until a_reset_ni = '1';
        generate_delay(clk_i,10);
        
        --Primer valor de entrda. Respuesta impulsiva x(n) = '1'
        s_axis_tdata_i  <= std_logic_vector(to_unsigned(64,s_axis_tdata_i'LENGTH));
        s_axis_tvalid_i <= '1';
        --Esperemos a que en un cambio de reloj el t_ready este en '1'
        wait until (rising_edge(clk_i) and s_axis_tready_o = '1');
        s_axis_tvalid_i <= '0';
        s_axis_tdata_i  <= x"00";
        generate_delay(clk_i,20);

        --Segundo valor de entrada pra respuesta impulsiva
        s_axis_tdata_i  <= (others => '0');
        s_axis_tvalid_i <= '1';
        --Esperemos a que en un cambio de reloj el t_ready este en '1'
        wait until (rising_edge(clk_i) and s_axis_tready_o = '1');
        s_axis_tvalid_i <= '0';
        s_axis_tdata_i  <= x"00";
        generate_delay(clk_i,20);
        
        --Tercer valor de entrada pra respuesta impulsiva
        s_axis_tdata_i  <= (others => '0');
        s_axis_tvalid_i <= '1';
        --Esperemos a que en un cambio de reloj el t_ready este en '1'
        wait until (rising_edge(clk_i) and s_axis_tready_o = '1');
        s_axis_tvalid_i <= '0';
        s_axis_tdata_i  <= x"00";
        generate_delay(clk_i,20);

        --Tercer valor de entrada pra respuesta impulsiva
        s_axis_tdata_i  <= (others => '0');
        s_axis_tvalid_i <= '1';
        --Esperemos a que en un cambio de reloj el t_ready este en '1'
        wait until (rising_edge(clk_i) and s_axis_tready_o = '1');
        s_axis_tvalid_i <= '0';
        s_axis_tdata_i  <= x"00";
        generate_delay(clk_i,20);
        
        wait;    
    end process; -- generate_stimulus

    -----------------------------------------------------------
    -- Entity Under Test
    -----------------------------------------------------------
    DUT : entity work.promediator_rtl
        generic map (
            N => N,
            M => M
        )
        port map (
            clk_i           => clk_i,
            a_reset_ni      => a_reset_ni,
            s_axis_tdata_i  => s_axis_tdata_i,
            s_axis_tvalid_i => s_axis_tvalid_i,
            s_axis_tready_o => s_axis_tready_o,
            m_axis_tdata_o  => m_axis_tdata_o,
            m_axis_tvalid_o => m_axis_tvalid_o,
            m_axis_tready_i => m_axis_tready_i
        );

end architecture testbench;