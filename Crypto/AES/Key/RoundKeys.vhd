LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.aes_data_types.all;

ENTITY RoundKeys IS
    PORT (
        key : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        round_keys : OUT block_vector(0 to 10)
    );
END ENTITY;

ARCHITECTURE rtl OF RoundKeys IS
    SIGNAL signal_round_keys : block_vector(0 to 10);
    SIGNAL round_rcons : word_vector(1 to 10);
BEGIN
    RCons_inst : entity work.RCons
    PORT MAP(
        round_rcons => round_rcons
    );
    round_keys <= signal_round_keys;
    signal_round_keys(0) <= key; -- Init first round key as key
    -- For each round, previous round key is input to compute the next round key
    generateRoundKeys : FOR round_index IN 1 TO 10 GENERATE
        KeyRound_inst : entity work.KeyRound
        PORT MAP(
            input_round_key => signal_round_keys(round_index - 1),
            round_rcon => round_rcons(round_index),
            output_round_key => signal_round_keys(round_index)
        );
    END GENERATE;
END ARCHITECTURE;