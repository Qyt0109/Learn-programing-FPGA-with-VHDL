LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE pkg_round_keys IS
    TYPE type_round_keys IS ARRAY(0 TO 10) OF STD_LOGIC_VECTOR(127 DOWNTO 0);
END PACKAGE;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.pkg_rcon.type_round_rcons;
USE work.pkg_round_keys.type_round_keys;

ENTITY RoundKeys IS
    PORT (
        key : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        round_keys : OUT type_round_keys
    );
END ENTITY;

ARCHITECTURE rtl OF RoundKeys IS
    COMPONENT KeyRound IS
        PORT (
            input_round_key : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
            round_rcon : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            output_round_key : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
        );
    END COMPONENT;
    COMPONENT RCons IS
        PORT (
            round_rcons : OUT type_round_rcons
        );
    END COMPONENT;
    SIGNAL signal_round_keys : type_round_keys;
    SIGNAL round_rcons : type_round_rcons;
BEGIN
    RCons_inst : RCons
    PORT MAP(
        round_rcons => round_rcons
    );
    round_keys <= signal_round_keys;
    signal_round_keys(0) <= key; -- Init first round key as key
    -- For each round, previous round key is input to compute the next round key
    generateRoundKeys : FOR round_index IN 1 TO 10 GENERATE
        KeyRound_inst : KeyRound
        PORT MAP(
            input_round_key => signal_round_keys(round_index - 1),
            round_rcon => round_rcons(round_index),
            output_round_key => signal_round_keys(round_index)
        );
    END GENERATE;
END ARCHITECTURE;