LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY SubWord_tb IS
END ENTITY;

ARCHITECTURE rtl OF SubWord_tb IS
    COMPONENT SubWord IS
        PORT (
            input_word : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            output_word : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL input_word, output_word : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
    SubWord_inst : SubWord
    PORT MAP(
        input_word => input_word,
        output_word => output_word
    );

    processTest : process
    begin
        -- output_word should be 6377f26f
        input_word <= x"00020406";
        wait;
    end process;
END ARCHITECTURE;