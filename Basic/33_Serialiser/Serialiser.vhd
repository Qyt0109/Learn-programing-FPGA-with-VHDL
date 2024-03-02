LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

ENTITY Serialiser IS
    GENERIC (
        DATA_WIDTH : INTEGER := 8
    );
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        en : IN STD_LOGIC;
        load : IN STD_LOGIC;
        i : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        o : OUT STD_LOGIC
    );
END ENTITY Serialiser;

ARCHITECTURE rtl OF Serialiser IS
    SIGNAL data_register : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
BEGIN
    process_Serialiser : PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            data_register <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            IF load = '1' THEN
                data_register <= i;
            ELSIF en = '1' THEN
                data_register <= '0' & data_register(DATA_WIDTH - 1 DOWNTO 1);
            END IF;
        END IF;
    END PROCESS;
    o <= data_register(0);
END ARCHITECTURE rtl;