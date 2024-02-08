LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY TopModule_tb IS
    GENERIC (
        DATA_BITS : INTEGER := 8
    );
END ENTITY;
ARCHITECTURE rtl OF TopModule_tb IS
    -- Components
    COMPONENT TopModule IS
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
    END COMPONENT;
    -- Signals
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL rst : STD_LOGIC;
    SIGNAL tx_pin : STD_LOGIC;
    SIGNAL rx_pin : STD_LOGIC;
    SIGNAL transmit_data : STD_LOGIC_VECTOR(DATA_BITS - 1 DOWNTO 0);
    SIGNAL receive_data : STD_LOGIC_VECTOR(DATA_BITS - 1 DOWNTO 0);
BEGIN
    clk <= NOT clk AFTER 10 ns; -- Simulate 50 MHz clock
    TopModule_inst : TopModule
    GENERIC MAP(
        DATA_BITS => DATA_BITS,
        SYS_CLK_FREQ => 50000000, -- 50 MHz clock
        BAUD_RATE => 115200
    )
    PORT MAP(
        clk => clk,
        rst => rst,
        tx_pin => tx_pin,
        rx_pin => rx_pin
    );
    processPallalelize : PROCESS
    BEGIN
        -- Watting for start bit
        WAIT UNTIL falling_edge(tx_pin);
        -- Wait half a bit period to center the start bit
        WAIT FOR 4.35 us;
        FOR i IN 0 TO DATA_BITS - 1 LOOP
            WAIT FOR 8.7 us;
            transmit_data(i) <= tx_pin;
        END LOOP;
        -- Wait for stop bit
        WAIT FOR 8.7 us;
        receive_data <= transmit_data;
    END PROCESS;
    processTest : PROCESS
        VARIABLE transmit_data_vector : STD_LOGIC_VECTOR(DATA_BITS - 1 DOWNTO 0);
        PROCEDURE transmitCharacter(
            CONSTANT data : IN INTEGER
        ) IS
        BEGIN
            transmit_data_vector := STD_LOGIC_VECTOR(to_unsigned(data, DATA_BITS));
            rx_pin <= '0'; -- start bit
            WAIT FOR 8.7 us;
            -- transmiting data
            FOR i IN 0 TO DATA_BITS - 1 LOOP
                rx_pin <= transmit_data_vector(i);
                WAIT FOR 8.7 us;
            END LOOP;
            rx_pin <= '1'; -- stop bit
            WAIT FOR 8.7 us;
        END PROCEDURE;
    BEGIN
        -- init - run 200 ns
        rst <= '1';
        rx_pin <= '1';
        WAIT FOR 100 ns;
        rst <= '0';
        WAIT FOR 100 ns;

        -- Transmit char 33 - run 
        FOR i IN 0 TO 255 LOOP
            transmitCharacter(i);
            WAIT FOR 5 us;
        END LOOP;
        WAIT;
    END PROCESS;
END ARCHITECTURE;