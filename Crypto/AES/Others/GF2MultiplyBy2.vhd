-- Multiplication of the values as written in the book "Cryptography and Network Security",
-- that multiplication of a value by x (ie. by 02) can be implemented as a 1-bit left shift
-- followed by a conditional bitwise XOR with (0001 1011) if the leftmost bit of the original
-- value (before the shift) is 1. We can implement this rule in our calculation.

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY GF2MultiplyBy2 IS
    PORT (
        input_byte : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        output_byte : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF GF2MultiplyBy2 IS
    SIGNAL shifted_byte, conditional_xor : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
    -- Process for the conditional XOR
    PROCESS (input_byte)
    BEGIN
        -- Left shift the input byte
        shifted_byte <= input_byte(input_byte'left - 1 DOWNTO 0) & '0';

        -- Conditional XOR with the constant value if MSB of input_byte is 1
        IF input_byte(7) = '1' THEN
            conditional_xor <= "00011011"; -- Constant value for conditional XOR
        ELSE
            conditional_xor <= "00000000"; -- Constant value for conditional XOR
        END IF;
    END PROCESS;
    -- Output is the result of XOR operation
    output_byte <= shifted_byte XOR conditional_xor;
END ARCHITECTURE;