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
    processTest:process
    begin
        -- init
        rst <= '1';
        sync_signal <= '1';
        wait for 100 ns;
        rst <= '0';
        wait for 100 ns;
        -- 
    end process;
END ARCHITECTURE;