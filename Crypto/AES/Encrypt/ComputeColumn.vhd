LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.aes_data_types.column_cells;

ENTITY ComputeColumn IS
    PORT (
        input_column : IN std_logic_vector(31 downto 0);
        output_column : OUT std_logic_vector(31 downto 0)
    );
END ENTITY;

ARCHITECTURE rtl OF ComputeColumn IS
    TYPE column_cells_mul IS ARRAY(1 TO 3) OF column_cells; -- cell_x1 | cell_x2 | cell_x3
    SIGNAL cells_mul : column_cells_mul;
    SIGNAL cells_out : column_cells;
BEGIN
    generateCellsMul2Mul3 : FOR cell_index IN 0 TO 3 GENERATE
        cells_mul(1)(3 - cell_index) <= input_column((cell_index + 1) * 8 - 1 downto cell_index * 8);
        GF2MultiplyBy2_inst : ENTITY work.GF2MultiplyBy2
            PORT MAP(
                input_byte => cells_mul(1)(cell_index),
                output_byte => cells_mul(2)(cell_index)
            );
        GF2MultiplyBy3_inst : ENTITY work.GF2MultiplyBy3
            PORT MAP(
                input_byte => cells_mul(1)(cell_index),
                output_byte => cells_mul(3)(cell_index)
            );
        output_column((cell_index + 1) * 8 - 1 downto cell_index * 8) <= cells_out(3 - cell_index);
    END GENERATE;
    cells_out(0) <= cells_mul(2)(0) XOR cells_mul(3)(1) XOR cells_mul(1)(2) XOR cells_mul(1)(3);
    cells_out(1) <= cells_mul(1)(0) XOR cells_mul(2)(1) XOR cells_mul(3)(2) XOR cells_mul(1)(3);
    cells_out(2) <= cells_mul(1)(0) XOR cells_mul(1)(1) XOR cells_mul(2)(2) XOR cells_mul(3)(3);
    cells_out(3) <= cells_mul(3)(0) XOR cells_mul(1)(1) XOR cells_mul(1)(2) XOR cells_mul(2)(3);
END ARCHITECTURE;