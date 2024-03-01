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
    SIGNAL input_round_key, output_round_key : STD_LOGIC_VECTOR(127 DOWNTO 0);
    SIGNAL index : INTEGER RANGE MIN_ROUND_INDEX TO MAX_ROUND_INDEX;
    CONSTANT CLK_PERIOD : TIME := 10 ns;
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
            index => index,
            output_round_key => output_round_key
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

        WAIT UNTIL rising_edge(ready);
        -- Read all keys
        readRoundKeys : for idx in 0 to 10 loop
            index <= idx;
            wait for CLK_PERIOD;
        end loop;
        
        
        -- NEW KEY GEN
        input_round_key <= x"00000000000000000000000000000000";
        WAIT FOR CLK_PERIOD;
        start <= '1';
        WAIT FOR CLK_PERIOD;
        start <= '0';

        WAIT;
    END PROCESS;
END ARCHITECTURE;