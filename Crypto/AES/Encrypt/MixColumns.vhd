LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MixColumns IS
    PORT (
        input_state : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        output_state : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF MixColumns IS
BEGIN
    -- Instantiate and connect ComputeColumn components
    generateComputeColumns : FOR column_index IN 0 TO 3 GENERATE
        ComputeColumn_inst : ENTITY work.ComputeColumn
            PORT MAP(
                input_column => input_state((column_index + 1) * 32 - 1 DOWNTO column_index * 32),
                output_column => output_state((column_index + 1) * 32 - 1 DOWNTO column_index * 32)
            );
    END GENERATE;
END ARCHITECTURE;