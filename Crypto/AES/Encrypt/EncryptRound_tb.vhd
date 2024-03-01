LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY EncryptRound_tb IS
END ENTITY;

ARCHITECTURE rtl OF EncryptRound_tb IS
    SIGNAL is_last_round : STD_LOGIC := '0';
    SIGNAL input_state, round_key, output_state : STD_LOGIC_VECTOR(127 DOWNTO 0);
BEGIN
    EncryptRound_inst : ENTITY work.EncryptRound
        PORT MAP(
            input_state => input_state,
            is_last_round => is_last_round,
            round_key => round_key,
            output_state => output_state
        );
    processTest : PROCESS
    BEGIN
        is_last_round <= '0';
        input_state <= (OTHERS => '0');
        round_key <= (OTHERS => '0');
        wait for 20 ns;
        -- output_state should be 5847088B 15B61CBA 59D4E2E8 CD39DFCE
        is_last_round <= '0';
        input_state <= x"001f0e54_3c4e0859_6e221b0b_4774311a";
        round_key <= x"e232fcf1_91129188_b159e4e6_d679a293";

        WAIT FOR 20 ns;
        -- output_state should be 29C3505F 571420F6 402299B3 1A02D73A
        is_last_round <= '1';
        input_state <= x"09668b78_a2d19a65_f0fce6c4_7b3b3089";
        round_key <= x"28FDDEF8_6DA4244A_CCC0A4FE_3B316F26";
        WAIT;
    END PROCESS;
END ARCHITECTURE;