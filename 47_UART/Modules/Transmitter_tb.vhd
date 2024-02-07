LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Transmitter_tb IS
    GENERIC (
        DATA_BITS : INTEGER := 8;
        SYS_CLK_FREQ : INTEGER := 50000000;
        BAUD_RATE : INTEGER := 50000 -- Bit period = 20 us
    );
END ENTITY;

ARCHITECTURE rtl OF Transmitter_tb IS
    -- Components
    COMPONENT Transmitter IS
        GENERIC (
            DATA_BITS : INTEGER;
            SYS_CLK_FREQ : INTEGER;
            BAUD_RATE : INTEGER
        );
        PORT (
            -- inputs
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            tx_start : IN STD_LOGIC;
            tx_data : IN STD_LOGIC_VECTOR(DATA_BITS - 1 DOWNTO 0);
            -- outputs
            tx_ready : OUT STD_LOGIC;
            tx_pin : OUT STD_LOGIC
        );
    END COMPONENT;
    -- Signals
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL rst : STD_LOGIC;
    SIGNAL tx_start : STD_LOGIC;
    SIGNAL tx_data : STD_LOGIC_VECTOR(DATA_BITS - 1 DOWNTO 0);
    -- outputs
    SIGNAL tx_ready : STD_LOGIC;
    SIGNAL tx_pin : STD_LOGIC;
BEGIN
    clk <= NOT clk AFTER 10 ns; -- Simulate the 50MHz clock input
    Transmitter_inst : Transmitter
    GENERIC MAP(
        DATA_BITS => DATA_BITS,
        SYS_CLK_FREQ => SYS_CLK_FREQ,
        BAUD_RATE => BAUD_RATE
    )
    PORT MAP(
        -- inputs
        clk => clk,
        rst => rst,
        tx_start => tx_start,
        tx_data => tx_data,
        -- outputs
        tx_ready => tx_ready,
        tx_pin => tx_pin
    );
    processTest : PROCESS
    BEGIN
        rst <= '1';
        tx_start <= '0';
        tx_data <= x"00";
        WAIT FOR 100 ns;
        rst <= '0';
        WAIT FOR 100 ns;
        WAIT UNTIL rising_edge(clk);
        tx_data <= x"69";
        tx_start <= '1';
        WAIT UNTIL rising_edge(clk);
        tx_data <= x"00";
        tx_start <= '0';
        WAIT;
    END PROCESS;
END ARCHITECTURE;