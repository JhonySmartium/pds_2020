
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

-----------------------------------------------------------

entity test_saturation_tb is

end entity test_saturation_tb;

-----------------------------------------------------------

architecture testbench of test_saturation_tb is

    -- Testbench DUT generics
    constant N : integer := 8;
    constant M : integer := 4;

    -- Testbench DUT ports
    signal data_i : std_logic_vector(N-1 downto 0);
    signal data_o_sat,data_o_ov : std_logic_vector(M-1 downto 0);

begin

    -----------------------------------------------------------
    -- Testbench Stimulus
    -----------------------------------------------------------
    comb_process : process is
    begin
        data_i <= (others => '0');
        wait for 100 ns;
        iterate_number : for i in -2**(N-1) to 2**(N-1)-1 loop
            data_i <= std_logic_vector(to_signed(i,data_i'LENGTH));
            wait for 100 ns;
        end loop ; -- iterate_number
        wait;
    end process; -- comb_process

    -----------------------------------------------------------
    -- Entity Under Test
    -----------------------------------------------------------
    DUT_SAT : entity work.test_saturation
        generic map (
            N   => N,
            M   => M,
            SAT => '1'
        )
        port map (
            data_i => data_i,
            data_o => data_o_sat
        );

    DUT_OV : entity work.test_saturation
        generic map (
            N   => N,
            M   => M,
            SAT => '0'
        )
        port map (
            data_i => data_i,
            data_o => data_o_ov
        );

end architecture testbench;