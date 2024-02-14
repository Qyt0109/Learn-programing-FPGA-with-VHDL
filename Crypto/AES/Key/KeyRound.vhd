LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.pkg_rcon.type_round_rcons;

ENTITY KeyRound IS
    PORT (
        input_round_key : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        round_rcon : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        output_round_key : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF KeyRound IS
    COMPONENT RotWord IS
        PORT (
            input_word : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            output_word : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;
    COMPONENT SubWord IS
        PORT (
            input_word : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            output_word : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;
    TYPE words IS ARRAY(0 TO 3) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL input_round_key_words, output_round_key_words : words;
    SIGNAL rot_word, sub_word : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
    generateRoundKeyWords : FOR word_index IN 0 TO 3 GENERATE
        input_round_key_words(word_index) <= input_round_key((word_index + 1) * 32 - 1 DOWNTO word_index * 32);
    END GENERATE;
    RotWord_inst : RotWord
    PORT MAP(
        input_word => input_round_key_words(3),
        output_word => rot_word
    );
    SubWord_inst : SubWord
    PORT MAP(
        input_word => rot_word,
        output_word => sub_word
    );
    output_round_key_words(0) <= sub_word XOR input_round_key_words(0) XOR round_rcon;
    output_round_key_words(1) <= input_round_key_words(1) XOR output_round_key_words(0);
    output_round_key_words(2) <= input_round_key_words(2) XOR output_round_key_words(1);
    output_round_key_words(3) <= input_round_key_words(3) XOR output_round_key_words(2);
    output_round_key <= output_round_key_words(3) & output_round_key_words(2) & output_round_key_words(1) & output_round_key_words(0);
END ARCHITECTURE;