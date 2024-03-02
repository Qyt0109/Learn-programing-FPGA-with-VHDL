LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Debounce IS
    GENERIC (
        DEBOUNCE_TIME : INTEGER := 5000000 -- 5 M
    );
    PORT (
        clk : IN STD_LOGIC;
        sw_in : IN STD_LOGIC;
        sw_debounced : OUT STD_LOGIC
    );
END ENTITY Debounce;

ARCHITECTURE rtl OF Debounce IS
    SIGNAL debounce_counter : INTEGER RANGE 0 TO DEBOUNCE_TIME;
    SIGNAL state : STD_LOGIC;
BEGIN
    process_Debounce : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF sw_in /= state AND debounce_counter < DEBOUNCE_TIME THEN
                debounce_counter <= debounce_counter + 1;
            ELSIF debounce_counter = DEBOUNCE_TIME THEN
                state <= sw_in;
                debounce_counter <= 0;
            ELSE
                debounce_counter <= 0;
            END IF;
        END IF;
    END PROCESS;

    sw_debounced <= state;

END ARCHITECTURE rtl;