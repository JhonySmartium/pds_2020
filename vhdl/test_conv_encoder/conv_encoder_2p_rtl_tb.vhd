library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

-----------------------------------------------------------

entity conv_encoder_2p_rtl_tb is

end entity conv_encoder_2p_rtl_tb;

-----------------------------------------------------------

architecture testbench of conv_encoder_2p_rtl_tb is

    -- Testbench DUT generics
    constant POL_1 : integer := 8#171#;
    constant POL_2 : integer := 8#133#;

    -- Testbench DUT ports
    signal clk_i           : std_logic;
    signal a_reset_ni      : std_logic;
    signal s_axis_tdata_w  : std_logic;
    signal s_axis_tvalid_w : std_logic;
    signal s_axis_tready_w : std_logic;
    signal m_axis_tdata_w  : std_logic_vector(3 downto 0);
    signal m_axis_tvalid_w : std_logic;
    signal m_axis_tready_w : std_logic;

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
        variable temp           : std_logic_vector(3 downto 0);
    begin
        --Valores de reset del bus de las señales

        s_axis_tdata_w  <= '0';
        s_axis_tvalid_w <= '0';
        wait until a_reset_ni = '1';
        generate_delay(clk_i,10);
        loop_generate_data : for i in 0 to 15 loop            
            loop_input_vector : for j in temp'LENGTH-1 downto 0 loop
                temp  := std_logic_vector(to_unsigned(i,temp'LENGTH));
                s_axis_tdata_w  <= temp(j);
                s_axis_tvalid_w <= '1';
                --Esperemos a que en un cambio de reloj el t_ready este en '1'
                wait until (rising_edge(clk_i) and s_axis_tready_w = '1');
                s_axis_tvalid_w <= '0' ;
                generate_delay(clk_i,9);                                        
            end loop;
        end loop;
        generate_delay(clk_i,20);
    wait;
    end process; -- generate_stimulus


    print_data : process is
        variable my_line : line;
    begin
    --En una verificacion formal el tready del master tambien hay que moverlo. Con un comportamiento random.        
    m_axis_tready_w <= '1';
    process_data_valid : while true loop
        wait until m_axis_tvalid_w = '1';
        report "Valor recibido:0x" & to_hstring(m_axis_tdata_w);
    end loop ; -- process_data_valid
    wait;
    end process; -- print_data

    -----------------------------------------------------------
    -- Entity Under Test
    -----------------------------------------------------------
    DUT : entity work.conv_encoder_2p_rtl
        generic map (
            POL_1 => POL_1,
            POL_2 => POL_2
        )
        port map (
            clk_i           => clk_i,
            a_reset_ni      => a_reset_ni,
            s_axis_tdata_i  => s_axis_tdata_w,
            s_axis_tvalid_i => s_axis_tvalid_w,
            s_axis_tready_o => s_axis_tready_w,
            m_axis_tdata_o  => m_axis_tdata_w,
            m_axis_tvalid_o => m_axis_tvalid_w,
            m_axis_tready_i => m_axis_tready_w
        );

end architecture testbench;