LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Synchronizer_tb IS
END ENTITY;

ARCHITECTURE rtl OF Synchronizer_tb IS
    -- Components
    COMPONENT Synchronizer IS
        GENERIC (
            IDLE_STATE : STD_LOGIC
        );
        PORT (
            -- inputs
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            async_pin : IN STD_LOGIC;
            -- outputs
            sync_pin : OUT STD_LOGIC
        );
    END COMPONENT;
    -- Signals
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL rst : STD_LOGIC;
    SIGNAL async_signal : STD_LOGIC;
    SIGNAL sync_signal : STD_LOGIC;
BEGIN
    clk <= NOT clk AFTER 10 ns; -- Simulate 50 MHz clock
    Synchronizer_inst : Synchronizer
    GENERIC MAP(
        IDLE_STATE => '1'
    )
    PORT MAP(
        clk => clk,
        rst => rst,
        async_pin => async_signal,
        sync_pin => sync_signal
    );
    processTest : PROCESS
    BEGIN
        -- init - run 200 ns
        rst <= '1';
        sync_signal <= '1';
        WAIT FOR 100 ns;
        rst <= '0';
        WAIT FOR 100 ns;
        --  test synchronize async signal - run 100 ns
        -- async signal which 3 ns after the clk
        WAIT FOR 3 ns;
        async_signal <= '0';
        -- 3 clk circle after
        FOR i IN 0 TO 2 LOOP
            WAIT UNTIL rising_edge(clk);
        END LOOP;
        -- async signal which 8 ns after the clk
        WAIT FOR 8 ns;
        async_signal <= '1';

        WAIT; -- 1 time process
    END PROCESS;
END ARCHITECTURE;