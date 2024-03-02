LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY AsyncResetDFF_tb IS
END ENTITY;

ARCHITECTURE rtl OF AsyncResetDFF_tb IS
    -- Components
    COMPONENT AsyncResetDFF IS
        PORT (
            -- inputs
            clk : IN STD_LOGIC; -- Clock input
            rst : IN STD_LOGIC; -- Reset input
            d : IN STD_LOGIC; -- Data input
            -- outputs
            q : OUT STD_LOGIC; -- Q output
            q_not : OUT STD_LOGIC -- Not Q output
        );
    END COMPONENT;
    -- Signals
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL rst, d, q, q_not : STD_LOGIC;
BEGIN
    clk <= NOT clk AFTER 10 ns; -- Simulate 50 MHz clock
    AsyncResetDFF_inst : AsyncResetDFF
    PORT MAP(
        clk => clk,
        rst => rst,
        d => d,
        q => q,
        q_not => q_not
    );
    processTest : PROCESS
    BEGIN
        -- init - run 200 ns
        rst <= '1';
        d <= '0';
        WAIT UNTIL rising_edge(clk);
        rst <= '0';
        WAIT UNTIL rising_edge(clk);
        d <= '1';
        WAIT UNTIL rising_edge(clk);
        d <= '1';
        WAIT UNTIL rising_edge(clk);
        d <= '0';
        WAIT UNTIL rising_edge(clk);
        d <= '1';
        WAIT UNTIL rising_edge(clk);
        rst <= '1';
        WAIT;
    END PROCESS;
END ARCHITECTURE;