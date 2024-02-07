LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
-- Remove the unnecessary math_real library

ENTITY LedShiftRegister IS
    GENERIC (
        NUMBER_OF_SHIFT_REGISTER : INTEGER := 4
    );
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        sw : IN STD_LOGIC; -- Low active
        led : OUT STD_LOGIC_VECTOR(NUMBER_OF_SHIFT_REGISTER - 1 DOWNTO 0)
    );
END ENTITY LedShiftRegister;

ARCHITECTURE rtl OF LedShiftRegister IS
    SIGNAL shift_register : STD_LOGIC_VECTOR(NUMBER_OF_SHIFT_REGISTER - 1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL button_pressed : STD_LOGIC;
    SIGNAL sync : STD_LOGIC_VECTOR(1 DOWNTO 0); -- 2 clock circle of delay
    SIGNAL delayed_sw : STD_LOGIC;
BEGIN
    process_LedShiftRegister : PROCESS (clk, rst)
    BEGIN
        IF rst = '0' THEN
            shift_register <= '1' & (NUMBER_OF_SHIFT_REGISTER - 1 DOWNTO 1 => '0');
        ELSIF rising_edge(clk) THEN
            IF button_pressed = '0' THEN
                -- Shift the register to the left in a circle
                shift_register <= shift_register(shift_register'LEFT - 1 DOWNTO 0) & shift_register(shift_register'LEFT);
            END IF;
        END IF;
    END PROCESS process_LedShiftRegister;

    process_Sync : PROCESS (rst, clk)
    BEGIN
        IF rst = '0' THEN
            sync <= "11";
        ELSIF rising_edge(clk) THEN
            sync(0) <= sw;
            sync(1) <= sync(0); -- sync(1) is the synchronized version of sw
        END IF;
    END PROCESS process_Sync;

    process_ButtonPressed : PROCESS (rst, clk)
    BEGIN
        IF rst = '0' THEN
            delayed_sw <= '1';
        ELSIF rising_edge(clk) THEN
            delayed_sw <= sync(1);
            IF sync(1) = '0' AND delayed_sw = '1' THEN
                button_pressed <= '1';
            ELSE
                button_pressed <= '0';
            END IF;
        END IF;
    END PROCESS process_ButtonPressed;
    led <= shift_register;
END ARCHITECTURE rtl;