LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY TopModule IS
    GENERIC (
        DATA_BITS : INTEGER;
        SYS_CLK_FREQ : INTEGER;
        BAUD_RATE : INTEGER
    );
    PORT (
        -- inputs
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        rx_pin : IN STD_LOGIC;
        -- outputs
        tx_pin : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE rtl OF TopModule IS
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
    TYPE FSMState IS (IDLE, TRANSMIT);
    SIGNAL fsm_state : FSMState;
    SIGNAL tx_start : STD_LOGIC;
    SIGNAL tx_ready : STD_LOGIC;
    SIGNAL rx_data_ready : STD_LOGIC;
    SIGNAL rx_data : STD_LOGIC_VECTOR(DATA_BITS - 1 DOWNTO 0);
BEGIN
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
        tx_data => rx_data,
        -- outputs
        tx_ready => tx_ready,
        tx_pin => tx_pin
    );
    Receiver_inst : Receiver
    GENERIC MAP(
        DATA_WIDTH => DATA_BITS,
        SYS_CLK_FREQ => SYS_CLK_FREQ,
        BAUD_RATE => BAUD_RATE
    )
    PORT MAP(
        -- inputs
        clk => clk,
        rst => rst,
        rx_pin => rx_pin,
        clear_rx_data_ready => tx_start,
        -- outputs
        rx_data_ready => rx_data_ready,
        rx_data => rx_data
    );
    processFSM : PROCESS (rst, clk)
    BEGIN
        IF rst = '1' THEN
            fsm_state <= IDLE;
            tx_start <= '0';
        ELSIF rising_edge(clk) THEN
            CASE fsm_state IS
                WHEN IDLE =>
                    IF rx_data_ready = '1' AND tx_ready = '1' THEN
                        fsm_state <= TRANSMIT;
                        tx_start <= '1';
                    END IF;
                WHEN TRANSMIT =>
                    tx_start <= '0';
                    fsm_state <= IDLE;
                WHEN OTHERS =>
                    fsm_state <= IDLE;
            END CASE;
        END IF;
    END PROCESS;
END ARCHITECTURE;