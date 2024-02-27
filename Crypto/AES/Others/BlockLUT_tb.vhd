LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY BlockLUT_tb IS
END ENTITY BlockLUT_tb;

ARCHITECTURE testbench OF BlockLUT_tb IS
    -- Constants
    CONSTANT CLK_PERIOD : TIME := 10 ns; -- Clock period

    -- Signals
    SIGNAL clk, rst, input_enable : STD_LOGIC := '0';
    SIGNAL input_block_data : STD_LOGIC_VECTOR(127 DOWNTO 0) := (OTHERS => '0');
    SIGNAL input_index, block_index : NATURAL := 0;
    SIGNAL output_data_block : STD_LOGIC_VECTOR(127 DOWNTO 0);
BEGIN
    -- Connect DUT
    DUT : ENTITY work.BlockLUT
        GENERIC MAP(
            MIN_BLOCK_INDEX => 0,
            MAX_BLOCK_INDEX => 3
        )
        PORT MAP(
            clk => clk,
            rst => rst,
            input_enable => input_enable,
            input_block_data => input_block_data,
            input_index => input_index,
            block_index => block_index,
            output_data_block => output_data_block
        );
    -- Clock process
    PROCESS
    BEGIN
        WHILE now < 1000 ns LOOP -- Simulation time: 1000 ns
            clk <= '0';
            WAIT FOR CLK_PERIOD / 2;
            clk <= '1';
            WAIT FOR CLK_PERIOD / 2;
        END LOOP;
        WAIT;
    END PROCESS;

    -- Stimulus process
    PROCESS
    BEGIN
        rst <= '1'; -- Assert reset
        WAIT FOR CLK_PERIOD * 2; -- Hold reset for two clock cycles
        rst <= '0'; -- Deassert reset
        WAIT FOR CLK_PERIOD;

        input_enable <= '1'; -- Enable writing
        input_block_data <= x"0123456789ABCDEF0123456789ABCDEF"; -- Input data
        input_index <= 0; -- Write at index 0
        WAIT FOR CLK_PERIOD;
        input_enable <= '0'; -- Disable writing

        input_index <= 0; -- Read from index 0
        WAIT FOR CLK_PERIOD;
        block_index <= 0; -- Set block index to 0
        WAIT FOR CLK_PERIOD;

        -- Writing to index 2
        input_enable <= '1'; -- Enable writing
        input_block_data <= x"A1B2C3D4E5F6A1B2C3D4E5F6A1B2C3D4"; -- New input data
        input_index <= 2; -- Write at index 2
        WAIT FOR CLK_PERIOD;
        input_enable <= '0'; -- Disable writing

        -- Reading from index 2
        input_index <= 2; -- Read from index 2
        WAIT FOR CLK_PERIOD;
        block_index <= 2; -- Set block index to 2
        WAIT FOR CLK_PERIOD;

        -- Reading from index 0
        input_index <= 0; -- Read from index 0
        WAIT FOR CLK_PERIOD;
        block_index <= 0; -- Set block index to 0
        WAIT FOR CLK_PERIOD;

        WAIT;
    END PROCESS;
END ARCHITECTURE testbench;