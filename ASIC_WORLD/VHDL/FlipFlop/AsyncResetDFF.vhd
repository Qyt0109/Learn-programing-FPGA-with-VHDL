LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY AsyncResetDFF IS
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

ARCHITECTURE rtl OF AsyncResetDFF IS

BEGIN
    PROCESS (clk, rst) BEGIN
        -- High active reset
        IF rst = '1' THEN
            q <= '0';
            q_not <= '1';
        -- Rising Edge clock trigger
        ELSIF rising_edge(clk) THEN
            q <= d;
            q_not <= NOT d;
        END IF;
    END PROCESS;
END ARCHITECTURE;