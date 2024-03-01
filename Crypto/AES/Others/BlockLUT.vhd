LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.aes_data_types.block_vector;

ENTITY BlockLUT IS
    GENERIC (
        MIN_BLOCK_INDEX : NATURAL;
        MAX_BLOCK_INDEX : POSITIVE
    );
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        input_blocks : IN block_vector(MIN_BLOCK_INDEX TO MAX_BLOCK_INDEX);
        index : IN NATURAL RANGE MIN_BLOCK_INDEX TO MAX_BLOCK_INDEX;
        output_block : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
END ENTITY BlockLUT;

ARCHITECTURE rtl OF BlockLUT IS
    SIGNAL data_blocks : block_vector(MIN_BLOCK_INDEX TO MAX_BLOCK_INDEX);
BEGIN
    output_block <= data_blocks(index);
    processSelectData : PROCESS (rst, clk)
    BEGIN
        IF rst = '1' THEN
            data_blocks <= (OTHERS => (OTHERS => '0'));
        ELSIF rising_edge(clk) THEN
            data_blocks <= input_blocks;
        END IF;
    END PROCESS;
END ARCHITECTURE;