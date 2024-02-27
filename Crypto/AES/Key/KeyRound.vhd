LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.aes_data_types.word_vector;

ENTITY KeyRound IS
    GENERIC (
        MIN_ROUND_INDEX : NATURAL := 0;
        MAX_ROUND_INDEX : POSITIVE := 10
    );
    PORT (
        clk : STD_LOGIC;
        input_round_key : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        round_index : IN INTEGER RANGE MIN_ROUND_INDEX TO MAX_ROUND_INDEX;
        output_round_key : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF KeyRound IS
    SIGNAL input_round_key_words, output_round_key_words : word_vector(0 TO 3);
    SIGNAL rot_word, sub_word, round_rcon_signal : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL round_index_signal : INTEGER;
BEGIN
    processGenKey : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            loopRoundKeyWords : FOR word_index IN 0 TO 3 LOOP
                input_round_key_words(3 - word_index) <= input_round_key((word_index + 1) * 32 - 1 DOWNTO word_index * 32);
            END LOOP;
            round_index_signal <= round_index;
        END IF;
    END PROCESS;
    roundconstant_inst : ENTITY work.RoundConstant
        PORT MAP(
            round_index => round_index_signal,
            round_constant_word => round_rcon_signal
        );
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