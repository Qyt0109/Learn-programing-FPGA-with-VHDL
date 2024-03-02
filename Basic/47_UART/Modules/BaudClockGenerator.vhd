LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY BaudClockGenerator IS
    GENERIC (
        NUMBER_OF_CLOCKS : INTEGER;
        SYS_CLK_FREQ : INTEGER;
        BAUD_RATE : INTEGER;
        IS_RX : BOOLEAN -- True if BaudClockGenerator is used in Rx module
    );
    PORT (
        -- inputs
        clk : IN STD_LOGIC; -- 50 MHz
        rst : IN STD_LOGIC;
        start : IN STD_LOGIC;
        -- outputs
        baud_clk : OUT STD_LOGIC;
        ready : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE rtl OF BaudClockGenerator IS
    CONSTANT BIT_PERIOD : INTEGER := SYS_CLK_FREQ / BAUD_RATE;
    CONSTANT HALF_BIT_PERIOD : INTEGER := SYS_CLK_FREQ / (2 * BAUD_RATE);
    SIGNAL bit_counter : INTEGER RANGE 0 TO BIT_PERIOD;
    SIGNAL clk_left : INTEGER RANGE 0 TO NUMBER_OF_CLOCKS;
BEGIN
    processBitCounter : PROCESS (rst, clk)
    BEGIN
        IF rst = '1' THEN
            baud_clk <= '0';
            bit_counter <= 0;
        ELSIF rising_edge(clk) THEN
            IF clk_left > 0 THEN
                IF bit_counter = BIT_PERIOD THEN
                    baud_clk <= '1';
                    bit_counter <= 0;
                ELSE
                    baud_clk <= '0';
                    bit_counter <= bit_counter + 1;
                END IF;
            ELSE
                baud_clk <= '0';
                -- Rx module case, load bit_counter with HALF_BIT_PERIOD so that
                -- the first baud_clk pulse occures 1/2 bit period after assering the start.
                IF IS_RX = true THEN
                    bit_counter <= HALF_BIT_PERIOD;
                -- Tx module case, load bit_counter with 0 so that
                -- the first baud_clk pulse occures 1 bit period after assering the start.
                ELSE
                    bit_counter <= 0;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    processBeginOrEndOfBaudClock : PROCESS (rst, clk)
    BEGIN
        IF rst = '1' THEN
            clk_left <= 0;
        ELSIF rising_edge(clk) THEN
            IF start = '1' THEN
                clk_left <= NUMBER_OF_CLOCKS;
            ELSIF baud_clk = '1' THEN
                clk_left <= clk_left - 1;
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
            ELSIF clk_left = 0 THEN
                ready <= '1';
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;
