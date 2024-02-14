LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY SubByte IS
    PORT (
        input_state : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        output_state : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF SubByte IS
    -- Components
    COMPONENT SBox IS
        PORT (
            input_byte : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            output_byte : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;
BEGIN
    generateSBoxes : FOR byte_index IN 0 TO 15 GENERATE
        SBox_inst : SBox
        PORT MAP(
            input_byte => input_state((byte_index + 1) * 8 - 1 DOWNTO byte_index * 8),
            output_byte => output_state((byte_index + 1) * 8 - 1 DOWNTO byte_index * 8)
        );
    END GENERATE;
END ARCHITECTURE;