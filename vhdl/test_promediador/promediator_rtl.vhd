--------------------------------------------------------------------------------
--
-- Title    : promediator_rtl.vhd
-- Project  : PDS 2020
-- Author   : Gonzalo Lavigna
--------------------------------------------------------------------------------
--
-- Description
--  Siemple promediador de N estapas AXIS a la entrada y AXIS a la salida.
--------------------------------------------------------------------------------
library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;


entity promediator_rtl is
  
  --Vamos a trabajar con numeros Q1.(N-1)
  generic (
          --Bits palabra de entrada
          N : integer := 8;
          --Cantidad de Etapas del promediador
          M : integer := 4
      );
  port (
    clk_i               : in std_logic;
    a_reset_ni          : in std_logic;
    --Interfaz SLAVE AXIS para recepcion de datos.
    s_axis_tdata_i      : in  std_logic_vector(N-1 downto 0);
    s_axis_tvalid_i     : in  std_logic;
    s_axis_tready_o     : out std_logic;
    --Interfaz MASTER AXIS para transmisión de datos.
    m_axis_tdata_o      : out std_logic_vector(N-1 downto 0);
    m_axis_tvalid_o     : out std_logic;
    m_axis_tready_i     : in  std_logic
  );
end entity ; -- promediator_rtl

