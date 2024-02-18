LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.aes_data_types.block_vector;

ENTITY BlockRegister IS
    GENERIC (
        MIN_BLOCK_INDEX : NATURAL;
        MAX_BLOCK_INDEX : POSITIVE
    );
    PORT (
        clk, rst, shift : IN STD_LOGIC;
        input_block : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        output_blocks : OUT block_vector(MIN_BLOCK_INDEX TO MAX_BLOCK_INDEX)
    );
END ENTITY BlockRegister;

ARCHITECTURE rtl OF BlockRegister IS
    SIGNAL internal_block_registers : block_vector(MIN_BLOCK_INDEX TO MAX_BLOCK_INDEX);
BEGIN
    PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            -- Reset the register
            internal_block_registers <= (OTHERS => (OTHERS => '0'));
        ELSIF rising_edge(clk) THEN
            -- Shift the data if shift_enable is '1'
            IF shift = '1' THEN
                -- Shift right
                FOR i IN MAX_BLOCK_INDEX DOWNTO MIN_BLOCK_INDEX + 1 LOOP
                    internal_block_registers(i) <= internal_block_registers(i - 1);
                END LOOP;
                internal_block_registers(MIN_BLOCK_INDEX) <= input_block;
            END IF;
        END IF;
    END PROCESS;
    output_blocks <= internal_block_registers;
END ARCHITECTURE rtl;