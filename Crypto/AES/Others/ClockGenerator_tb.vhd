LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ClockGenerator_tb IS
    GENERIC (
        MIN_INDEX : NATURAL := 0;
        MAX_INDEX : POSITIVE := 10;
        SYS_CLK_FREQ : INTEGER := 50_000_000;
        BAUD_RATE : INTEGER := 10_000_000
    );
END ENTITY;

ARCHITECTURE rtl OF ClockGenerator_tb IS
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL rst, start, baud_clk, ready : STD_LOGIC;
    SIGNAL clk_index : INTEGER RANGE MIN_INDEX - 1 TO MAX_INDEX + 1;
BEGIN
    clk <= NOT clk AFTER 5 ns; -- Simulate 50 MHz clk
    clockgenerator_inst : ENTITY work.ClockGenerator
        GENERIC MAP(
            MIN_INDEX => MIN_INDEX,
            MAX_INDEX => MAX_INDEX,
            SYS_CLK_FREQ => SYS_CLK_FREQ,
            BAUD_RATE => BAUD_RATE
        )
        PORT MAP(
            clk => clk,
            rst => rst,
            start => start,
            baud_clk => baud_clk,
            ready => ready,
            clk_index => clk_index
        );
    processTest : PROCESS
    BEGIN
        rst <= '1';
        start <= '0';
        WAIT FOR 30 ns;
        rst <= '0';
        WAIT FOR 30 ns;
        -- Start
        WAIT UNTIL rising_edge(clk);
        WAIT FOR 5 ns;
        start <= '1';
        WAIT FOR 10 ns;
        start <= '0';
        -- Start again after ready 50 ns
        WAIT UNTIL rising_edge(ready);
        WAIT FOR 50 ns;
        WAIT UNTIL rising_edge(clk);
        WAIT FOR 5 ns;
        start <= '1';
        WAIT FOR 10 ns;
        start <= '0';
        -- Generating...
        WAIT FOR 300 ns;
        -- Reset during generating baud clock
        rst <= '1';
        WAIT FOR 30 ns;
        rst <= '0';
        WAIT FOR 30 ns;
        WAIT;
    END PROCESS;
END ARCHITECTURE;