-- RotWord is quite simple. It takes a 4-byte word byte3 byte2 byte1 byte0 and returns byte2 byte1 byte0 byte3

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY RotWord IS
    PORT (
        input_word : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        output_word : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY;

architecture rtl of RotWord is
begin
    output_word <= input_word(23 downto 0) & input_word(31 downto 24);
end architecture;