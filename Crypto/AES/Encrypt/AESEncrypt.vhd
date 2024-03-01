LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY AESEncrypt IS
    GENERIC (
        MIN_ROUND_INDEX : NATURAL := 0;
        MAX_ROUND_INDEX : POSITIVE := 10
    );
    PORT (
        clk, rst, start : IN STD_LOGIC;
        input_data : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        key : IN STD_LOGIC_VECTOR(127 DOWNTO 0);

        ready : OUT STD_LOGIC;
        output_data : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF AESEncrypt IS
    TYPE fsm_state IS (GEN_KEYS, KEYS_DONE, NEW_START, PREPARE, CHANGE, DONE);
    SIGNAL state : fsm_state := DONE;
    SIGNAL start_gen_keys, done_gen_keys, is_last_round : STD_LOGIC;
    SIGNAL index : INTEGER RANGE MIN_ROUND_INDEX TO MAX_ROUND_INDEX;
    SIGNAL main_key, output_round_key : STD_LOGIC_VECTOR(127 DOWNTO 0);

    SIGNAL current_state, next_state : STD_LOGIC_VECTOR(127 DOWNTO 0);
BEGIN
    KeyController_inst : ENTITY work.KeyController
        GENERIC MAP(
            MIN_ROUND_INDEX => MIN_ROUND_INDEX,
            MAX_ROUND_INDEX => MAX_ROUND_INDEX
        )
        PORT MAP(
            clk => clk,
            rst => rst,
            start => start_gen_keys,
            input_round_key => main_key,
            ready => done_gen_keys,
            index => index,
            output_round_key => output_round_key
        );
    EncryptRound_inst : ENTITY work.EncryptRound
        PORT MAP(
            input_state => current_state,
            is_last_round => is_last_round,
            round_key => output_round_key,
            output_state => next_state
        );
    is_last_round <= '1' WHEN index = MAX_ROUND_INDEX ELSE '0';
    processProcess : PROCESS (rst, clk)
    BEGIN
        IF rst = '1' THEN
            ready <= '1';
            state <= DONE;
            current_state <= (OTHERS => '0');
            main_key <= (OTHERS => '0');
            output_data <= (OTHERS => '0');
            start_gen_keys <= '0';
        ELSIF rising_edge(clk) THEN
            CASE state IS
                WHEN GEN_KEYS =>
                    start_gen_keys <= '0';
                    state <= KEYS_DONE;
                WHEN KEYS_DONE =>
                    IF done_gen_keys = '1' THEN
                        state <= NEW_START;
                    END IF;
                WHEN NEW_START =>
                    current_state <= current_state XOR output_round_key;
                    index <= MIN_ROUND_INDEX + 1;
                    state <= CHANGE;
                WHEN PREPARE =>

                    state <= CHANGE;
                WHEN CHANGE =>
                    IF index = MAX_ROUND_INDEX THEN
                        state <= DONE;
                        index <= MIN_ROUND_INDEX;
                        output_data <= next_state;
                    ELSE
                        current_state <= next_state;
                        index <= index + 1;
                        state <= PREPARE;
                    END IF;
                WHEN DONE =>
                    ready <= '1';
                    -- Change state condition
                    IF start = '1' THEN
                        ready <= '0';
                        current_state <= input_data;
                        IF main_key = key THEN
                            state <= NEW_START;
                        ELSE
                            state <= GEN_KEYS;
                            main_key <= key;
                            start_gen_keys <= '1';
                        END IF;
                    END IF;
            END CASE;
        ELSIF falling_edge(clk) THEN

        END IF;
    END PROCESS;

END ARCHITECTURE;