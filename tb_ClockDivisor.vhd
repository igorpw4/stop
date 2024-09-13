library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_CentisecondCounter is
end tb_CentisecondCounter;

architecture behavior of tb_CentisecondCounter is
    -- Component declaration for the CentisecondCounter
    component CentisecondCounter
        Port ( clk       : in  STD_LOGIC;
               reset     : in  STD_LOGIC;
               pulse_out : out STD_LOGIC);
    end component;

    -- Signals for connecting to the CentisecondCounter
    signal clk       : STD_LOGIC := '0';
    signal reset     : STD_LOGIC := '0';
    signal pulse_out : STD_LOGIC;

    -- Clock period
    constant clk_period : time := 2 ns;
begin
    -- Instantiate the CentisecondCounter
    uut: CentisecondCounter
        Port map (
            clk       => clk,
            reset     => reset,
            pulse_out => pulse_out
        );

    -- Clock process
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    -- Reset process
    reset_process :process
    begin
        -- Apply reset
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        -- Finish simulation after some time
        wait for 20000000 ns; -- Adjust the time as needed
        assert false report "End of simulation" severity note;
        wait;
    end process;

end behavior;
