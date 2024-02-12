LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY SyncResetDFF IS
    PORT (
        -- inputs
        clk : IN STD_LOGIC; -- Clock input
        rst : IN STD_LOGIC; -- Reset input
        d : IN STD_LOGIC; -- Data input
        -- outputs
        q : OUT STD_LOGIC; -- Q output
        q_not : OUT STD_LOGIC -- Not Q output
    );
END ENTITY;

ARCHITECTURE rtl OF SyncResetDFF IS

BEGIN
    PROCESS (clk) BEGIN
        IF rising_edge(clk) THEN
            IF rst = '1' THEN
                q <= '0';
                q_not <= '1';
            ELSE
                q <= d;
                q_not <= NOT d;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;