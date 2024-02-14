LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ComputeColumn IS
    PORT (
        input_column : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        output_column : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF ComputeColumn IS
    COMPONENT GF2MultiplyBy2 IS
        PORT (
            input_byte : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            output_byte : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;
    COMPONENT GF2MultiplyBy3 IS
        PORT (
            input_byte : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            output_byte : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;
    TYPE column_cells IS ARRAY(0 TO 3) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    TYPE column_cells_mul IS ARRAY(1 TO 3) OF column_cells;
    SIGNAL cells_mul : column_cells_mul;
    signal cells_out : column_cells;
BEGIN
    generateCellsMul2Mul3 : FOR cell_index IN 0 TO 3 GENERATE
        cells_mul(1)(cell_index) <= input_column((cell_index + 1) * 8 - 1 DOWNTO cell_index * 8);
        GF2MultiplyBy2_inst : GF2MultiplyBy2
        PORT MAP(
            input_byte => cells_mul(1)(cell_index),
            output_byte => cells_mul(2)(cell_index)
        );
        GF2MultiplyBy3_inst : GF2MultiplyBy3
        PORT MAP(
            input_byte => cells_mul(1)(cell_index),
            output_byte => cells_mul(3)(cell_index)
        );
        output_column((cell_index + 1) * 8 - 1 downto cell_index * 8) <= cells_out(cell_index);
    END GENERATE;
    cells_out(0) <= cells_mul(2)(0) XOR cells_mul(3)(1) xor cells_mul(1)(2) xor cells_mul(1)(3);
    cells_out(1) <= cells_mul(1)(0) XOR cells_mul(2)(1) xor cells_mul(3)(2) xor cells_mul(1)(3);
    cells_out(2) <= cells_mul(1)(0) XOR cells_mul(1)(1) xor cells_mul(2)(2) xor cells_mul(3)(3);
    cells_out(3) <= cells_mul(3)(0) XOR cells_mul(1)(1) xor cells_mul(1)(2) xor cells_mul(2)(3);
END ARCHITECTURE;