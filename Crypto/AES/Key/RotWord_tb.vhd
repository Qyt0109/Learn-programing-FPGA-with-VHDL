LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY RotWord_tb IS
END ENTITY;

ARCHITECTURE rtl OF RotWord_tb IS
    COMPONENT RotWord IS
        PORT (
            input_word : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            output_word : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;
    signal input_word, output_word : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
    RotWord_inst : RotWord
    PORT MAP(
        input_word => input_word,
        output_word => output_word
    );
    processTest : PROCESS
    BEGIN
    -- output_word should be BBCCDDAA
    input_word <= x"AABBCCDD";
    wait;
    END PROCESS;
END ARCHITECTURE;