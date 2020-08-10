--------------------------------------------------------------------------------
--
-- Title    : conv_encoder_2p_rtl.vhd
-- Project  : PDS 2020
-- Author   : Gonzalo Lavigna
--------------------------------------------------------------------------------
--
-- Description
-- Probar un encoder convolucional con una entrada 1bits y despues salimos con 4 bits.
--------------------------------------------------------------------------------
library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity conv_encoder_2p_rtl is
  generic (
    POL_1             : integer := 8#171#;
    POL_2             : integer := 8#133#
  );
  port (
    clk_i             : in std_logic;
    a_reset_ni        : in std_logic;
    --SLAVE AXIS. Vamos a hacerlo solo de 1 bit de entrado.
    s_axis_tdata_i    : in  std_logic;
    s_axis_tvalid_i   : in  std_logic;
    s_axis_tready_o   : out std_logic;
    --MASTER AXIS. Salimos con 4 bits de salida
    m_axis_tdata_o    : out std_logic_vector(3 downto 0);
    m_axis_tvalid_o   : out std_logic;
    m_axis_tready_i   : in  std_logic
  ) ;
end entity ; -- conv_encoder_2p_rtl

architecture rtl_2p of conv_encoder_2p_rtl is
    --Tamaño del shift register.
    constant  K : integer := 7; 
    --Cantidad de ciclo de procesamiento para llenar la salida
    --Como en cada bit de entrada el encoder genera 2 bits.
    --Para generar 4 bits a la salida necesito 2 ciclos.
    constant CYCLES_TO_FILL_OUTPUT  : integer := 2; 
    --Polinomios Generadores.
    constant POL1_SLV : std_logic_vector(K-1 downto 0) := std_logic_vector(to_unsigned(POL_1,K));
    constant POL2_SLV : std_logic_vector(K-1 downto 0) := std_logic_vector(to_unsigned(POL_2,K));

    --Estado para maneja este bloque.
    type state_type is (
            ST_WAIT_DATA,
            ST_PROCESS_DATA,
            ST_TRANSMIT_DATA
        );
    --Generamos el arreglo de registro
    type reg_type is record 
        state               : state_type;
        --Shift register bloque fundamental de este modulo.
        shift_reg           : std_logic_vector(K-1 downto 0);
        --Contador para la salida. Cuando generen RTL con integer con el range ayudan a que el sintetizador
        --no ponga valores de 32 bits. Capaz los mas nuevos ya se dan cuenta.
        count               : integer range 0 to CYCLES_TO_FILL_OUTPUT;
        --Señales manejo AXIS
        s_axis_tready       : std_logic;
        m_axis_tdata        : std_logic_vector(m_axis_tdata_o'RANGE); --Este tecnica esta buenap ara mantener siempre los anchos bien.
        m_axis_tvalid       : std_logic;
    end record;

    --Valor por defecto de los registros.
    constant regs_default : reg_type := (
        state           => ST_WAIT_DATA,
        shift_reg       => (others => '0'),
        count           => 0,
        s_axis_tready   => '0',
        m_axis_tdata    => (others => '0'),
        m_axis_tvalid   => '0'
    ); 

    --Registros internos del modulo y sus respectivas entradas
    signal regs,regs_in : reg_type;

begin
    comb_process : process (all)
        variable v : reg_type;  
        --Cada vez que procesamos guardamos esto en esta variable temporal
        variable temp_result : std_logic_vector(1 downto 0);
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
                if (regs.count >= CYCLES_TO_FILL_OUTPUT-1) then
                    v.state := ST_TRANSMIT_DATA;
                else 
                    v.state := ST_WAIT_DATA;
                end if;
            when ST_TRANSMIT_DATA =>
                --Por defecto siempre me quedo en este estado.
                v.state := ST_TRANSMIT_DATA;
                if (m_axis_tready_i = '1') then
                    v.state := ST_WAIT_DATA;
                end if;
            when others =>
                v.state := ST_WAIT_DATA;
        end case;

        --Manejo de señales de salida y de los elementos de memoria internos.
        case(regs.state) is
            --Esperamos un dato valido.
            when ST_WAIT_DATA =>
                --Indicamos que podemos guardar datos.
                v.s_axis_tready := '1';
                if (s_axis_tvalid_i = '1' and s_axis_tready_o = '1') then
                    --Como en el proximo ciclo vamos a estar procesando bajamos el tready
                    v.s_axis_tready := '0';
                    --Metemos el dato en el MSB del shif trefgister
                    v.shift_reg := s_axis_tdata_i & regs.shift_reg(regs.shift_reg'left downto 1);
                end if;
            --Procesamos el dato de entrado.
            when ST_PROCESS_DATA =>
                --Holdeamos al master que nos esta excitando.
                v.s_axis_tready := '0';
                --Hacemos la asignacion del trabajo del shift
                temp_result(1) := xor(regs.shift_reg and POL1_SLV);
                temp_result(0) := xor(regs.shift_reg and POL2_SLV);
                --Ahora tenemos que colocar y hacer un shift register
                v.m_axis_tdata :=   regs.m_axis_tdata(1 downto 0) & temp_result;
                v.count        :=   regs.count + 1;
                if (regs.count >= CYCLES_TO_FILL_OUTPUT-1 ) then
                    v.count := 0;
                    --Ya estamos intentando poner un dato valido a la salida.
                    v.m_axis_tvalid := '1';
                end if;
            --Transmitimos hacia el slave.
            when ST_TRANSMIT_DATA =>
                --Holdeamos al master que nos esta excitando.
                v.s_axis_tready := '0';
                --Activamos el tvalid indicando que el dato ya esta valido a la salida
                v.m_axis_tvalid := '1';
                if (m_axis_tready_i = '1' and m_axis_tvalid_o = '1') then
                    --Si tenemos tready ya hay una transferencia y hay que cancelar el tvalid hacia el slave.
                    v.m_axis_tvalid := '0';
                end if;
            --Este es el estado por defecto si por una de esas casualidades caemos en un estado invalido.
            when others =>
                --Si caemos en un estado incorrecto reseteamos todo.
                v.shift_reg       := (others => '0');
                v.count           := 0;
                v.s_axis_tready   := '0';
                v.m_axis_tdata    := (others => '0');
                v.m_axis_tvalid   := '0';
        end case;


        --Asignaciuon de los modulos de entrada.
        regs_in <= v;
        --Asignacion de la salidas del modulo.
        s_axis_tready_o     <= regs.s_axis_tready;
        m_axis_tdata_o      <= regs.m_axis_tdata;
        m_axis_tvalid_o     <= regs.m_axis_tvalid;

    end process comb_process;



    reg_process : process (clk_i,a_reset_ni)
    begin
        if (a_reset_ni = '0' ) then
            regs <= regs_default;
        elsif (rising_edge(clk_i)) then
            regs <= regs_in;
        end if;
    end process reg_process;

end architecture ; -- rtl_2p