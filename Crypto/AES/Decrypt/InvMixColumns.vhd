LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY InvMixColumns IS
    PORT (
        input_state : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        output_state : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF InvMixColumns IS
BEGIN
    -- Instantiate and connect InvComputeColumn components
    generateInvComputeColumns : FOR column_index IN 0 TO 3 GENERATE
        InvComputeColumn_inst : ENTITY work.InvComputeColumn
            PORT MAP(
                input_column => input_state((column_index + 1) * 32 - 1 DOWNTO column_index * 32),
                output_column => output_state((column_index + 1) * 32 - 1 DOWNTO column_index * 32)
            );
    END GENERATE;
END ARCHITECTURE;