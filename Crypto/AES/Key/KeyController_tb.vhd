LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.aes_data_types.block_vector;

ENTITY KeyController_tb IS
    GENERIC (
        MIN_ROUND_INDEX : NATURAL := 0;
        MAX_ROUND_INDEX : POSITIVE := 10
    );
END ENTITY;

ARCHITECTURE rtl OF KeyController_tb IS
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL rst, start, ready : STD_LOGIC;
    SIGNAL input_round_key : STD_LOGIC_VECTOR(127 DOWNTO 0);
    SIGNAL output_round_keys : block_vector(0 TO 10);

    constant CLK_PERIOD: time := 10 ns;
BEGIN
    clk <= NOT clk AFTER CLK_PERIOD / 2;
    keycontroller_inst : ENTITY work.KeyController
        GENERIC MAP(
            MIN_ROUND_INDEX => MIN_ROUND_INDEX,
            MAX_ROUND_INDEX => MAX_ROUND_INDEX
        )
        PORT MAP(
            clk => clk,
            rst => rst,
            start => start,
            input_round_key => input_round_key,
            ready => ready,
            output_round_keys => output_round_keys
        );
    processTest : PROCESS
    BEGIN
        rst <= '1';
        input_round_key <= x"5468617473206D79204B756E67204675";
        start <= '0';
        WAIT FOR CLK_PERIOD * 3;
        rst <= '0';
        WAIT FOR CLK_PERIOD;

        start <= '1';
        WAIT FOR CLK_PERIOD;
        start <= '0';

        -- NEW KEY GEN
        wait until rising_edge(ready);
        input_round_key <= x"00000000000000000000000000000000";
        wait for CLK_PERIOD;
        start <= '1';
        WAIT FOR CLK_PERIOD;
        start <= '0';

        WAIT;
    END PROCESS;
END ARCHITECTURE;