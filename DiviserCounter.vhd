library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Substitui as bibliotecas de aritmética antigas

entity DiviserCounter is
    Port ( clk             : in  STD_LOGIC;
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
end DiviserCounter;

architecture Behavioral of DiviserCounter is
    signal hundreds           : INTEGER := 0;
    signal seconds            : INTEGER := 0;
    signal minutes            : INTEGER := 0;
    signal hours              : INTEGER := 0;
    signal counting_enabled   : STD_LOGIC := '0';
begin
    process(clk, reset)
    begin
        if reset = '1' then  -- Reset ativo em nível alto
            hundreds        <= 0;
            seconds         <= 0;
            minutes         <= 0;
            hours           <= 0;
            counting_enabled <= '0';
            hour_count_high <= (others => '0');
            hour_count_low  <= (others => '0');
            minute_count_high <= (others => '0');
            minute_count_low  <= (others => '0');
            second_count_high <= (others => '0');
            second_count_low  <= (others => '0');
            hundredth_count_high <= (others => '0');
            hundredth_count_low  <= (others => '0');
        elsif rising_edge(clk) then
            if start = '1' then
                counting_enabled <= '1';
            elsif stopp = '1' then
                counting_enabled <= '0';
            end if;

            if counting_enabled = '1' then
                if pulse_in = '1' then
                    hundreds <= hundreds + 1;

                    -- Contagem de segundos
                    if hundreds = 100 then
                        hundreds <= 0;
                        seconds <= seconds + 1;
                    end if;

                    -- Contagem de minutos
                    if seconds = 60 then
                        seconds <= 0;
                        minutes <= minutes + 1;
                    end if;

                    -- Contagem de horas
                    if minutes = 60 then
                        minutes <= 0;
                        hours <= hours + 1;
                    end if;
                end if;
            end if;

            -- Retorno das contagens
            if return_count = '1' then
                -- Geração dos sinais de alta e baixa ordem
                hundredth_count_low  <= std_logic_vector(to_unsigned(hundreds mod 10, 4));
                hundredth_count_high <= std_logic_vector(to_unsigned(hundreds / 10, 4));
                second_count_low     <= std_logic_vector(to_unsigned(seconds mod 10, 4));
                second_count_high    <= std_logic_vector(to_unsigned(seconds / 10, 4));
                minute_count_low     <= std_logic_vector(to_unsigned(minutes mod 10, 4));
                minute_count_high    <= std_logic_vector(to_unsigned(minutes / 10, 4));
                hour_count_low       <= std_logic_vector(to_unsigned(hours mod 10, 4));
                hour_count_high      <= std_logic_vector(to_unsigned(hours / 10, 4));
            end if;
        end if;
    end process;
end Behavioral;
