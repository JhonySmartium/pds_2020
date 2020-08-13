--------------------------------------------------------------------------------
--
-- Title    : promediador_rtl.vhd
--------------------------------------------------------------------------------
--
-- Description
-- 
--------------------------------------------------------------------------------

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity promediador_rtl is
  port (
    --Los dos señales que atraviesan cualquier sistema digital.
    clk_i           : in std_logic;
    a_reset_ni      : in std_logic;
    --Señales de entrada. En formato Q1.7.
    data_i          : in std_logic_vector(7 downto 0);    
    enable_dsp_t_i  : in std_logic;                     --Cada vez que se active un '1', 
    --Señal de salida. Vamos a tener que hacer un truncamiento, o un redondeo, o saturacion.
    data_o          : out std_logic_vector(7 downto 0)
  );
end entity ; -- promediador_rtl

architecture rtl of promediador_rtl is

 --Constante para el filtro promediador, es que la constante multiplica a todos por igual.
 --Esto es 0.25 en Q1.7
 constant MUL_FACTOR_SIGNED : signed(7 downto 0) := x"20";  

 --Hacemos un array. Aca va a haber un tipo de datos nuevo que es un arreglo de std logic vector 7 downto 0.
 type input_vector_type is array (natural range <>) of std_logic_vector(7 downto 0);
 signal delay_line_reg : input_vector_type(0 to 4); 

 --Multiplica un Q1.7 con otro Q1.7. Es un Q2.14. Lo cual tiene 16 bits.
 type mul_vector_type is array (natural range <>) of std_logic_vector(15 downto 0);
 signal mul_temp_result : mul_vector_type(0 to 3);

 --Señales intermedias: Q2.14 + Q2.14 = Q3.14
 signal temp_stage_1_1_w : std_logic_vector(16 downto 0);
 signal temp_stage_1_2_w : std_logic_vector(16 downto 0);
 --Señales intermedias: Q3.14 + Q3.14 = Q4.14
 signal temp_stage_2_1_w : std_logic_vector(17 downto 0);

begin

    delay_line_reg(0) <= data_i;
    generate_delay_line : for i in 0 to 3 generate
        ffd_vector_inst : entity work.ffd_vector
            generic map (
                N => 8
            )
            port map (
                clk_i      => clk_i,
                a_reset_ni => a_reset_ni,
                data_i     => delay_line_reg(i),
                data_o     => delay_line_reg(i+1),
                enable_t_i => enable_dsp_t_i
            );
    end generate ; -- generate_delay_line

    --Q2.14[4].
    mul_temp_result(0) <= std_logic_vector(to_signed(to_integer(MUL_FACTOR_SIGNED) * to_integer(signed(delay_line_reg(1))),16));
    mul_temp_result(1) <= std_logic_vector(to_signed(to_integer(MUL_FACTOR_SIGNED) * to_integer(signed(delay_line_reg(2))),16));
    mul_temp_result(2) <= std_logic_vector(to_signed(to_integer(MUL_FACTOR_SIGNED) * to_integer(signed(delay_line_reg(3))),16));
    mul_temp_result(3) <= std_logic_vector(to_signed(to_integer(MUL_FACTOR_SIGNED) * to_integer(signed(delay_line_reg(4))),16));

    --Suma 
    -- Q2.14 + Q2.14 = Q3.14 
    temp_stage_1_1_w   <= std_logic_vector(to_signed(to_integer(signed(mul_temp_result(0))) + to_integer(signed(mul_temp_result(1))),17));
    temp_stage_1_2_w   <= std_logic_vector(to_signed(to_integer(signed(mul_temp_result(2))) + to_integer(signed(mul_temp_result(3))),17));

    -- Q3.14 + Q3.14 = Q4.14
    temp_stage_2_1_w   <= std_logic_vector(to_signed(to_integer(signed(temp_stage_1_1_w)) + to_integer(signed(temp_stage_1_2_w)),18));

    -- Nos quedamos con una porcion de Q4.4.
    data_o <= temp_stage_2_1_w(17 downto 10);
end architecture ; -- rtl