architecture rtl of promediator_rtl is
    --Vector con los datos que se van a ir almacenando
    type input_vector_type is array (integer range <>) of std_logic_vector(N-1 downto 0);
    signal input_vector_reg : input_vector_type(0 to M);
    -- Esto va a guarda a x(n),x(n-1),x(n-2)............x(n-(M-1))

    --Estado para maneja este bloque.
    type state_type is (
            ST_WAIT_DATA,
            ST_PROCESS_DATA,
            ST_TRANSMIT_DATA
    );

    --Generamos el arreglo de registro
    type reg_type is record 
        state               : state_type;
        enable_dsp          : std_logic;
        --Señales manejo AXIS
        s_axis_tready       : std_logic;
        m_axis_tdata        : std_logic_vector(m_axis_tdata_o'RANGE); --Este tecnica esta buenap ara mantener siempre los anchos bien.
        m_axis_tvalid       : std_logic;
    end record;

    --Valor por defecto de los registros.
    constant regs_default : reg_type := (
        state           => ST_WAIT_DATA,
        enable_dsp      => '0',
        s_axis_tready   => '1',                 --Por defecto siempre aceptamos un dato a la entrada.
        m_axis_tdata    => (others => '0'),
        m_axis_tvalid   => '0'
    ); 

    --Constante del multiplicador.
    --Esto estaria escrito coan un factor Q1.(N-1)
    --Por ejemplo 1/4 o 0.25 en Q1.8 seria el integer 32.
    constant MUL_FACTOR_REAL : real := (1.0/real(M))*real((2**(N-1)));
    constant MUL_FACTOR      : signed(N-1 downto 0) := to_signed(integer(MUL_FACTOR_REAL),N); 

    --La suma va a tener un facctor de crecimiento  log2()
    signal result_w     : signed(31 downto 0);
    signal enable_dsp   : std_logic;

    --Registros de entrada y de salida
    signal regs,regs_in : reg_type;

begin

    --Generamos el vector con las señales intermedias para hacer el guardado de las muestras de entrada.
    input_vector_reg(0) <= s_axis_tdata_i;
    generate_array : for i in 0 to M-1 generate
        reg_inst : entity work.ffd_vector
            generic map (
                N => N
            )
            port map (
                clk_i      => clk_i,
                a_reset_ni => a_reset_ni,
                data_i     => input_vector_reg(i),
                data_o     => input_vector_reg(i+1),
                enable_t_i => enable_dsp
            );              
    end generate ; -- generate_array


    --Hacemos una suma
    sum_process : process(all) is
        --Esto hay que calcularlo bien de vuelta.
        variable temp : signed(31 downto 0);
    begin
        temp := (others => '0');
        loop_vector : for i in 0 to M-1 loop
            temp := temp + MUL_FACTOR*signed(input_vector_reg(i+1));
        end loop;
        result_w <= temp;
    end process; -- sum_process
    

    --------------------------------------------------------------------------------
    -- Manejo del DSP del sistema
    --------------------------------------------------------------------------------

    comb_process : process (all)
        variable v : reg_type;  
    begin
        v := regs;
        --Por defecto el tvalid hacia adelante lo asignamos siempre a cero.
        --Siempore queremos mantener un control fino para no tener una propagacion de errores hacia adelantes.
        v.m_axis_tvalid := '0';

        --Manejo de los estados
        case(regs.state) is
            when ST_WAIT_DATA =>
                if (s_axis_tvalid_i = '1' and s_axis_tready_o = '1') then
                    v.state := ST_PROCESS_DATA;
                end if;
            when ST_PROCESS_DATA =>
                    --Los datos se procesan en un ciclo de reloj asi que no hay incoveniente.
                    --Aca por ejemplo hay que esperar cierta cantidad de ciclos si queremos esperar.
                    v.state := ST_TRANSMIT_DATA;
            when ST_TRANSMIT_DATA =>
                --Por defecto siempre me quedo en este estado.
                v.state := ST_TRANSMIT_DATA;
                if (m_axis_tready_i = '1' and m_axis_tvalid_o = '1') then
                    v.state := ST_WAIT_DATA;
                end if;
            when others =>
                v.state := ST_WAIT_DATA;
        end case;

        --Manejo de señales de salida y de los elementos de memoria internos.
        case(regs.state) is
            --Esperamos un dato valido.
            when ST_WAIT_DATA =>
                --Mantenemos la parte de DSP en '0'
                v.enable_dsp := '0';
                --Indicamos que podemos guardar datos.
                v.s_axis_tready := '1';
                if (s_axis_tvalid_i = '1' and s_axis_tready_o = '1') then
                    --Como en el proximo ciclo vamos a estar procesando bajamos el tready
                    v.s_axis_tready := '0';
                    v.enable_dsp := '1';
                end if;
            --Procesamos el dato de entrado.
            when ST_PROCESS_DATA =>
                --Siempre mantenemos cancelado el tready desde el otro lado.
                v.s_axis_tready := '0';
                --Este estado es solo de transicion.
                v.enable_dsp := '0';
                --Guardamos los datos de salida en un registro. Y ya activamos el tvalid para el proximo ciclo.
                --Esto surge despues de hacer la saturacion y el truncado.
                v.m_axis_tdata  := std_logic_vector(result_w( 14 downto 7));
                v.m_axis_tvalid := '1';
            when ST_TRANSMIT_DATA =>
                --Mantemos el DSP en '0'
                v.enable_dsp := '0';
                --Holdeamos al master que nos esta excitando.
                v.s_axis_tready := '0';
                --Activamos el tvalid indicando que el dato ya esta valido a la salida
                v.m_axis_tvalid := '1';
                if (m_axis_tready_i = '1' and m_axis_tvalid_o = '1') then
                    --Si tenemos tready ya hay una transferencia y hay que cancelar el tvalid hacia el slave.
                    v.m_axis_tvalid := '0';
                    --Ya en el proximo ciclo vamos a poder generar valores asi que ya lo ponemos en '1'
                    v.s_axis_tready := '1';
                end if;
            --Este es el estado por defecto si por una de esas casualidades caemos en un estado invalido.
            when others =>
                v.state           := ST_WAIT_DATA;
                v.enable_dsp      := '0';
                v.s_axis_tready   := '1';                
                v.m_axis_tdata    := (others => '0');
                v.m_axis_tvalid   := '0';
        end case;

        --Asignaciuon de los modulos de entrada.
        regs_in <= v;
        --Asignacion de la salidas del modulo.
        s_axis_tready_o     <= regs.s_axis_tready;
        m_axis_tdata_o      <= regs.m_axis_tdata;
        m_axis_tvalid_o     <= regs.m_axis_tvalid;
        --Señal para habilitar el DSP
        enable_dsp          <= v.enable_dsp;

    end process comb_process;




    reg_process : process (clk_i,a_reset_ni)
    begin
        if (a_reset_ni = '0' ) then
            regs <= regs_default;
        elsif (rising_edge(clk_i)) then
            regs <= regs_in;
        end if;
    end process reg_process;


end architecture ; -- rtl
