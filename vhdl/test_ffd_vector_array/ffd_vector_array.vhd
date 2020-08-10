--------------------------------------------------------------------------------
--
-- Title    : ffd_vector_array.vhd
-- Project  : PDS 2020
-- Author   : Gonzalo Lavigna
--------------------------------------------------------------------------------
--
-- Description
-- Probar la concatenacion de FFD para poder tener un banco de registro para hacer 
-- en un futuro filtros.
-- En esta aplicacion sirve para hacer un retardo entero.
-- Si quieren usarlo para un filtro tiene que agarrar las señakes intermedias.
--------------------------------------------------------------------------------


library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all ;

--Libreria donde esta el FF individual con el enable.
library ffd_lib;


entity ffd_vector_array is
    generic (
        N : integer := 8;
        M : integer := 4
    );

    port (
        clk_i       : in std_logic;
        a_reset_ni  : in std_logic;
        data_i      : in std_logic_vector(N-1 downto 0);
        enable_t_i  : in std_logic;
        data_o      : out std_logic_vector(N-1 downto 0)
    ) ;
end entity ; -- ffd_vector_array

architecture struct of ffd_vector_array is
--Vamos a tener que usar un arreglo de señales intermedias para comunicar los distintos bloques
type reg_connection_type is array (integer range <>) of std_logic_vector(N-1 downto 0);
signal reg_connection_w : reg_connection_type(0 to M);

begin


    -- Asignamos la señal de entrada
     reg_connection_w(0) <= data_i;

    reg_0 : entity ffd_lib.ffd_vector
        generic map (
            N => N
        )
        port map (
            clk_i      => clk_i,
            a_reset_ni => a_reset_ni,
            data_i     => reg_connection_w(0),
            data_o     => reg_connection_w(1),
            enable_t_i => enable_t_i
        );    
    
    --For generate para generar M instancia del retrado que queremos generar.
    generate_array : for i in 1 to M-1 generate
        reg_inst : entity ffd_lib.ffd_vector
            generic map (
                N => N
            )
            port map (
                clk_i      => clk_i,
                a_reset_ni => a_reset_ni,
                data_i     => reg_connection_w(i),
                data_o     => reg_connection_w(i+1),
                enable_t_i => enable_t_i
            );              
    end generate ; -- generate_array

    --La ultima salida del arreglo la terminamos asginando.
    data_o <= reg_connection_w(M);

end architecture ; -- struct

library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all ;

--Libreria donde esta el FF individual con el enable.
library ffd_lib;


--------------------------------------------------------------------------------
--  En este caso desplegamos el for y lo hacemos una instancia por una.
--------------------------------------------------------------------------------

--Definamos otra arquitectura del mismo bloque
architecture verbose_struc of ffd_vector_array is
--Vamos a tener que usar un arreglo de señales intermedias para comunicar los distintos bloques
type reg_connection_type is array (integer range <>) of std_logic_vector(N-1 downto 0);
signal reg_connection_w : reg_connection_type(0 to 4);

--Al tener el M fijo no podemos hacer una propagacion.

begin

    reg_connection_w(0) <= data_i;

    u_reg_0 : entity ffd_lib.ffd_vector
        generic map (
            N => N
        )
        port map (
            clk_i      => clk_i,
            a_reset_ni => a_reset_ni,
            data_i     => reg_connection_w(0),
            data_o     => reg_connection_w(1),
            enable_t_i => enable_t_i
        );    

    u_reg_1 : entity ffd_lib.ffd_vector
        generic map (
            N => N
        )
        port map (
            clk_i      => clk_i,
            a_reset_ni => a_reset_ni,
            data_i     => reg_connection_w(1),
            data_o     => reg_connection_w(2),
            enable_t_i => enable_t_i
        );    

    u_reg_2 : entity ffd_lib.ffd_vector
        generic map (
            N => N
        )
        port map (
            clk_i      => clk_i,
            a_reset_ni => a_reset_ni,
            data_i     => reg_connection_w(2),
            data_o     => reg_connection_w(3),
            enable_t_i => enable_t_i
        );    

    u_reg_3 : entity ffd_lib.ffd_vector
        generic map (
            N => N
        )
        port map (
            clk_i      => clk_i,
            a_reset_ni => a_reset_ni,
            data_i     => reg_connection_w(3),
            data_o     => reg_connection_w(4),
            enable_t_i => enable_t_i
        );    

    data_o <= reg_connection_w(4);

