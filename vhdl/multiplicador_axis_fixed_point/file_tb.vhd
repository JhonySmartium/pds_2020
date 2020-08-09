library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

-----------------------------------------------------------

entity file_tb is

end entity ;

-----------------------------------------------------------

architecture testbench of file_tb is
    --Archivos de entrada y salida
    --------------------------------------------------------------------------------
    --  VIVADO
    --------------------------------------------------------------------------------
    --Para probar el del vivado podemos usar el siguiente
    constant in_file    : string  := "data_in.txt"; 
    constant out_file   : string  := "./../../../../../data_out.txt"; 

    --------------------------------------------------------------------------------
    -- Questasim / Modelsim
    --------------------------------------------------------------------------------
    --Para probar el del questa podemos usar el siguiente
    --constant in_file    : string  := "data_in.txt"; 
    --constant out_file   : string  := "data_out.txt"; 


    --Items para guardar
    constant ITEMS_TO_SAVE : integer := 200; 

    -- Testbench DUT generics
    constant DATA_IN_WIDTH : integer := 16; 

    --Clock and Reset
    signal clk,reset : std_logic;
    -- Other constants
    constant C_CLK_PERIOD : real := 10.0e-9; -- NS
    -- Punteros para los archivos
    file r_fptr,w_fptr : text;

    --Declaramos las signal del tb para manejarnos con las señales AXIS.
    signal s_axis_tdata_tb     : std_logic_vector(DATA_IN_WIDTH-1 downto 0);
    signal s_axis_tvalid_tb    : std_logic;
    signal s_axis_tready_tb    : std_logic;
    signal m_axis_tdata_tb     : std_logic_vector((2*DATA_IN_WIDTH)-1 downto 0);
    signal m_axis_tvalid_tb    : std_logic;
    signal m_axis_tready_tb    : std_logic;

begin
    -----------------------------------------------------------
    -- Clocks and Reset
    -----------------------------------------------------------
    CLK_GEN : process
    begin
        clk <= '1';
        wait for C_CLK_PERIOD / 2.0 * (1 SEC);
        clk <= '0';
        wait for C_CLK_PERIOD / 2.0 * (1 SEC);
    end process CLK_GEN;

    RESET_GEN : process
    begin
        reset <= '0',
                 '1' after 20.0*C_CLK_PERIOD * (1 SEC);
        wait;
    end process RESET_GEN;

    -----------------------------------------------------------
    -- Testbench Stimulus
    -----------------------------------------------------------
    -- Read file process
    p_read_file : process is
        variable fstatus    : file_open_status;
        variable file_line  : line;
        variable slv_v      : integer;
    begin
        --Por defecto deshabilitamos la transacción
        --Abrimos el archivo
        file_open(fstatus, r_fptr,in_file, read_mode);
        --Asignación por defecto.
        s_axis_tdata_tb     <= (others => '0');
        s_axis_tvalid_tb    <= '0';
        wait until (reset = '1');
        --Haemos un espera en ciclos de reloj
        delay_1 : for i in 0 to 10 loop
            wait until (clk'event and clk = '1');           
        end loop;
        --Recorremos el archivo
        loop_file : while not endfile(r_fptr) loop
            readline(r_fptr,file_line);
            read(file_line,slv_v);
            report "Valor leido: " & integer'image(slv_v);
            --Generemos la señal AXI con el pulso en '1' cuando recibamos el tready. 
            if (s_axis_tready_tb = '1') then
                s_axis_tdata_tb  <= std_logic_vector(to_signed(slv_v, DATA_IN_WIDTH));
                s_axis_tvalid_tb <= '1';                
            end if;
            wait until (clk'event and clk = '1');                       
            s_axis_tvalid_tb <= '0';               
            --Esperamos 10 ciclos de reloj a modo de prueba.
            delay_2 : for i in 0 to 10 loop
                wait until (clk'event and clk = '1');           
            end loop;
        end loop ; -- loop_file
        s_axis_tdata_tb     <= (others => '0');
        s_axis_tvalid_tb    <= '0';
        report "Fin lectura del archivo";
        file_close(r_fptr);
        wait;
    end process; -- p_read_file

    p_write_file : process is
        variable fstatus    : file_open_status;
        variable file_line  : line;
        variable v_int      : integer;
        variable v_std_lv   : std_logic_vector((m_axis_tdata_tb'LENGTH - 1) downto 0);
    begin
        -- Para este caso vamos a aceptar todos los datos que salgan.
        m_axis_tready_tb <= '1'; 
        --Abrimos el archivo
        file_open(fstatus, w_fptr,out_file,write_mode);
        wait until (reset = '1');
        
        --Vamos a escribir solo 200.
        write_file : for i in 0 to ITEMS_TO_SAVE loop
            wait until (m_axis_tvalid_tb = '1');
            v_int    := to_integer(signed(m_axis_tdata_tb));    
            v_std_lv := m_axis_tdata_tb;
            write(file_line,v_int);
            write(file_line,v_std_lv,right,40);
            writeline(w_fptr, file_line);
            report "Valor ESCRITO: " & integer'image(v_int);
        end loop;
        report "Fin escritura del archivo";
        file_close(w_fptr);
        wait;
    end process; -- p_write_file

    -----------------------------------------------------------
    -- Entity Under Test
    -----------------------------------------------------------
    -- Q1.15.

    u_mult_by_constant : entity work.mult_by_constant
        generic map (
            DATA_IN_WIDTH  => DATA_IN_WIDTH,
            DATA_OUT_WIDTH => DATA_IN_WIDTH*2,
            CONST_VALUE    => -8192 --Esto es -0.5 en presición Q1.15.
        )
        port map (
            clk_i           => clk,
            reset_ni        => reset,
            --AXIS Slava --> Por aca va a recibir los datos
            s_axis_tdata_i  => s_axis_tdata_tb,
            s_axis_tvalid_i => s_axis_tvalid_tb,
            s_axis_tready_o => s_axis_tready_tb,
            --AXIS Master --> Por aca va a mandar los datos
            m_axis_tdata_o  => m_axis_tdata_tb,
            m_axis_tvalid_o => m_axis_tvalid_tb,
            m_axis_tready_i => m_axis_tready_tb
        );

end architecture testbench;