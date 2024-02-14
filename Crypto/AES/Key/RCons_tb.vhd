LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.pkg_rcon.type_round_rcons;

ENTITY RCons_tb IS
END ENTITY;

ARCHITECTURE rtl OF RCons_tb IS
    COMPONENT RCons IS
        PORT (
            input_word : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            output_word : OUT type_round_rcons
        );
    END COMPONENT;
    SIGNAL input_word : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL output_word : type_round_rcons;
BEGIN
    RCons_inst : RCons
    PORT MAP(
        input_word => input_word,
        output_word => output_word
    );
    processTest : PROCESS
    BEGIN
        input_word <= x"00000000";
        WAIT;
    END PROCESS;
END ARCHITECTURE;