end architecture ; -- verbose_struc

--------------------------------------------------------------------------------
--  Lo podemos hacer todo en un solo process sin necesidad de usar instancia
--  Tambiewn vemos un poco de los atributos de las señales.
--------------------------------------------------------------------------------

library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all ;


architecture one_process_rtl of ffd_vector_array is

    type reg_connection_type is array (integer range <>) of std_logic_vector(N-1 downto 0);
    --En este caso la conexion se mapea a registros
    signal reg_bank_r : reg_connection_type(0 to M-1);

begin

    reg_process : process (a_reset_ni, clk_i)
    begin
      if (a_reset_ni = '0') then
        loop_reg_bank_reset : for i in 0 to reg_bank_r'LENGTH-1 loop
            reg_bank_r(i) <= (others => '0');
        end loop; --loop_reg_bank_reset
      elsif (rising_edge(clk_i)) then
        if (enable_t_i = '1') then
            --Absorvemos el primer valor.      
            reg_bank_r(0) <= data_i;
            loop_reg_bank : for i in 0 to reg_bank_r'RIGHT-1 loop
                reg_bank_r(i+1) <= reg_bank_r(i);
            end loop; --loop_reg_bank_assigment
        end if;
      end if;
    end process reg_process;
    
    --Siempre es el ultimo no importa cuantos M tenga.
    --Lo asignamos afuera.
    data_o <= reg_bank_r(reg_bank_r'RIGHT);
end architecture ; -- one_process


--------------------------------------------------------------------------------
--  Tambien lo podemos hacer teniendo en cuenta la metoddologia two process.
--------------------------------------------------------------------------------

library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all ;

architecture two_process_rtl of ffd_vector_array is

    type reg_connection_type is array (integer range <>) of std_logic_vector(N-1 downto 0);

    --  Esta funcion nos permite tener el valor de reset para todos los registros.
    function generate_array_reset_value (M : integer) return reg_connection_type is
        variable rv : reg_connection_type(0 to M-1);
    begin
        loop_reg_array : for i in 0 to rv'RIGHT loop
            rv(i) := (others => '0');
        end loop; --loop_reg_array
        return rv;
    end generate_array_reset_value;


    constant RESET_REG_BANK : reg_connection_type(0 to M-1) := generate_array_reset_value(M); 

    --  reg_type para usar durante el sistema de los dos processos.    
    type reg_type is record 
        reg_bank : reg_connection_type(0 to M-1);
    end record;
    
    constant regs_default : reg_type := (
        reg_bank => RESET_REG_BANK
    );

    signal regs,regs_in : reg_type;

begin

    comb_process : process( all )
        variable v : reg_type;
    begin
        v := regs;
        --La entrada del primer registro siempre es la entrada
        if (enable_t_i = '1') then
            v.reg_bank(0)  := data_i;
            loop_reg_array : for i in 0 to regs.reg_bank'RIGHT-1 loop
                --Observar que esta asignacion conecta la entrada de reg_1 con la salida de reg_0 (o su valoralmacenado)
                v.reg_bank(i+1) := regs.reg_bank(i);
            end loop;            
        end if;

        regs_in <= v;
        --Siempre es el mas alto.
        data_o <= regs.reg_bank(M-1);
    end process ; -- comb_process

    reg_process : process (a_reset_ni, clk_i)
    begin
      if (a_reset_ni = '0') then
        regs <= regs_default;
      elsif (rising_edge(clk_i)) then
        regs <= regs_in;
      end if;
    end process reg_process;

end architecture ; -- two_process_rtl