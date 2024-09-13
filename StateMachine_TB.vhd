library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity StateMachine_tb is
    -- Nenhuma porta, pois é um testbench
end StateMachine_tb;

architecture Behavioral of StateMachine_tb is

    -- Sinais para simular as entradas e saídas
    signal clk        : STD_LOGIC := '0';
    signal reset      : STD_LOGIC := '0';
    signal start_btn  : STD_LOGIC := '0';
    signal stop_btn   : STD_LOGIC := '0';
    signal split_btn  : STD_LOGIC := '0';
    signal reset_out  : STD_LOGIC;
    signal start_out  : STD_LOGIC;
    signal stop_out   : STD_LOGIC;
    signal split_out  : STD_LOGIC;

    -- Instanciando a unidade de design (DUT - Design Under Test)
    component StateMachine
        Port (  
            clk        : in  STD_LOGIC;
            reset      : in  STD_LOGIC;
            start_btn  : in  STD_LOGIC;
            stop_btn   : in  STD_LOGIC;
            split_btn  : in  STD_LOGIC;
            reset_out  : out STD_LOGIC;
            start_out  : out STD_LOGIC;
            stop_out   : out STD_LOGIC;
            split_out  : out STD_LOGIC
        );
    end component;

begin

    -- Instância da DUT
    uut: StateMachine
        Port map (
            clk        => clk,
            reset      => reset,
            start_btn  => start_btn,
            stop_btn   => stop_btn,
            split_btn  => split_btn,
            reset_out  => reset_out,
            start_out  => start_out,
            stop_out   => stop_out,
            split_out  => split_out
        );

    -- Processo para gerar o clock (com período de 10 ns)
    clk_process :process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process clk_process;

    -- Processo de simulação das entradas
    stimulus: process
    begin
        -- Resetar o sistema
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        
        -- Simulação de pressionamento de botões
        -- Estado RESET -> START
        start_btn <= '1';
        wait for 20 ns;
        start_btn <= '0';
        wait for 50 ns;

        -- Estado START -> SPLIT
        split_btn <= '1';
        wait for 20 ns;
        split_btn <= '0';
        wait for 50 ns;

        -- Estado SPLIT -> STOP
        stop_btn <= '1';
        wait for 20 ns;
        stop_btn <= '0';
        wait for 50 ns;

        -- Estado STOP -> START
        start_btn <= '1';
        wait for 20 ns;
        start_btn <= '0';
        wait for 50 ns;

        -- Finalizando a simulação
        wait for 100 ns;
        wait;
    end process stimulus;

end Behavioral;
