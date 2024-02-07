LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ShiftRegister IS
    GENERIC (
        DATA_BITS : INTEGER;
        IS_RIGHT_SHIFT : BOOLEAN -- True if shift to the right
    );
    PORT (
        -- inputs
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        shift_en : IN STD_LOGIC;
        data_in : IN STD_LOGIC;
        -- outputs
        data_out : OUT STD_LOGIC_VECTOR(DATA_BITS - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF ShiftRegister IS
    SIGNAL shift_register : STD_LOGIC_VECTOR(DATA_BITS - 1 DOWNTO 0);
BEGIN
    data_out <= shift_register;
    RIGHT_SHIFT_CASE : IF IS_RIGHT_SHIFT GENERATE
        processShift : PROCESS (rst, clk)
        BEGIN
            IF rst = '1' THEN
                shift_register <= (OTHERS => '0');
            ELSIF rising_edge(clk) THEN
                IF shift_en = '1' THEN
                    shift_register <= data_in & shift_register(shift_register'left DOWNTO 1);
                END IF;
            END IF;
        END PROCESS;
    END GENERATE;
    LEFT_SHIFT_CASE : IF NOT IS_RIGHT_SHIFT GENERATE
        processShift : PROCESS (rst, clk)
        BEGIN
            IF rst = '1' THEN
                shift_register <= (OTHERS => '0');
            ELSIF rising_edge(clk) THEN
                IF shift_en = '1' THEN
                    shift_register <= shift_register(shift_register'left - 1 DOWNTO 0) & data_in;
                END IF;
            END IF;
        END PROCESS;
    END GENERATE;
END ARCHITECTURE;