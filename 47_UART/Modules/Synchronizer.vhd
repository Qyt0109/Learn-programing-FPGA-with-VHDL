LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Synchronizer IS
    GENERIC (
        IDLE_STATE : STD_LOGIC
    );
    PORT (
        -- inputs
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        async_pin : IN STD_LOGIC;
        -- outputs
        sync_pin : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE rtl OF Synchronizer IS
    SIGNAL shift_register : STD_LOGIC_VECTOR(1 DOWNTO 0);
BEGIN
    sync_pin <= shift_register(1);
    processSynchronize : PROCESS (rst, clk)
    BEGIN
        IF rst THEN
            shift_register <= (OTHERS => IDLE_STATE);
        ELSIF rising_edge(clk) THEN
            shift_register(0) <= async_pin;
            shift_register(1) <= shift_register(0);
        END IF;
    END PROCESS;
END ARCHITECTURE;