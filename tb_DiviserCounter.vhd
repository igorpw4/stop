library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_DiviserCounter is
end tb_DiviserCounter;

architecture Behavioral of tb_DiviserCounter is
    -- Component declaration for the Unit Under Test (UUT)
    component DiviserCounter
        Port ( clk             : in  STD_LOGIC;
               reset          : in  STD_LOGIC;
               pulse_in        : in  STD_LOGIC;
               start          : in  STD_LOGIC;
               stopp            : in  STD_LOGIC;
               return_count    : in  STD_LOGIC;
               hour_count      : out STD_LOGIC_VECTOR(7 downto 0);
               minute_count    : out STD_LOGIC_VECTOR(7 downto 0);
               segund_count    : out STD_LOGIC_VECTOR(7 downto 0);
               hundredth_count : out STD_LOGIC_VECTOR(7 downto 0)
             );
    end component;

    -- Testbench signals
    signal clk            : STD_LOGIC := '0';
    signal reset         : STD_LOGIC := '0';
    signal pulse_in       : STD_LOGIC := '0';
    signal start         : STD_LOGIC := '0';
    signal stopp           : STD_LOGIC := '0';
    signal return_count   : STD_LOGIC := '0';
    signal hour_count     : STD_LOGIC_VECTOR(7 downto 0);
    signal minute_count   : STD_LOGIC_VECTOR(7 downto 0);
    signal segund_count   : STD_LOGIC_VECTOR(7 downto 0);
    signal hundredth_count: STD_LOGIC_VECTOR(7 downto 0);

    -- Clock generation
    constant clk_period : time := 10 ns;
begin
    -- Instantiate the Unit Under Test (UUT)
    uut: DiviserCounter
        Port map (
            clk             => clk,
            reset          => reset,
            pulse_in        => pulse_in,
            start          => start,
            stopp            => stopp,
            return_count    => return_count,
            hour_count      => hour_count,
            minute_count    => minute_count,
            segund_count    => segund_count,
            hundredth_count => hundredth_count
        );

    -- Clock process definitions
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset the system
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait for 20 ns;
        return_count <= '1';
        wait for 20 ns;
        -- Start counting
        start <= '1';
        wait for 20 ns;
        start <= '0';

        -- Simulate pulse_in signals
        for i in 0 to 100000 loop
            pulse_in <= '1';
            wait for 10 ns;
            pulse_in <= '0';
            wait for 10 ns;
        end loop;

        -- stopp countin

        -- Test return_count signal
        return_count <= '1';
        wait for 50 ns;
        return_count <= '0';

        -- Wait and finish
        wait for 200000 ns;
        wait;
    end process;
end Behavioral;
