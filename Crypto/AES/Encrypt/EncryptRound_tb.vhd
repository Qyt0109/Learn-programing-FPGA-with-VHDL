LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY EncryptRound_tb IS
END ENTITY;

ARCHITECTURE rtl OF EncryptRound_tb IS
    COMPONENT EncryptRound IS
        PORT (
            input_state : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
            round_key : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
            output_state : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL input_state, round_key, output_state : STD_LOGIC_VECTOR(127 DOWNTO 0);
BEGIN
    EncryptRound_inst : EncryptRound
    PORT MAP(
        input_state => input_state,
        round_key => round_key,
        output_state => output_state
    );
    processTest : PROCESS
    BEGIN
        input_state <= x"1a0b5954311b080e74224e1f476e3c00";
        round_key <= x"93e688f1a2e491fc79591232d6b191e2";
        WAIT;
    END PROCESS;
END ARCHITECTURE;