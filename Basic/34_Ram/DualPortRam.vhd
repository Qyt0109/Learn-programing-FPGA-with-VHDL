LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

ENTITY DualPortRam IS
    GENERIC (
        DATA_WIDTH : INTEGER := 8;
        ADDRESS_WIDTH : INTEGER := 20
    );
    PORT (
        -- Clock
        clk : IN STD_LOGIC;
        -- Port A
        w_data_a : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        r_data_a : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        address_a : IN STD_LOGIC_VECTOR(ADDRESS_WIDTH - 1 DOWNTO 0);
        w_en_a : IN STD_LOGIC;
        -- Port B
        w_data_b : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        r_data_b : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        address_b : IN STD_LOGIC_VECTOR(ADDRESS_WIDTH - 1 DOWNTO 0);
        w_en_b : IN STD_LOGIC
    );
END ENTITY DualPortRam;

ARCHITECTURE rtl OF DualPortRam IS
    -- Custeom 2D Array data type for RAM
    TYPE ram_array IS ARRAY(0 TO 2 ** ADDRESS_WIDTH - 1) OF STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL s_ram : ram_array;
BEGIN
    process_DualPortRam : PROCESS (clk) BEGIN
        IF rising_edge(clk) THEN
            IF w_en_a = '1' THEN
                s_ram(to_integer(unsigned(address_a))) <= w_data_a;
            END IF;
            r_data_a <= s_ram(to_integer(unsigned(address_a)));
            IF w_en_b = '1' THEN
                s_ram(to_integer(unsigned(address_b))) <= w_data_b;
            END IF;
            r_data_b <= s_ram(to_integer(unsigned(address_b)));
        END IF;
    END PROCESS;

END ARCHITECTURE rtl;