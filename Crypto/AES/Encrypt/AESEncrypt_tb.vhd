LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY AESEncrypt_tb IS
END ENTITY AESEncrypt_tb;

ARCHITECTURE rtl OF AESEncrypt_tb IS
    CONSTANT CLK_PERIOD : TIME := 10 ns;

    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL rst, ready, start : STD_LOGIC;
    SIGNAL input_data, key, output_data : STD_LOGIC_VECTOR(127 DOWNTO 0);
BEGIN
    clk <= NOT clk AFTER CLK_PERIOD / 2;
    AESEncrypt_inst : ENTITY work.AESEncrypt
        GENERIC MAP(
            MIN_ROUND_INDEX => 0,
            MAX_ROUND_INDEX => 10
        )
        PORT MAP(
            clk => clk,
            rst => rst,
            start => start,
            input_data => input_data,
            key => key,
            ready => ready,
            output_data => output_data
        );

    processTest : PROCESS
    BEGIN
        rst <= '1';
        input_data <= x"54776f204f6e65204e696e652054776f";
        key <= x"5468617473206D79204B756E67204675";
        start <= '0';
        WAIT FOR CLK_PERIOD;
        rst <= '0';
        WAIT FOR CLK_PERIOD;

        start <= '1';
        WAIT FOR CLK_PERIOD;
        start <= '0';

        wait until rising_edge(ready);
        input_data <= x"54776f204f6e65204e696e652054776f";
        wait for CLK_PERIOD;
        start <= '1';
        WAIT FOR CLK_PERIOD;
        start <= '0';
        WAIT;
    END PROCESS;
END ARCHITECTURE;