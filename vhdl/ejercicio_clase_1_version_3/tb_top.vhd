-- libraries
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- entity
entity tb_top is
end entity tb_top;

-- architecture
architecture rtl of tb_top is

  -- components
  component top is
    port
    (
      clk_i      : in  std_logic;
      rst_n_i    : in  std_logic;
      in1_i      : in  std_logic_vector(2 downto 0);
      in2_i      : in  std_logic_vector(2 downto 0);
      sel_i      : in  std_logic_vector(1 downto 0);
      overflow_o : out std_logic;
      reg_out_o  : out std_logic_vector(5 downto 0)
    );
  end component top;

  -- signals
  signal tb_clk_i      : std_logic := '0';
  signal tb_rst_n_i    : std_logic;
  signal tb_in1_i      : std_logic_vector(2 downto 0);
  signal tb_in2_i      : std_logic_vector(2 downto 0);
  signal tb_sel_i      : std_logic_vector(1 downto 0);
  signal tb_overflow_o : std_logic;
  signal tb_reg_out_o  : std_logic_vector(5 downto 0);

begin

  dut : top
  port map (
    clk_i      => tb_clk_i,
    rst_n_i    => tb_rst_n_i,
    in1_i      => tb_in1_i,
    in2_i      => tb_in2_i,
    sel_i      => tb_sel_i,
    overflow_o => tb_overflow_o,
    reg_out_o  => tb_reg_out_o
  );

  tb_clk_i <= not tb_clk_i after 5 ns;


  process
  begin
    tb_rst_n_i <= '0';
    tb_in1_i   <= std_logic_vector(to_unsigned(0,3));
    tb_in2_i   <= std_logic_vector(to_unsigned(0,3));
    tb_sel_i   <= "10";
    wait for 7 ns;
    tb_rst_n_i <= '1';
    tb_in1_i   <= std_logic_vector(to_unsigned(2,3));
    tb_in2_i   <= std_logic_vector(to_unsigned(3,3));
    tb_sel_i   <= "10";
    wait until rising_edge(tb_clk_i);
    tb_rst_n_i <= '1';
    tb_in1_i   <= std_logic_vector(to_unsigned(17,3));
    tb_in2_i   <= std_logic_vector(to_unsigned(10,3));
    tb_sel_i   <= "10";
    wait until rising_edge(tb_clk_i);
    tb_rst_n_i <= '1';
    tb_in1_i   <= std_logic_vector(to_unsigned(2,3));
    tb_in2_i   <= std_logic_vector(to_unsigned(1,3));
    tb_sel_i   <= "01";
    wait for 3000 ns;
    wait;
  end process;


end architecture;


