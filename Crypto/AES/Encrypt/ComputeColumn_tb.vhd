LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.aes_data_types.column_cells;

ENTITY ComputeColumn_tb IS
END ENTITY;

ARCHITECTURE rtl OF ComputeColumn_tb IS
    SIGNAL input_column, output_column : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
    ComputeColumn_inst : ENTITY work.ComputeColumn
        PORT MAP(
            input_column => input_column,
            output_column => output_column
        );
    processTest : PROCESS
    BEGIN
        -- input_column 632fafa2, output_column should be ba75f47a
        input_column <= x"632fafa2";
        WAIT FOR 5 ns;
        -- input_column 7563c5c0, output_column should be 4a27dca2
        input_column <= x"7563c5c0";
        WAIT;
    END PROCESS;
END ARCHITECTURE;