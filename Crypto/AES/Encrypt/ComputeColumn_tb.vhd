LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.aes_data_types.column_cells;

ENTITY ComputeColumn_tb IS
END ENTITY;

ARCHITECTURE rtl OF ComputeColumn_tb IS
    SIGNAL input_column, output_column : std_logic_vector(31 downto 0);
BEGIN
    ComputeColumn_inst : entity work.ComputeColumn
    PORT MAP(
        input_column => input_column,
        output_column => output_column
    );
    processTest : PROCESS
    begin
        -- input_column 632fafa2, output_column should be ba75f47a
        input_column <= x"632fafa2";
        wait for 5 ns;
        -- input_column 7563c5c0, output_column should be 4a27dca2
        input_column <= x"7563c5c0";
        wait;
    END PROCESS;
END ARCHITECTURE;