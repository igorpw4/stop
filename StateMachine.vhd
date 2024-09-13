library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity StateMachine is
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
end StateMachine;

architecture Behavioral of StateMachine is

    -- Definição dos estados
    type state_type is (START, STOP_S, SPLIT, ESPERA);
    signal current_state, next_state : state_type;

begin
    -- Processo de transição de estados (síncrono com reset)
    process(clk, reset)
    begin
        if reset = '1' then
            reset_out <= '1';
            current_state <= ESPERA;  
        elsif rising_edge(clk) then
            reset_out <= '0';
            current_state <= next_state;
        end if;
    end process;

    -- Processo de definição da lógica de transição de estados
    process(current_state, start_btn, stop_btn, split_btn)    
    begin
        -- Valores padrão para as saídas (para evitar latch)
        start_out <= '0';
        stop_out <= '0';
        split_out <= '0';

        case current_state is
            when ESPERA =>
                if start_btn = '1' then
                    next_state <= START;
                elsif stop_btn = '1' then
                    next_state <= STOP_S;
                elsif split_btn = '1' then
                    next_state <= SPLIT;
                else
                    next_state <= ESPERA;
                end if;

            when START =>
                start_out <= '1';  -- Ativa a saída start
                if stop_btn = '1' then
                    start_out <= '0';  -- Desativa a saída start
                    next_state <= STOP_S;
                elsif split_btn = '1' then
                    start_out <= '0';  -- Desativa a saída start
                    next_state <= SPLIT;
                else
                    next_state <= START;
                end if;

            when STOP_S =>
                stop_out <= '1';  -- Ativa a saída stop
                if start_btn = '1' then
                    stop_out <= '0';  -- Desativa a saída stop
                    next_state <= START;
                elsif split_btn = '1' then
                    stop_out <= '0';  -- Desativa a saída stop
                    next_state <= SPLIT;
                else
                    next_state <= STOP_S;
                end if;

            when SPLIT =>
                split_out <= '1';  -- Ativa a saída split
                if stop_btn = '1' then
                    split_out <= '0';  -- Desativa a saída split
                    next_state <= STOP_S;
                elsif start_btn = '1' then
                    split_out <= '0';  -- Desativa a saída split
                    next_state <= START;
                else
                    next_state <= ESPERA;
                end if;

            when others =>
                next_state <= ESPERA;
        end case;
    end process;

end Behavioral;
