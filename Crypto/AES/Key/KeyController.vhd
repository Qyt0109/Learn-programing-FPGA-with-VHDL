LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.aes_data_types.block_vector;

ENTITY KeyController IS
    GENERIC (
        MIN_BLOCK_INDEX : NATURAL := 0;
        MAX_BLOCK_INDEX : POSITIVE := 10
    );
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        start : IN STD_LOGIC;
        input_round_key : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        ready : OUT STD_LOGIC;
        round_index : IN NATURAL RANGE MIN_BLOCK_INDEX TO MAX_BLOCK_INDEX;
        round_key : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF KeyController IS
    SIGNAL next_round_clk, register_shift : STD_LOGIC;
    SIGNAL next_round_key : STD_LOGIC_VECTOR(127 DOWNTO 0);
    SIGNAL current_round_key : STD_LOGIC_VECTOR(127 DOWNTO 0);
    SIGNAL round_rcon_signal : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL block_register_signals : block_vector(MIN_BLOCK_INDEX TO MAX_BLOCK_INDEX);
BEGIN
    KeyRound_inst : ENTITY work.KeyRound
        PORT MAP(
            clk => next_round_clk,
            input_round_key => current_round_key,
            round_rcon => round_rcon_signal,
            output_round_key => next_round_key
        );
    BlockRegister_inst : ENTITY work.BlockRegister
        GENERIC MAP(
            MIN_BLOCK_INDEX => MIN_BLOCK_INDEX,
            MAX_BLOCK_INDEX => MAX_BLOCK_INDEX
        )
        PORT MAP(
            clk => next_round_clk,
            rst => rst,
            shift => register_shift,
            input_block => next_round_key,
            output_blocks => block_register_signals
        );
    BlockLUT_inst : ENTITY work.BlockLUT
        GENERIC MAP(
            MIN_BLOCK_INDEX => MIN_BLOCK_INDEX,
            MAX_BLOCK_INDEX => MAX_BLOCK_INDEX
        )
        PORT MAP(
            clk => clk,
            input_data_blocks => block_register_signals,
            block_index => round_index,
            output_data_block => round_key
        );

    processStart : process (rst, clk)
    begin
        if rising_edge(clk) then

        end if;
    end process;
END ARCHITECTURE;