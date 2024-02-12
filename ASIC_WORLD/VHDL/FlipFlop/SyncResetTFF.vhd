LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY AsyncResetTFF IS
    PORT (
        -- Inputs
        t : IN STD_LOGIC;-- Data input
        clk : IN STD_LOGIC;-- Clock input
        rst : IN STD_LOGIC;-- Reset input
        -- Outputs
        q : OUT STD_LOGIC; -- Q output
        q_not : OUT STD_LOGIC -- Not Q output
    );
END ENTITY;

ARCHITECTURE rtl OF AsyncResetTFF IS
BEGIN
    PROCESS (clk, rst)
        VARIABLE temp : STD_LOGIC;
    BEGIN
        IF rising_edge(clk) THEN
            IF rst = '1' THEN
                temp := '0';
            ELSE
                temp := temp XOR t;
            END IF;
        END IF;
        q <= temp;
        q_not <= NOT temp;
    END PROCESS;
END ARCHITECTURE;