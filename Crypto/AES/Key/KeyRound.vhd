LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.aes_data_types.word_vector;

ENTITY KeyRound IS
    PORT (
        clk : STD_LOGIC;
        input_round_key : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        round_rcon : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        output_round_key : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF KeyRound IS
    SIGNAL input_round_key_words, output_round_key_words : word_vector(0 TO 3);
    SIGNAL rot_word, sub_word, round_rcon_signal : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
    processGenKey : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            loopRoundKeyWords : FOR word_index IN 0 TO 3 LOOP
                input_round_key_words(3 - word_index) <= input_round_key((word_index + 1) * 32 - 1 DOWNTO word_index * 32);
            END LOOP;
            round_rcon_signal <= round_rcon;
        END IF;
    END PROCESS;
    RotWord_inst : ENTITY work.RotWord
        PORT MAP(
            input_word => input_round_key_words(3),
            output_word => rot_word
        );
    SubWord_inst : ENTITY work.SubWord
        PORT MAP(
            input_word => rot_word,
            output_word => sub_word
        );
    output_round_key_words(0) <= sub_word XOR input_round_key_words(0) XOR round_rcon_signal;
    output_round_key_words(1) <= input_round_key_words(1) XOR output_round_key_words(0);
    output_round_key_words(2) <= input_round_key_words(2) XOR output_round_key_words(1);
    output_round_key_words(3) <= input_round_key_words(3) XOR output_round_key_words(2);
    output_round_key <= output_round_key_words(0) & output_round_key_words(1) & output_round_key_words(2) & output_round_key_words(3);
END ARCHITECTURE;