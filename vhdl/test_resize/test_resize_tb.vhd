--------------------------------------------------------------------------------
--
-- Title    : test_resize_tb.vhd
-- Project  : Integrated Radio Design
-- Author   : Gonzalo Lavigna
--------------------------------------------------------------------------------
--
-- Description
-- Testbench para probar el co
--------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

-----------------------------------------------------------

entity test_resize_tb is

end entity test_resize_tb;

-----------------------------------------------------------

architecture testbench of test_resize_tb is
    -- Testbench DUT generics
    constant N_INPUT  : integer := 8;
    constant N_OUTPUT : integer := 16;

    --Definimos el arreglo de entrada
    type input_type is array (integer range <>) of std_logic_vector(N_INPUT-1 downto 0);


    -- Testbench DUT ports
    signal data_w     : std_logic_vector(N_INPUT-1 downto 0);
    signal signed_o   : std_logic_vector(N_OUTPUT-1 downto 0);
    signal unsigned_o : std_logic_vector(N_OUTPUT-1 downto 0);

    --Vector de entrada
    constant INPUT_VECTOR : input_type(0 to 3) := (  std_logic_vector(to_signed(0   ,N_INPUT)),
                                                     std_logic_vector(to_signed(-1  ,N_INPUT)),
                                                     std_logic_vector(to_signed(127 ,N_INPUT)),
                                                     std_logic_vector(to_signed(-127,N_INPUT))
                                                   );

begin

    -----------------------------------------------------------
    -- Testbench Stimulus
    -----------------------------------------------------------

    input_process : process 
    begin
        data_w <= (others => '0');
        wait for 100 ns;
        loop_input_vector : for i in 0 to 3 loop
            data_w <= INPUT_VECTOR(i);
            wait for 100 ns;            
        end loop;
        wait;
    end process ; -- input_process

    -----------------------------------------------------------
    -- Entity Under Test
    -----------------------------------------------------------
    DUT : entity work.test_resize
        generic map (
            N_INPUT  => N_INPUT,
            N_OUTPUT => N_OUTPUT
        )
        port map (
            data_i     => data_w,
            signed_o   => signed_o,
            unsigned_o => unsigned_o
        );

end architecture testbench;