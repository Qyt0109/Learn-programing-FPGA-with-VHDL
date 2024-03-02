LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

ENTITY HeaterFsm IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        sw : IN STD_LOGIC;
        temp : IN STD_LOGIC;
        heater : OUT STD_LOGIC;
        red_led : OUT STD_LOGIC;
        green_led : OUT STD_LOGIC
    );
END ENTITY HeaterFsm;

ARCHITECTURE rtl OF HeaterFsm IS
    TYPE enum_HeaterFsmState IS (IDLE, HEATING, READY);
    SIGNAL state : enum_HeaterFsmState;
BEGIN
    process_HeaterFsm : PROCESS (rst, clk)
    BEGIN
        IF rst = '1' THEN
            green_led <= '0';
            red_led <= '0';
            heater <= '0';
            state <= IDLE;
        ELSIF rising_edge(clk) THEN
            CASE state IS
                WHEN IDLE =>
                    green_led <= '0';
                    red_led <= '0';
                    heater <= '0';
                    IF sw = '1' THEN
                        state <= HEATING;
                    END IF;
                WHEN HEATING =>
                    red_led <= '1';
                    heater <= '1';
                    IF temp = '1' THEN
                        state <= READY;
                    ELSIF sw = '0' THEN
                        state <= IDLE;
                    END IF;
                WHEN READY =>
                    green_led <= '1';
                    red_led <= '0';
                    heater <= '0';
                    IF sw = '0' THEN
                        state <= IDLE;
                    END IF;
                WHEN OTHERS => state <= IDLE;
            END CASE;
        END IF;
    END PROCESS process_HeaterFsm;
END ARCHITECTURE rtl;