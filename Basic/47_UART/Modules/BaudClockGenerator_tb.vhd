LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY BaudClockGenerator_tb IS
END ENTITY;

ARCHITECTURE rtl OF BaudClockGenerator_tb IS
    COMPONENT BaudClockGenerator IS
        GENERIC (
            NUMBER_OF_CLOCKS : INTEGER;
            SYS_CLK_FREQ : INTEGER;
            BAUD_RATE : INTEGER;
            IS_RX:boolean
        );
        PORT (
            -- input
            clk : IN STD_LOGIC; -- 50 MHz
            rst : IN STD_LOGIC;
            start : IN STD_LOGIC;
            -- output
            baud_clk : OUT STD_LOGIC;
            ready : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL rst : STD_LOGIC;
    SIGNAL start : STD_LOGIC;
    SIGNAL baud_clk : STD_LOGIC;
    SIGNAL ready : STD_LOGIC;

BEGIN
    -- 2 ways to make simulate a clk signal:
    -- 1)
    clk <= not clk after 10 ns; -- Simulate the 50MHz clock input. Remember to init the clk signal value (SIGNAL clk : STD_LOGIC := '0';)
    -- 2)
    -- processClkSim : PROCESS
    -- BEGIN
    --     clk <= '0';
    --     WAIT FOR 10 ns; -- ns
    --     clk <= '1';
    --     WAIT FOR 10 ns; -- ns
    -- END PROCESS;

    BaudClockGenerator_inst : BaudClockGenerator
    GENERIC MAP(
        NUMBER_OF_CLOCKS => 10,
        SYS_CLK_FREQ => 50000000,
        BAUD_RATE => 115200,
        IS_RX => true
    )
    PORT MAP(
        -- input
        clk => clk,
        rst => rst,
        start => start,
        -- output
        baud_clk => baud_clk,
        ready => ready
    );

    processTest : PROCESS
    BEGIN
        -- init - run 200 ns
        rst <= '1';
        start <= '0';
        WAIT FOR 100 ns; -- ns
        rst <= '0';
        WAIT FOR 100 ns; -- ns
        -- trigger start - run 100 us
        WAIT UNTIL rising_edge(clk);
        start <= '1';
        WAIT UNTIL rising_edge(clk);
        start <= '0';
        -- trigger start again - run 100 us
        wait until rising_edge(ready);
        WAIT UNTIL rising_edge(clk);
        start <= '1';
        WAIT UNTIL rising_edge(clk);
        start <= '0';


        WAIT; -- 1 time process
    END PROCESS processTest;
END ARCHITECTURE rtl;