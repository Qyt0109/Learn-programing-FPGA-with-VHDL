LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE pkg_round_keys IS
    TYPE type_round_keys IS ARRAY(0 TO 10) OF STD_LOGIC_VECTOR(127 DOWNTO 0);
END PACKAGE;

USE work.pkg_round_keys.type_round_keys;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.pkg_rcon.type_round_rcons;

ENTITY RoundKeys IS
    PORT (
        key : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        round_keys : type_round_keys
    );
END ENTITY;

ARCHITECTURE rtl OF RoundKeys IS
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
    COMPONENT RCons IS
        PORT (
            round_rcons : OUT type_round_rcons
        );
    END COMPONENT;
    type word_bytes is array(0 to 3) of std_logic_vector(7 downto 0);
    TYPE key_words IS ARRAY(0 TO 4) OF word_bytes;
    -- connection_words's index:
    -- * 0 is 
    -- * 1 is output of RotWord,
    -- * 2 is output of SubWord,
    -- * 3 is output of AddRcon
    TYPE connection_words IS ARRAY(0 TO 2) OF key_words;
    SIGNAL word_signals : connection_words;
    SIGNAL round_rcons : type_round_rcons;
BEGIN
    generateWordBytes : for word_byte_index in 0 to 3 generate

    end generate;
    round_keys(0) <= input_word;
    generateRoundKeys : FOR round_index IN 1 TO 10 GENERATE

    END GENERATE;
END ARCHITECTURE;