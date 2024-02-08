LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Serialiser IS
    GENERIC (
        DATA_WIDTH : INTEGER;
        DEFAULT_STATE : STD_LOGIC
    );
    PORT (
        -- inputs
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        shift_en : IN STD_LOGIC;
        load : IN STD_LOGIC;
        data_in : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        -- outputs
        data_out : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE rtl OF Serialiser IS
    SIGNAL shift_register : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
BEGIN
    data_out <= shift_register(0);
    processSerialiser : PROCESS (rst, clk)
    BEGIN
        IF rst = '1' THEN
            shift_register <= (OTHERS => DEFAULT_STATE);
        ELSIF rising_edge(clk) THEN
            IF load = '1' THEN
                shift_register <= data_in;
            ELSIF shift_en = '1' THEN
                shift_register <= DEFAULT_STATE & shift_register(shift_register'left DOWNTO 1);
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;
