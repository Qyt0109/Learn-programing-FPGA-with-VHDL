LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

ENTITY SinglePortRam IS
    GENERIC (
        DATA_WIDTH : INTEGER := 8;
        ADDRESS_WIDTH : INTEGER := 20
    );
    PORT (
        clk : IN STD_LOGIC;
        w_data : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        r_data : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        address : IN STD_LOGIC_VECTOR(ADDRESS_WIDTH - 1 DOWNTO 0);
        w_en : IN STD_LOGIC
    );
END ENTITY SinglePortRam;

ARCHITECTURE rtl OF SinglePortRam IS
    -- Custeom 2D Array data type for RAM
    TYPE ram_array IS ARRAY(0 TO 2 ** ADDRESS_WIDTH - 1) OF STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL s_ram : ram_array;
BEGIN
    process_SinglePortRam : PROCESS (clk) BEGIN
        IF rising_edge(clk) THEN
            IF w_en = '1' THEN
                s_ram(to_integer(unsigned(address))) <= w_data;
            END IF;
            r_data <= s_ram(to_integer(unsigned(address)));
        END IF;
    END PROCESS;

END ARCHITECTURE rtl;