LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.aes_data_types.block_vector;

ENTITY BlockRegister_tb IS
    GENERIC (
        MIN_BLOCK_INDEX : NATURAL := 0;
        MAX_BLOCK_INDEX : POSITIVE := 10
    );
END ENTITY;

ARCHITECTURE rtl OF BlockRegister_tb IS
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL rst, shift_enable : STD_LOGIC;
    SIGNAL input_block_data : STD_LOGIC_VECTOR(127 DOWNTO 0);
    SIGNAL output_data_blocks : block_vector(MIN_BLOCK_INDEX TO MAX_BLOCK_INDEX);

    CONSTANT CLK_PERIOD : TIME := 10 ns;
BEGIN
    BlockRegister_inst : ENTITY work.BlockRegister
        GENERIC MAP(
            MIN_BLOCK_INDEX => MIN_BLOCK_INDEX,
            MAX_BLOCK_INDEX => MAX_BLOCK_INDEX
        )
        PORT MAP(
            clk => clk,
            rst => rst,
            shift_enable => shift_enable,
            input_block_data => input_block_data,
            output_data_blocks => output_data_blocks
        );
    processClock : PROCESS
    BEGIN
        WHILE now < CLK_PERIOD * 6 LOOP -- Simulation time
            clk <= '0';
            WAIT FOR CLK_PERIOD / 2;
            clk <= '1';
            WAIT FOR CLK_PERIOD / 2;
        END LOOP;
        WAIT;
    END PROCESS;
    processTest : PROCESS
    BEGIN
        rst <= '1';
        WAIT FOR CLK_PERIOD * 2;
        rst <= '0';
        WAIT FOR CLK_PERIOD;

        shift_enable <= '1'; -- Enable shifting

        -- Shifting 0123456789ABCDEF0123456789ABCDEF
        input_block_data <= x"ffff0000000000000000000000000000";
        WAIT FOR CLK_PERIOD;
        -- Shifting A1B2C3D4E5F6A1B2C3D4E5F6A1B2C3D4
        input_block_data <= x"ffff0000000000000000000000000001";
        WAIT FOR CLK_PERIOD;

        shift_enable <= '0'; -- Disable shifting
        WAIT;
    END PROCESS;
END ARCHITECTURE;