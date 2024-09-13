library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_Stop_Watch is
    generic (
		DEB_DELAY : integer := 1000000;
		HALF_MS_COUNT : integer := 50000
	);
    Port (
        clk_in       : in  STD_LOGIC;
        rst_in       : in  STD_LOGIC;
        start_btn    : in  STD_LOGIC;
        stop_btn     : in  STD_LOGIC;
        split_btn    : in  STD_LOGIC;
        an, dec_ddp        : out std_logic_vector(7 downto 0)
    );
end top_Stop_Watch;

architecture Behavioral of top_Stop_Watch is

    -- Sinais internos
    signal hour_count_high :  STD_LOGIC_VECTOR(3 downto 0);
    signal hour_count_low  :  STD_LOGIC_VECTOR(3 downto 0);
    signal minute_count_high :  STD_LOGIC_VECTOR(3 downto 0);
    signal minute_count_low  :  STD_LOGIC_VECTOR(3 downto 0);
    signal second_count_high :  STD_LOGIC_VECTOR(3 downto 0);
    signal second_count_low  :  STD_LOGIC_VECTOR(3 downto 0);
    signal hundredth_count_high :  STD_LOGIC_VECTOR(3 downto 0);
    signal hundredth_count_low  :  STD_LOGIC_VECTOR(3 downto 0);
   signal reset_out, start_out, stop_out, split_out, debkey1, debkey2, debkey3, led_out: STD_LOGIC;
    signal pulse_in : STD_LOGIC;
    signal d1, d2, d3, d4, d5, d6, d7, d8 : std_logic_vector(5 downto 0); -- Corrigido para 7 segmentos
 
    -- Instâncias dos componentes
    component StateMachine
        Port (
            clk       : in  STD_LOGIC;
            reset     : in  STD_LOGIC;
            start_btn : in  STD_LOGIC;
            stop_btn  : in  STD_LOGIC;
            split_btn : in  STD_LOGIC;
            reset_out : out STD_LOGIC;
            start_out : out STD_LOGIC;
            stop_out  : out STD_LOGIC;
            split_out : out STD_LOGIC
        );
    end component;

   component CentisecondCounter
        Port (
            clk       : in  STD_LOGIC;
            reset     : in  STD_LOGIC;
            pulse_out : out STD_LOGIC;
            led_out : out STD_LOGIC
        );
    end component;

    component DiviserCounter
        Port (
            clk             : in  STD_LOGIC;
            reset           : in  STD_LOGIC;
            pulse_in        : in  STD_LOGIC;
            start           : in  STD_LOGIC;
            stopp           : in  STD_LOGIC;
            return_count    : in  STD_LOGIC;
            hour_count_high : out STD_LOGIC_VECTOR(3 downto 0);
            hour_count_low  : out STD_LOGIC_VECTOR(3 downto 0);
            minute_count_high : out STD_LOGIC_VECTOR(3 downto 0);
            minute_count_low  : out STD_LOGIC_VECTOR(3 downto 0);
            second_count_high : out STD_LOGIC_VECTOR(3 downto 0);
            second_count_low  : out STD_LOGIC_VECTOR(3 downto 0);
            hundredth_count_high : out STD_LOGIC_VECTOR(3 downto 0);
            hundredth_count_low  : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

begin
    -- Instância do StateMachine
    state_machine_inst : StateMachine
        Port map (
            clk       => clk_in,
            reset     => rst_in,
            start_btn => debkey1,
            stop_btn  => debkey2,
            split_btn => debkey3,
            reset_out => reset_out,
            start_out => start_out,
            stop_out  => stop_out,
            split_out => split_out
        );

    -- Instância do CentisecondCounter
   centisecond_counter_inst : CentisecondCounter
        Port map (
            clk       => clk_in,
            reset     => rst_in,
            pulse_out => pulse_in,
            led_out => led_out
        );

    -- Instância do DiviserCounter
    diviser_counter_inst : DiviserCounter
        Port map (
            clk             => clk_in,
            reset           => reset_out,
            pulse_in        => pulse_in,
            start           => start_out,
            stopp           => stop_out,
            return_count    => split_out,
            hour_count_high => hour_count_high,
            hour_count_low  => hour_count_low,
            minute_count_high => minute_count_high,
            minute_count_low  => minute_count_low,
            second_count_high => second_count_high,
            second_count_low  => second_count_low,
            hundredth_count_high => hundredth_count_high,
            hundredth_count_low  => hundredth_count_low
        );

    deb0 : entity work.debounce(debounce_arch)
    generic map(DELAY => 750000)
    port map (
        clk_i => clk_in,
        rstn_i => rst_in,
        key_i => start_btn,
        debkey_o => debkey1
    );
    deb1 : entity work.debounce(debounce_arch)
    generic map(DELAY => 750000)
    port map (
        clk_i => clk_in,
        rstn_i => rst_in,
        key_i => stop_btn,
        debkey_o => debkey2
    );
    deb2 : entity work.debounce(debounce_arch)
    generic map(DELAY => 750000)
    port map (
        clk_i => clk_in,
        rstn_i => rst_in,
        key_i => split_btn,
        debkey_o => debkey3
    );

  process (rst_in, clk_in)
    begin
         if rst_in = '1' then
            d1 <= (others => '0');
            d2 <= (others => '0');
            d3 <= (others => '0');
            d4 <= (others => '0');
            d5 <= (others => '0');
            d6 <= (others => '0');
            d7 <= (others => '0');
            d8 <= (others => '0');
       elsif rising_edge(clk_in) then
            if (led_out = '0') then
                d1 <= ('1' & hundredth_count_low & '1');
                d2 <= ('1' & hundredth_count_high & '1');
                d3 <= ('1' & second_count_low & '1');
                d4 <= ('1' & second_count_high & '1');
                d5 <= ('1' & minute_count_low  & '1');
                d6 <= ('1' & minute_count_high & '1');
                d7 <= ('1' & hour_count_low  & '1');
                d8 <= ('1' & hour_count_high & '1');
            else
                d1 <= ('0' & hundredth_count_low & '1');
                d2 <= ('0' & hundredth_count_high & '1');
                d3 <= ('0' & second_count_low & '1');
                d4 <= ('0' & second_count_high & '1');
                d5 <= ('0' & minute_count_low  & '1');
                d6 <= ('0' & minute_count_high & '1');
                d7 <= ('0' & hour_count_low  & '1');
                d8 <= ('0' & hour_count_high & '1');
            end if;
        end if;
    end process;
    -- Controle do display de 7 segmentos

    display : entity work.dspl_drv_8dig(dspl_drv_8dig)
        generic map (HALF_MS_COUNT => HALF_MS_COUNT)
        port map (
            clock    => clk_in,
            reset    => rst_in,
            d1       => d1,
            d2       => d2,
            d3       => d3,
            d4       => d4,
            d5       => d5,
            d6       => d6,
            d7       => d7,
            d8       => d8,
            an       => an,
            dec_ddp  => dec_ddp
        );

 
  


end Behavioral;
