LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY KeyController_tb IS
    GENERIC (
        MIN_BLOCK_INDEX : NATURAL := 0;
        MAX_BLOCK_INDEX : POSITIVE := 10
    );
END ENTITY;

ARCHITECTURE rtl OF KeyController_tb IS
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL rst, start, ready : STD_LOGIC;
    SIGNAL input_round_key : STD_LOGIC_VECTOR(127 DOWNTO 0);
    SIGNAL round_index : NATURAL RANGE MIN_BLOCK_INDEX TO MAX_BLOCK_INDEX;
    SIGNAL round_key : STD_LOGIC_VECTOR(127 DOWNTO 0);
BEGIN
    clk <= NOT clk AFTER 10 ns;
    keycontroller_inst : ENTITY work.KeyController
        GENERIC MAP(
            MIN_BLOCK_INDEX => MIN_BLOCK_INDEX,
            MAX_BLOCK_INDEX => MAX_BLOCK_INDEX
        )
        PORT MAP(
            clk => clk,
            rst => rst,
            start => start,
            input_round_key => input_round_key,
            ready => ready,
            round_index => round_index,
            round_key => round_key
        );
    processTest : PROCESS
    BEGIN
        rst <= '0';
        start <= '0';
        wait for 30 ns;
        rst <= '1';
        wait for 30 ns;
        input_round_key <= x"5468617473206D79204B756E67204675";
        wait for 5 ns;
        start <= '1';
        wait for 10 ns;
        start <= '0';
        WAIT;
    END PROCESS;
END ARCHITECTURE;