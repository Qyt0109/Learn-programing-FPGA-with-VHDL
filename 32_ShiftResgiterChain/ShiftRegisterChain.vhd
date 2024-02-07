LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

ENTITY ShiftRegisterChain IS
    GENERIC (
        CHAIN_LENGTH : INTEGER := 8
    );
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        en : IN STD_LOGIC;
        i : IN STD_LOGIC;
        o : INOUT STD_LOGIC_VECTOR(CHAIN_LENGTH - 1 DOWNTO 0)
    );
END ENTITY ShiftRegisterChain;

ARCHITECTURE rtl OF ShiftRegisterChain IS

BEGIN
    process_ShiftRegisterChain : PROCESS (rst, clk)
    BEGIN
        IF rst = '1' THEN
            o <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            IF en = '1' THEN
                o <= i & o(o'left DOWNTO 1);
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE rtl;