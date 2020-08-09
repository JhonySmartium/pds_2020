--------------------------------------------------------------------------------
--
-- Title    : mult_by_constant.vhd
-- Project  : PDS 2020
-- Author   : GOnzalo Lavigna
-- Date     : 02/JUL/2020
--------------------------------------------------------------------------------
--
-- Description
-- Multiplicar poru nas constante un stream proveniente de AXI y devolverlo en AXIS.
-- Depende del usuario utilizar como corresponde el corrimiento y la utilización de la 
-- coma.
--------------------------------------------------------------------------------

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity mult_by_constant is
  generic (
          DATA_IN_WIDTH     : integer := 16;
          DATA_OUT_WIDTH    : integer := 32;
          CONST_VALUE       : integer := -5
      );

  port (
    clk_i             : IN std_logic;
    reset_ni          : IN std_logic;
    --SLAVE AXIS
    s_axis_tdata_i    : IN  std_logic_vector(DATA_IN_WIDTH-1 downto 0);
    s_axis_tvalid_i   : IN  std_logic;
    s_axis_tready_o   : OUT std_logic;
    --MASTER AXIS
    m_axis_tdata_o    : OUT std_logic_vector(DATA_OUT_WIDTH-1 downto 0);
    m_axis_tvalid_o   : OUT std_logic;
    m_axis_tready_i   : IN  std_logic
  ) ;
end entity ; -- mult_by_constant

architecture rtl of mult_by_constant is
    --Definimos la constante por la cual multiplicamos, por defecto le vamos
    --a dar un tamaño igual a la señal de entrada.
    signal CONST : signed(DATA_IN_WIDTH-1 downto 0) := to_signed(CONST_VALUE,DATA_IN_WIDTH);
    --Definicion de estados del modulo
    type state_type is ( 
        ST_IDLE,                            
        ST_RECEIVE_DATA,          
        ST_RECEIVE_AND_TRANSMIT,
        ST_TRANSMIT_DATA       
    );                        

    type reg_type is record 
        state           : state_type;
        s_axis_tready   : std_logic;
        m_axis_tdata    : std_logic_vector(DATA_OUT_WIDTH-1 downto 0);
        m_axis_tvalid   : std_logic;
    end record;

    constant regs_default : reg_type := (
        state           => ST_IDLE,
        s_axis_tready   => '0',
        m_axis_tdata    => (others => '0'),
        m_axis_tvalid   => '0'
    ); 

    signal regs,regs_in : reg_type;

begin
    comb_process : process (all)
        variable v : reg_type;
    begin
        --Grab regs outputs. Evitamos siempre los latchs si no hay datos.
        v := regs;
        --------------------------------------------------------------------------------
        -- Este metodo de diseño genera un retraso de un ciclo de reloj si lo queremos 
        -- hacer continuo.
        --------------------------------------------------------------------------------
        case (v.state) is
            when ST_IDLE =>
                --En este estado al estar esperando una operacion informo que puedo aceptar datos.
                v.s_axis_tready := '1';                
                v.m_axis_tvalid := '0';
                if (s_axis_tvalid_i = '1') then
                    --Esta acción es la que efectivamente realiza la multiplicación.
                    v.m_axis_tdata  := std_logic_vector(signed(s_axis_tdata_i) * CONST);
                    v.m_axis_tvalid := '1';
                    --Cuando envie el dato directamente puedo volver a aceptar datos.
                    v.s_axis_tready := '0';
                    v.state := ST_TRANSMIT_DATA;
                end if;                
            when ST_TRANSMIT_DATA =>
                --En este estado siempre por las dudas que nos quedemos aca informamos que no podemos recibir datos.
                v.s_axis_tready := '0';
                v.m_axis_tvalid := '1';                
                if (m_axis_tready_i = '1') then
                    --Si pude enviar el dato significa que puedo volver a aceptar datos.
                    v.s_axis_tready := '1';
                    v.m_axis_tvalid := '0';
                    v.state         := ST_IDLE;
                else 
                    v.state := ST_TRANSMIT_DATA;                    
                end if;
            when others =>
                null;
        end case;

        --Assign regs in with regulst.
        regs_in <= v;
        --Assing Outputsa
        s_axis_tready_o     <= regs.s_axis_tready;
        m_axis_tdata_o      <= regs.m_axis_tdata;
        m_axis_tvalid_o     <= regs.m_axis_tvalid;

    end process comb_process;

    reg_process : process (reset_ni, clk_i)
    begin
      if (reset_ni = '0') then
        regs <= regs_default;
      elsif (rising_edge(clk_i)) then
        regs <= regs_in;
      end if;
    end process reg_process;

end architecture ; -- rtl