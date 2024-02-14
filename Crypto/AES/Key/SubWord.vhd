-- SubWord takes a 4-byte word ABCD and returns Sbox output of each ABCD byte

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY SubWord IS
    PORT (
        input_word : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        output_word : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF SubWord IS
    COMPONENT SBox IS
        PORT (
            input_byte : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            output_byte : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;
BEGIN
    generateSBoxes : FOR byte_index IN 0 TO 3 GENERATE
        SBox_inst : SBox
        PORT MAP(
            input_byte => input_word((byte_index + 1) * 8 - 1 DOWNTO byte_index * 8),
            output_byte => output_word((byte_index + 1) * 8 - 1 DOWNTO byte_index * 8)
        );
    END GENERATE;
END ARCHITECTURE;