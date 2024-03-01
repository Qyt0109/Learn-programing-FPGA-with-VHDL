LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.aes_data_types.block_vector;

ENTITY BlockRegister IS
    GENERIC (
        MIN_BLOCK_INDEX : NATURAL;
        MAX_BLOCK_INDEX : POSITIVE
    );
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        shift_enable : IN STD_LOGIC;
        input_block_data : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        output_data_blocks : OUT block_vector(MIN_BLOCK_INDEX TO MAX_BLOCK_INDEX)
    );
END ENTITY BlockRegister;

ARCHITECTURE rtl OF BlockRegister IS
    SIGNAL data_blocks : block_vector(MIN_BLOCK_INDEX TO MAX_BLOCK_INDEX);
BEGIN
    processStoreData : PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            -- Reset the register
            data_blocks <= (OTHERS => (OTHERS => '0'));
        ELSIF rising_edge(clk) THEN
            -- Shift the data if shift_enable is '1'
            IF shift_enable = '1' THEN
                data_blocks(MIN_BLOCK_INDEX TO MAX_BLOCK_INDEX - 1) <= data_blocks(MIN_BLOCK_INDEX + 1 TO MAX_BLOCK_INDEX);
                data_blocks(MAX_BLOCK_INDEX) <= input_block_data;
            END IF;
        END IF;
    END PROCESS;
    output_data_blocks <= data_blocks;
END ARCHITECTURE rtl;