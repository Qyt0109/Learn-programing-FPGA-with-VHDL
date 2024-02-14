-- Multiplication of the values as written in the book "Cryptography and Network Security",
-- that multiplication of a value by x (ie. by 02) can be implemented as a 1-bit left shift
-- followed by a conditional bitwise XOR with (0001 1011) if the leftmost bit of the original
-- value (before the shift) is 1. We can implement this rule in our calculation.

--  We split 03 up in its binary form. 03 = 11 = 10 + 01.
-- So instead of mul by 03, we can do as following:
-- A.{03} = A.(10 + 01) = (A.10) + (A.01) = A.{02} + A

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY GF2MultiplyBy3 IS
    PORT (
        input_byte : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        output_byte : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF GF2MultiplyBy3 IS
    COMPONENT GF2MultiplyBy2 IS
        PORT (
            input_byte : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            output_byte : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL input_byte_mul2 : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
    GF2MultiplyBy2_inst : GF2MultiplyBy2
    PORT MAP(
        input_byte => input_byte,
        output_byte => input_byte_mul2
    );
    output_byte <= input_byte_mul2 XOR input_byte;
END ARCHITECTURE;