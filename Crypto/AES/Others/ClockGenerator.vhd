LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ClockGenerator IS
    GENERIC (
        MIN_INDEX : NATURAL := 0;
        MAX_INDEX : POSITIVE := 10;
        SYS_CLK_FREQ : INTEGER := 50_000_000;
        BAUD_RATE : INTEGER := 115_200
    );
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        start : IN STD_LOGIC;
        baud_clk : OUT STD_LOGIC;
        clk_index : OUT INTEGER RANGE MIN_INDEX - 1 TO MAX_INDEX + 1;
        ready : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE rtl OF ClockGenerator IS
    CONSTANT BIT_PERIOD : NATURAL := SYS_CLK_FREQ / BAUD_RATE;
    CONSTANT HALF_BIT_PERIOD : INTEGER := SYS_CLK_FREQ / (2 * BAUD_RATE);
    SIGNAL bit_counter : NATURAL RANGE 0 TO BIT_PERIOD;
BEGIN
    processCount : PROCESS (rst, clk)
    BEGIN
        IF rst = '1' THEN
            baud_clk <= '0';
            bit_counter <= 0;
        ELSIF rising_edge(clk) THEN
            IF clk_index <= MAX_INDEX THEN
                IF bit_counter = BIT_PERIOD THEN
                    baud_clk <= '1';
                    bit_counter <= 0;
                ELSE
                    baud_clk <= '0';
                    bit_counter <= bit_counter + 1;
                END IF;
            ELSE
                baud_clk <= '0';
                bit_counter <= HALF_BIT_PERIOD - 1;
            END IF;
        END IF;
    END PROCESS;
    processBaudClock : PROCESS (rst, clk)
    BEGIN
        IF rst = '1' THEN
            clk_index <= MAX_INDEX + 1;
        ELSIF rising_edge(clk) THEN
            IF start = '1' THEN
                clk_index <= MIN_INDEX - 1;
            ELSIF bit_counter = HALF_BIT_PERIOD THEN
                clk_index <= clk_index + 1;
            END IF;
        END IF;
    END PROCESS;
    processReady : PROCESS (rst, clk)
    BEGIN
        IF rst = '1' THEN
            ready <= '1';
        ELSIF rising_edge(clk) THEN
            IF start = '1' THEN
                ready <= '0';
            ELSIF clk_index = MAX_INDEX + 1 THEN
                ready <= '1';
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;