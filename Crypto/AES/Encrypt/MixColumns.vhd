LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MixColumns IS
    PORT (
        input_state : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        output_state : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF MixColumns IS
    COMPONENT ComputeColumn IS
        PORT (
            input_column : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            output_column : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;

    type column_cells is array(0 to 3) of std_logic_vector(7 downto 0);
    type columns is array(0 to 3) of column_cells;
    SIGNAL input_column : columns;
    SIGNAL output_column : columns;

BEGIN
    -- Generate input and output cells
    generateColumns : FOR row_index IN 0 TO 3 GENERATE
        generateColumnCells : FOR column_index IN 0 TO 3 GENERATE
            
        END GENERATE;
    END GENERATE;

    -- Instantiate and connect ComputeColumn components
    generateComputeColumns : FOR column_index IN 0 TO 3 GENERATE
        ComputeColumn_inst : ComputeColumn
        PORT MAP(
            input_column => (input_cells(column_index * 4), input_cells(column_index * 4 + 1), input_cells(column_index * 4 + 2), input_cells(column_index * 4 + 3)),
            output_column => (output_cells(column_index * 4), output_cells(column_index * 4 + 1), output_cells(column_index * 4 + 2), output_cells(column_index * 4 + 3))
        );
    END GENERATE;
END ARCHITECTURE;