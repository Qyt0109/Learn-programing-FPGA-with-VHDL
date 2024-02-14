LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY GF2MultiplyBy3_tb IS
END ENTITY;

ARCHITECTURE rtl OF GF2MultiplyBy3_tb IS
    COMPONENT GF2MultiplyBy3 IS
        PORT (
            input_byte : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            output_byte : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL input_byte, output_byte : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
    GF2MultiplyBy3_inst : GF2MultiplyBy3
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