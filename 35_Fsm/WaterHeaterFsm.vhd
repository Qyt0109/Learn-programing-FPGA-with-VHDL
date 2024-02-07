LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

ENTITY WaterHeaterFsm IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        sw : IN STD_LOGIC; -- On/Off switch, goes high when the water heater is switched on.
        thermostat : IN STD_LOGIC; -- Thermostat, goes high when the water temperature at or above the set point.
        indicator : IN STD_LOGIC; -- Goes high when the water level is too low. This is there to protect the heating element from over-heating.
        heater : OUT STD_LOGIC; -- Goes high to power the heating element.
        ready_led : OUT STD_LOGIC; -- Illuminates when the water temperature has reached the set-point.
        error_led : OUT STD_LOGIC -- Illuminates when the water level is too low.
    );
END ENTITY WaterHeaterFsm;

ARCHITECTURE rtl OF WaterHeaterFsm IS
    TYPE enum_WaterHeaterFsmState IS (IDLE, HEATING, READY, ERROR);
    SIGNAL state : enum_WaterHeaterFsmState;
BEGIN
    process_HeaterFsm : PROCESS (rst, clk)
    BEGIN
        IF rst = '1' THEN
            heater <= '0';
            ready_led <= '0';
            error_led <= '0';
            state <= IDLE;
        ELSIF rising_edge(clk) THEN
            CASE state IS
                WHEN IDLE =>
                    heater <= '0';
                    ready_led <= '0';
                    error_led <= '0';
                    IF sw = '1' THEN
                        state <= HEATING;
                    END IF;
                WHEN HEATING =>
                    heater <= '1';
                    ready_led <= '0';
                    IF thermostat = '1' THEN
                        state <= READY;
                    ELSIF sw = '0' THEN
                        state <= IDLE;
                    ELSIF indicator = '1' THEN
                        state <= ERROR;
                    END IF;
                WHEN READY =>
                    heater <= '0';
                    ready_led <= '1';
                    IF sw = '0' THEN
                        state <= IDLE;
                    END IF;
                WHEN ERROR =>
                    heater <= '0';
                    error_led <= '1';
                    IF sw = '0' then
                        state <= IDLE;
                    elsif indicator = '0' THEN
                        state <= HEATING;
                    END IF;

                WHEN OTHERS => state <= IDLE;
            END CASE;
        END IF;
    END PROCESS process_HeaterFsm;
END ARCHITECTURE rtl;