LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Receiver_tb IS
END ENTITY;

ARCHITECTURE rtl OF Receiver_tb IS
    -- Components
    COMPONENT Receiver IS
        GENERIC (
            DATA_WIDTH : INTEGER;
            SYS_CLK_FREQ : INTEGER;
            BAUD_RATE : INTEGER
        );
        PORT (
            -- inputs
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            rx_pin : IN STD_LOGIC; -- async
            clear_rx_data_ready : IN STD_LOGIC;
            -- outputs
            rx_data_ready : OUT STD_LOGIC;
            rx_data : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
        );
    END COMPONENT;
    -- Signals
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL rst : STD_LOGIC;
    SIGNAL rx_pin : STD_LOGIC;
    SIGNAL clear_rx_data_ready : STD_LOGIC;
    SIGNAL rx_data_ready : STD_LOGIC;
    SIGNAL rx_data : STD_LOGIC_VECTOR(7 DOWNTO 0);

    SIGNAL pc_data : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"AF";

BEGIN
    Clk <= NOT Clk AFTER 10 ns; -- Simulate 50 MHz clock
    Receiver_inst : Receiver
    GENERIC MAP(
        DATA_WIDTH => 8,
        SYS_CLK_FREQ => 50000000,
        BAUD_RATE => 115200
    )
    PORT MAP(
        clk => clk,
        rst => rst,
        rx_pin => rx_pin,
        clear_rx_data_ready => clear_rx_data_ready,
        rx_data_ready => rx_data_ready,
        rx_data => rx_data
    );
    processTest : PROCESS
    BEGIN
        -- init - run 200 ns
        rst <= '1';
        rx_pin <= '1';
        clear_rx_data_ready <= '1';
        WAIT FOR 100 ns;
        rst <= '0';
        WAIT FOR 100 ns;
        -- Transmit UART packet - run 100 us
        -- Transmit start bit
        rx_pin <= '0';
        WAIT FOR 8.7 us;
        -- Transmit pc_data
        FOR i IN 0 TO 7 LOOP
            rx_pin <= pc_data(i);
            WAIT FOR 8.7 us;
        END LOOP;
        -- Transmit stop bit
        rx_pin <= '1';
        WAIT FOR 8.7 us;

        -- Clear rx data ready
        WAIT FOR 50 ns;
        WAIT UNTIL rising_edge(clk);
        clear_rx_data_ready <= '1';
        WAIT UNTIL rising_edge(clk);
        clear_rx_data_ready <= '0';

        WAIT;
    END PROCESS;
END ARCHITECTURE;