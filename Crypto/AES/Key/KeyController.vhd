LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.aes_data_types.block_vector;

ENTITY KeyController IS
    GENERIC (
        MIN_ROUND_INDEX : NATURAL := 0;
        MAX_ROUND_INDEX : POSITIVE := 10
    );
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        start : IN STD_LOGIC;
        input_round_key : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        ready : OUT STD_LOGIC;
        output_round_keys : OUT block_vector(MIN_ROUND_INDEX TO MAX_ROUND_INDEX)
    );
END ENTITY;

ARCHITECTURE rtl OF KeyController IS
    SIGNAL prevoius_round_key, current_round_key, next_round_key : STD_LOGIC_VECTOR(127 DOWNTO 0);
    SIGNAL round_index : INTEGER RANGE MIN_ROUND_INDEX TO MAX_ROUND_INDEX;

    TYPE fsm_state IS (NEW_START, PREPARE, CHANGE, STORE, DONE);
    SIGNAL state : fsm_state := DONE;
    SIGNAL shift_clk : STD_LOGIC; -- := '0';
    SIGNAL gen_key_clk : STD_LOGIC; -- := '0';
    
BEGIN
    KeyRound_inst : ENTITY work.KeyRound
        GENERIC MAP(
            MIN_ROUND_INDEX => MIN_ROUND_INDEX,
            MAX_ROUND_INDEX => MAX_ROUND_INDEX
        )
        PORT MAP(
            clk => gen_key_clk,
            input_round_key => current_round_key,
            round_index => round_index,
            output_round_key => next_round_key
        );

    blockregister_inst : ENTITY work.BlockRegister
        GENERIC MAP(
            MIN_BLOCK_INDEX => MIN_ROUND_INDEX,
            MAX_BLOCK_INDEX => MAX_ROUND_INDEX
        )
        PORT MAP(
            clk => shift_clk,
            rst => rst,
            shift_enable => '1',
            input_block_data => current_round_key,
            output_data_blocks => output_round_keys
        );
    processProcess : PROCESS (rst, clk)
    BEGIN
        IF rst = '1' THEN
            ready <= '1';
            state <= DONE;
            prevoius_round_key <= (OTHERS => '0');
            current_round_key <= (OTHERS => '0');
            gen_key_clk <= '0';
            shift_clk <= '0';
        ELSIF rising_edge(clk) THEN
            CASE state IS
                WHEN NEW_START =>
                    ready <= '0';
                    state <= STORE;
                    shift_clk <= '0';
                    current_round_key <= input_round_key;
                    round_index <= MIN_ROUND_INDEX;
                    -- Change state condition
                WHEN PREPARE =>
                    state <= CHANGE;
                    gen_key_clk <= '0';
                    shift_clk <= '0';
                    prevoius_round_key <= current_round_key;
                    -- current_round_key <= next_round_key;
                WHEN CHANGE =>
                    gen_key_clk <= NOT gen_key_clk;
                    IF gen_key_clk = '0' THEN

                    ELSE
                        state <= STORE;
                        current_round_key <= next_round_key;
                    END IF;
                WHEN STORE =>
                    shift_clk <= '1';
                    IF round_index = MAX_ROUND_INDEX THEN
                        state <= DONE;
                    ELSE
                        round_index <= round_index + 1;
                        state <= PREPARE;
                    END IF;
                WHEN DONE =>
                    ready <= '1';
                    -- Change state condition
                    IF start = '1' THEN
                        state <= NEW_START;
                    END IF;
                WHEN OTHERS =>
                    state <= DONE;
            END CASE;
        ELSIF falling_edge(clk) THEN

        END IF;
    END PROCESS;
END ARCHITECTURE;