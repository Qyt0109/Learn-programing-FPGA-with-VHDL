LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY GF2MultiplyBy3_tb IS
END ENTITY;

ARCHITECTURE rtl OF GF2MultiplyBy3_tb IS
    SIGNAL input_byte, output_byte : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
    GF2MultiplyBy3_inst : entity work.GF2MultiplyBy3
    PORT MAP(
        input_byte => input_byte,
        output_byte => output_byte
    );
    processTest : PROCESS
    BEGIN
        -- output_byte should be 11011010
        input_byte <= "10111111";
        WAIT;
    END PROCESS;
END ARCHITECTURE;