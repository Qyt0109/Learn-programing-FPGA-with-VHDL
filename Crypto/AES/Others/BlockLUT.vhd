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
        input_data_blocks : IN block_vector(MIN_BLOCK_INDEX TO MAX_BLOCK_INDEX);
        block_index : IN NATURAL;
        output_data_block : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
END ENTITY BlockLUT;

ARCHITECTURE rtl OF BlockLUT IS

BEGIN
    processSelectData : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            output_data_block <= input_data_blocks(block_index);
        END IF;
    END PROCESS;
END ARCHITECTURE;