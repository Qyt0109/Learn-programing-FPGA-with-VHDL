LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ShiftRows IS
    PORT (
        input_state : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        output_state : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF ShiftRows IS
BEGIN
    processShiftRows : PROCESS (input_state)
        VARIABLE current_state : STD_LOGIC_VECTOR(127 DOWNTO 0);
        VARIABLE shifted_state : STD_LOGIC_VECTOR(127 DOWNTO 0);
    BEGIN
        current_state := input_state;
        FOR row_index IN 0 TO 3 LOOP
            FOR column_index IN 0 TO 3 LOOP
                shifted_state(row_index * 32 + column_index * 8 + 7 DOWNTO row_index * 32 + column_index * 8) := current_state(row_index * 32 + ((column_index + row_index) MOD 4) * 8 + 7 DOWNTO row_index * 32 + ((column_index + row_index) MOD 4) * 8);
            END LOOP;
        END LOOP;
        output_state <= shifted_state;
    END PROCESS;
END ARCHITECTURE;