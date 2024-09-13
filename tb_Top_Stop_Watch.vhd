library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_top_Stop_Watch is
end tb_top_Stop_Watch;

architecture Behavioral of tb_top_Stop_Watch is

    -- Sinais locais para o DUT (Design Under Test)
    signal clk_in       : STD_LOGIC := '0';
    signal rst_in       : STD_LOGIC := '0';
    signal start_btn    : STD_LOGIC := '0';
    signal stop_btn     : STD_LOGIC := '0';
    signal split_btn    : STD_LOGIC := '0';
    signal hour_count_high : STD_LOGIC_VECTOR(3 downto 0);
    signal hour_count_low  : STD_LOGIC_VECTOR(3 downto 0);
    signal minute_count_high : STD_LOGIC_VECTOR(3 downto 0);
    signal minute_count_low  : STD_LOGIC_VECTOR(3 downto 0);
    signal second_count_high : STD_LOGIC_VECTOR(3 downto 0);
    signal second_count_low  : STD_LOGIC_VECTOR(3 downto 0);
    signal hundredth_count_high : STD_LOGIC_VECTOR(3 downto 0);
    signal hundredth_count_low  : STD_LOGIC_VECTOR(3 downto 0);

    constant clk_period : time := 10 ns;

begin

    -- Instância do DUT
    DUT: entity work.top_Stop_Watch
        port map (
            clk_in => clk_in,
            rst_in => rst_in,
            start_btn => start_btn,
            stop_btn => stop_btn,
            split_btn => split_btn,
            hour_count_high => hour_count_high,
            hour_count_low => hour_count_low,
            minute_count_high => minute_count_high,
            minute_count_low => minute_count_low,
            second_count_high => second_count_high,
            second_count_low => second_count_low,
            hundredth_count_high => hundredth_count_high,
            hundredth_count_low => hundredth_count_low
        );

    -- Geração do clock
    clk_process : process
    begin
        clk_in <= '0';
        wait for clk_period / 2;
        clk_in <= '1';
        wait for clk_period / 2;
    end process;

    -- Sequência de testes
    stimulus_process : process
    begin
        -- Inicialização
        rst_in <= '1';
        start_btn <= '0';
        stop_btn <= '0';
        split_btn <= '0';
        wait for 100 ns;
        rst_in <= '0';

        -- Teste de Start
        start_btn <= '1';
        wait for 7000 ns;
        start_btn <= '0';

        -- Teste de Stop
        stop_btn <= '1';
        wait for 1000 ns;
        stop_btn <= '0';
        wait for 1000 ns;
        start_btn <= '1';
        wait for 1000 ns;
        start_btn <= '0';
        wait for 1000 ns;

        split_btn <= '1';
        wait for 1000 ns;
        split_btn <= '0';

        -- Fim do teste
        wait;
    end process;

end Behavioral;
