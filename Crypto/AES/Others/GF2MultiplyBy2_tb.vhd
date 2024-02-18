LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY GF2MultiplyBy2_tb IS
END ENTITY;

ARCHITECTURE rtl OF GF2MultiplyBy2_tb IS
    SIGNAL input_byte, output_byte : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
    GF2MultiplyBy2_inst : ENTITY work.GF2MultiplyBy2
        PORT MAP(
            input_byte => input_byte,
            output_byte => output_byte
        );
    processTest : PROCESS
    BEGIN
        -- output_byte should be 10110011
        input_byte <= "11010100";
        WAIT;
    END PROCESS;
END ARCHITECTURE;