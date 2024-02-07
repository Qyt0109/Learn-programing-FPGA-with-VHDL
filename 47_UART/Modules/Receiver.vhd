LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Receiver IS
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
END ENTITY;

ARCHITECTURE rtl OF Receiver IS
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

    COMPONENT BaudClockGenerator IS
        GENERIC (
            NUMBER_OF_CLOCKS : INTEGER;
            SYS_CLK_FREQ : INTEGER;
            BAUD_RATE : INTEGER;
            IS_RX : BOOLEAN -- True if BaudClockGenerator is used in Rx module
        );
        PORT (
            -- inputs
            clk : IN STD_LOGIC; -- 50 MHz
            rst : IN STD_LOGIC;
            start : IN STD_LOGIC;
            -- outputs
            baud_clk : OUT STD_LOGIC;
            ready : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT ShiftRegister IS
        GENERIC (
            DATA_BITS : INTEGER;
            IS_RIGHT_SHIFT : BOOLEAN -- True if shift to the right
        );
        PORT (
            -- inputs
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            shift_en : IN STD_LOGIC;
            data_in : IN STD_LOGIC;
            -- outputs
            data_out : OUT STD_LOGIC_VECTOR(DATA_BITS - 1 DOWNTO 0)
        );
    END COMPONENT;
    -- Signals
    SIGNAL synced_rx_pin : STD_LOGIC;
    SIGNAL synced_rx_pin_delay : STD_LOGIC;
    SIGNAL is_started : STD_LOGIC;
    SIGNAL start : STD_LOGIC;
    SIGNAL baud_clk : STD_LOGIC;
    SIGNAL ready : STD_LOGIC;

    TYPE FSMState IS (IDLE, RECEIVING, DONE);
    SIGNAL fsm_state : FSMState;
BEGIN
    -- Component instances
    Synchronizer_inst : Synchronizer
    GENERIC MAP(
        IDLE_STATE => '1'
    )
    PORT MAP(
        -- inputs
        clk => clk,
        rst => rst,
        async_pin => rx_pin,
        -- outputs
        sync_pin => synced_rx_pin
    );

    BaudClockGenerator_inst : BaudClockGenerator
    GENERIC MAP(
        NUMBER_OF_CLOCKS => DATA_WIDTH + 1, -- Data bits + stop bit
        SYS_CLK_FREQ => SYS_CLK_FREQ,
        BAUD_RATE => BAUD_RATE,
        IS_RX => true -- True if BaudClockGenerator is used in Rx module
    )
    PORT MAP(
        -- inputs
        clk => clk,
        rst => rst,
        start => start,
        -- outputs
        baud_clk => baud_clk,
        ready => ready
    );

    ShiftRegister_inst : ShiftRegister
    GENERIC MAP(
        DATA_BITS => DATA_WIDTH,
        IS_RIGHT_SHIFT => true -- True if shift to the right
    )
    PORT MAP(
        -- inputs
        clk => clk,
        rst => rst,
        shift_en => baud_clk,
        data_in => synced_rx_pin,
        -- outputs
        data_out => rx_data
    );

    -- Processes
    processDetectStart : PROCESS (rst, clk)
    BEGIN
        IF rst = '1' THEN
            is_started <= '0';
            synced_rx_pin_delay <= '1';
        ELSIF rising_edge(clk) THEN
            synced_rx_pin_delay <= synced_rx_pin;
            -- Detect falling edge in rx_pin to know when a start bit occured
            IF synced_rx_pin = '0' AND synced_rx_pin_delay = '1' THEN
                is_started <= '1';
            ELSE
                is_started <= '0';
            END IF;
        END IF;
    END PROCESS;

    processRxFSM : PROCESS (rst, clk)
    BEGIN
        IF rst = '1' THEN
            start <= '0';
            rx_data_ready <= '0';
            fsm_state <= IDLE;
        ELSIF rising_edge(clk) THEN
            IF clear_rx_data_ready = '1' THEN
                rx_data_ready <= '0';
            END IF;
            CASE fsm_state IS
                WHEN IDLE =>
                    IF is_started = '1' THEN
                        start <= '1';
                    ELSE
                        start <= '0';
                    END IF;

                    IF ready = '0' THEN
                        fsm_state <= RECEIVING;
                    END IF;
                WHEN RECEIVING =>
                    start <= '0';
                    IF ready = '1' THEN
                        fsm_state <= DONE;
                    END IF;
                WHEN DONE =>
                    rx_data_ready <= '1';
                    fsm_state <= IDLE;
                WHEN OTHERS =>
                    fsm_state <= IDLE;
            END CASE;
        END IF;
    END PROCESS;
END ARCHITECTURE;