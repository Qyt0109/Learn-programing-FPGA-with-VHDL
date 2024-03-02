LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.aes_data_types.column_cells;

ENTITY InvComputeColumn IS
    PORT (
        input_column : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        output_column : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY;
-- 0xe = 14 = 8 + 2 + 2 + 2
-- 0xb = 11 = 8 + 2 + 1
-- 0xd = 13 = 8 + 2 + 2 + 1
-- 0x9 = 09 = 8 + 1

-- e b d 9
-- 9 e b d
-- d 9 e b
-- b d 9 e

ARCHITECTURE rtl OF InvComputeColumn IS
    TYPE column_cells_mul IS ARRAY(1 TO 5) OF column_cells; -- cell_x1 | cell_x2 | cell_x9 | cell_x11 = cell_x9 xor cell_x2 | cell_x13 = cell_x11 xor cell_x2 | cell_x14 = cell_x13 xor cell_x2
    SIGNAL cells_mul : column_cells_mul;
    SIGNAL cells_out : column_cells;
BEGIN
    generateCellMuls : FOR cell_index IN 0 TO 3 GENERATE
        cells_mul(1)(3 - cell_index) <= input_column((cell_index + 1) * 8 - 1 DOWNTO cell_index * 8);
        GF2MultiplyBy2_inst : ENTITY work.GF2MultiplyBy2
            PORT MAP(
                input_byte => cells_mul(1)(cell_index), -- cell_x1
                output_byte => cells_mul(2)(cell_index) -- cell_x2
            );
        GF2MultiplyBy8_inst : ENTITY work.GF2MultiplyBy8
            PORT MAP(
                input_byte => cells_mul(1)(cell_index), -- cell_x1
                output_byte => cells_mul(3)(cell_index) xor cells_mul(1) -- cell_x8 xor cell_x1 = cell_x9
            );
            
        output_column((cell_index + 1) * 8 - 1 DOWNTO cell_index * 8) <= cells_out(3 - cell_index);
    END GENERATE;
END ARCHITECTURE;