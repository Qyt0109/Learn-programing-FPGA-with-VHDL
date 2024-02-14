LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ComputeColumn_tb IS
END ENTITY;

ARCHITECTURE rtl OF ComputeColumn_tb IS
    COMPONENT ComputeColumn IS
        PORT (
            input_column : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            output_column : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL input_column, output_column : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
    ComputeColumn_inst : ComputeColumn
    PORT MAP(
        input_column => input_column,
        output_column => output_column
    );
    processTest : PROCESS
    begin
        -- output_column should be e5816604
        input_column <= x"305dbfd4";
        wait;
    END PROCESS;
END ARCHITECTURE;