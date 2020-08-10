library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

-----------------------------------------------------------

entity sipo_rtl_tb is

end entity sipo_rtl_tb;

-----------------------------------------------------------

architecture testbench of sipo_rtl_tb is

    -- Testbench DUT generics
    constant N_OUTPUT_BIT_WIDTH : integer := 8;

    -- Testbench DUT ports
    signal clk_i          : std_logic;
    signal a_reset_ni     : std_logic;
    signal data_i         : std_logic;
    signal load_t_i       : std_logic;
    signal data_o         : std_logic_vector(N_OUTPUT_BIT_WIDTH-1 downto 0);
    signal data_valid_t_o : std_logic;

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
        variable i,j            : integer;
        variable temp           : std_logic_vector(N_OUTPUT_BIT_WIDTH-1 downto 0);
    begin
        data_i   <= '0';
        load_t_i <= '0';
        wait until a_reset_ni = '1';
        generate_delay(clk_i,10);
        loop_generate_data : for i in 0 to 15 loop            
            loop_input_vector : for j in temp'LENGTH-1 downto 0 loop
                temp  := std_logic_vector(to_unsigned(i,temp'LENGTH));
                data_i  <= temp(j);
                load_t_i <= '1';
                wait until (rising_edge(clk_i));
                load_t_i <= '0';
                generate_delay(clk_i,4);                                        
            end loop;
        end loop;

        generate_delay(clk_i,20);
    end process; -- generate_stimulus
    -----------------------------------------------------------
    -- Entity Under Test
    -----------------------------------------------------------
    DUT : entity work.sipo_rtl
        generic map (
            N_OUTPUT_BIT_WIDTH => N_OUTPUT_BIT_WIDTH
        )
        port map (
            clk_i          => clk_i,
            a_reset_ni     => a_reset_ni,
            data_i         => data_i,
            load_t_i       => load_t_i,
            data_o         => data_o,
            data_valid_t_o => data_valid_t_o
        );

end architecture testbench;