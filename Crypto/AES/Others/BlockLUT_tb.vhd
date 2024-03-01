LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.aes_data_types.block_vector;

ENTITY BlockLUT_tb IS
END ENTITY BlockLUT_tb;

ARCHITECTURE testbench OF BlockLUT_tb IS

    -- Signals
    SIGNAL clk, rst : STD_LOGIC := '0';
    SIGNAL input_blocks : block_vector(0 TO 10);
    SIGNAL index : NATURAL := 0;
    SIGNAL output_block : STD_LOGIC_VECTOR(127 DOWNTO 0);
BEGIN
    -- Connect DUT
    blocklut_inst : ENTITY work.BlockLUT
        GENERIC MAP(
            MIN_BLOCK_INDEX => 0,
            MAX_BLOCK_INDEX => 10
        )
        PORT MAP(
            clk => clk,
            rst => rst,
            input_blocks => input_blocks,
            index => index,
            output_block => output_block
        );

    -- Stimulus process
    PROCESS
    BEGIN
        rst <= '1'; -- Assert reset
        clk <= '0';
        WAIT FOR 10 ns;
        rst <= '0'; -- Deassert reset
        WAIT FOR 10 ns;

        clk <= '1'; -- Enable writing
        genInputBlocks : for idx in 0 to 10 loop
            input_blocks(idx) <= std_logic_vector(to_unsigned(idx, input_blocks(idx)'length));
        end loop;
        WAIT FOR 10 ns;
        clk <= '0'; -- Disable writing
        WAIT FOR 20 ns;
        index <= 5; -- Read from index 5
        WAIT FOR 20 ns;
        index <= 7; -- Read from index 5
        WAIT;
    END PROCESS;
END ARCHITECTURE testbench;