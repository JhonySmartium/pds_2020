
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

-----------------------------------------------------------

entity test_shift_tb is

end entity test_shift_tb;

-----------------------------------------------------------

architecture testbench of test_shift_tb is

    -- Testbench DUT generics
    constant BIT_WIDTH : integer := 8;
    constant N_SHIFTS  : integer := 1;


    --Definimos el arreglo de entrada
    type input_type is array (integer range <>) of std_logic_vector(BIT_WIDTH-1 downto 0);

    -- Testbench DUT ports
    signal data_w                  : std_logic_vector(BIT_WIDTH-1 downto 0);
    signal signed_shift_left_o     : std_logic_vector(BIT_WIDTH-1 downto 0);
    signal signed_shift_right_o    : std_logic_vector(BIT_WIDTH-1 downto 0);
    signal signed_rotate_left_o    : std_logic_vector(BIT_WIDTH-1 downto 0);
    signal signed_rotate_right_o   : std_logic_vector(BIT_WIDTH-1 downto 0);
    signal unsigned_shift_left_o   : std_logic_vector(BIT_WIDTH-1 downto 0);
    signal unsigned_shift_right_o  : std_logic_vector(BIT_WIDTH-1 downto 0);
    signal unsigned_rotate_left_o  : std_logic_vector(BIT_WIDTH-1 downto 0);
    signal unsigned_rotate_right_o : std_logic_vector(BIT_WIDTH-1 downto 0);

    --Vector de entrada
    constant INPUT_VECTOR : input_type(0 to 3) := (  X"AA",
                                                     X"55",
                                                     X"0F",
                                                     X"F0"
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
    DUT : entity work.test_shift
        generic map (
            BIT_WIDTH => BIT_WIDTH,
            N_SHIFTS  => N_SHIFTS
        )
        port map (
            data_i                  => data_w,
            signed_shift_left_o     => signed_shift_left_o,
            signed_shift_right_o    => signed_shift_right_o,
            signed_rotate_left_o    => signed_rotate_left_o,
            signed_rotate_right_o   => signed_rotate_right_o,
            unsigned_shift_left_o   => unsigned_shift_left_o,
            unsigned_shift_right_o  => unsigned_shift_right_o,
            unsigned_rotate_left_o  => unsigned_rotate_left_o,
            unsigned_rotate_right_o => unsigned_rotate_right_o
        );

end architecture testbench;