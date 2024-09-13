library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CentisecondCounter is
    Port ( clk       : in  STD_LOGIC;
           reset     : in  STD_LOGIC;
           pulse_out : out STD_LOGIC;
           led_out : out STD_LOGIC
           );
end CentisecondCounter;

architecture Behavioral of CentisecondCounter is
    signal counter : INTEGER := 0;
    signal led_counter : INTEGER := 0;
begin
    process(reset, clk)
    begin
        if reset = '1' then
            pulse_out <= '0';
            led_out <= '0';
            counter   <= 0;
            led_counter <= 0;
        elsif rising_edge(clk) then
            if reset = '1' then
                counter <= 0;
                pulse_out <= '0';
                led_out <= '0';
                led_counter <= 0;
            end if;
            
            if (led_counter <= 25000000) then
                led_out <= '1';
            else
                led_out <= '0';
            end if;
            
            if (led_counter = 50000000) then
                led_counter <= 0;
            else
                led_counter <= led_counter + 1;
            end if;

            if counter = 1000000 then
                counter <= 0;
                pulse_out <= '1'; 
            else
                counter <= counter + 1;
                pulse_out <= '0'; 
            end if;
        end if;
    end process;

end Behavioral;
