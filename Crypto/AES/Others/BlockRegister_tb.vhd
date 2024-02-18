LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.aes_data_types.block_vector;

ENTITY BlockRegister_tb IS
    GENERIC (
        MIN_BLOCK_INDEX : NATURAL := 1;
        MAX_BLOCK_INDEX : POSITIVE := 10
    );
END ENTITY;

ARCHITECTURE rtl OF BlockRegister_tb IS
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL rst, shift : STD_LOGIC;
    SIGNAL data_in : STD_LOGIC_VECTOR(127 DOWNTO 0);
    SIGNAL data_out : block_vector(MIN_BLOCK_INDEX TO MAX_BLOCK_INDEX);
BEGIN
    clk <= NOT clk AFTER 5 ns;
    BlockRegister_inst : ENTITY work.BlockRegister
        GENERIC MAP(
            MIN_BLOCK_INDEX => MIN_BLOCK_INDEX,
            MAX_BLOCK_INDEX => MAX_BLOCK_INDEX
        )
        PORT MAP(
            clk => clk,
            rst => rst,
            shift => shift,
            input_block => data_in,
            output_blocks => data_out
        );
    processTest : PROCESS
    BEGIN
        rst <= '1';
        WAIT FOR 30 ns;
        rst <= '0';
        shift <= '1';
        loopTest : FOR register_index IN MIN_BLOCK_INDEX TO MAX_BLOCK_INDEX LOOP
            data_in <= (OTHERS => '1');
            WAIT FOR 10 ns;
        END LOOP;
        shift <= '0';
        WAIT FOR 30 ns;
        rst <= '1';
        WAIT;
    END PROCESS;
END ARCHITECTURE;