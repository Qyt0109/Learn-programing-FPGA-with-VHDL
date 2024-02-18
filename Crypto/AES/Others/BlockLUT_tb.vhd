LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.aes_data_types.block_vector;

ENTITY BlockLUT_tb IS
    GENERIC (
        MIN_BLOCK_INDEX : NATURAL := 1;
        MAX_BLOCK_INDEX : POSITIVE := 10
    );
END ENTITY BlockLUT_tb;

ARCHITECTURE rtl OF BlockLUT_tb IS
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL input_data_blocks : block_vector(MIN_BLOCK_INDEX TO MAX_BLOCK_INDEX);
    SIGNAL block_index : NATURAL;
    SIGNAL output_data_block : STD_LOGIC_VECTOR(127 DOWNTO 0);
BEGIN
    clk <= NOT clk AFTER 5 ns;
    BlockLUT_inst : ENTITY work.BlockLUT
        GENERIC MAP(
            MIN_BLOCK_INDEX => MIN_BLOCK_INDEX,
            MAX_BLOCK_INDEX => MAX_BLOCK_INDEX
        )
        PORT MAP(
            clk => clk,
            input_data_blocks => input_data_blocks,
            block_index => block_index,
            output_data_block => output_data_block
        );
    processTest : PROCESS
    BEGIN
        input_data_blocks <= (x"00000000000000000000000000000001", x"00000000000000000000000000000002", x"00000000000000000000000000000003", x"00000000000000000000000000000004", x"00000000000000000000000000000005", x"00000000000000000000000000000006", x"00000000000000000000000000000007", x"00000000000000000000000000000008", x"00000000000000000000000000000009", x"0000000000000000000000000000000A");
        loopTest : FOR index IN MIN_BLOCK_INDEX TO MAX_BLOCK_INDEX LOOP
            block_index <= index;
            WAIT FOR 10 ns;
        END LOOP;
    END PROCESS;
END ARCHITECTURE;