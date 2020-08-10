--------------------------------------------------------------------------------
-- Title       : <Title Block>
-- Project     : Default Project Name
--------------------------------------------------------------------------------
-- File        : test_round_tb.vhd
-- Author      : User Name <user.email@user.company.com>
-- Company     : User Company Name
-- Created     : Sat Aug  8 19:41:30 2020
-- Last update : Sat Aug  8 20:39:53 2020
-- Platform    : Default Part Number
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Copyright (c) 2020 User Company Name
-------------------------------------------------------------------------------
-- Description: 
--------------------------------------------------------------------------------
-- Revisions:  Revisions and documentation are controlled by
-- the revision control system (RCS).  The RCS should be consulted
-- on revision history.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

-----------------------------------------------------------

entity test_round_tb is

end entity test_round_tb;

-----------------------------------------------------------

architecture testbench of test_round_tb is

    -- Testbench DUT generics
    constant N         : integer   := 8;
    constant M         : integer   := 4;

    -- Testbench DUT ports
    signal data_i : std_logic_vector(N-1 downto 0);
    signal data_o : std_logic_vector(M-1 downto 0);
    signal clk_i  : std_logic;

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

    --variable counter : integer range -128 to 127;
    signal counter : integer range 0 to 127;
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

    -----------------------------------------------------------
    -- Testbench Stimulus
    -----------------------------------------------------------
    generate_stimulus : process is
    begin
        data_i <= (others => '0');
        generate_delay(clk_i,20);
        loop_counter : for i in -128 to 127 loop
            data_i <= std_logic_vector(to_Signed(i,data_i'LENGTH));
            generate_delay(clk_i,10);
        end loop;
    wait;
    end process; -- generate_stimulus

    -----------------------------------------------------------
    -- Entity Under Test
    -----------------------------------------------------------
    DUT : entity work.test_round
        generic map (
            N         => N,
            M         => M,
            ENA_ROUND => '1'
        )
        port map (
            data_i => data_i,
            data_o => data_o
        );

    DUT_2 : entity work.test_round
        generic map (
            N         => N,
            M         => M,
            ENA_ROUND => '0'
        )
        port map (
            data_i => data_i,
            data_o => data_o
        );

end architecture testbench;