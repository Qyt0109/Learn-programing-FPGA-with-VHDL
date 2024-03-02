LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Transmitter IS
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
END ENTITY;

ARCHITECTURE rtl OF Transmitter IS
    -- Components
    COMPONENT Serialiser IS
        GENERIC (
            DATA_WIDTH : INTEGER;
            DEFAULT_STATE : STD_LOGIC
        );
        PORT (
            -- inputs
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            shift_en : IN STD_LOGIC;
            load : IN STD_LOGIC;
            data_in : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            -- outputs
            data_out : OUT STD_LOGIC
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

    -- Signals
    SIGNAL baud_clk : STD_LOGIC;
    SIGNAL tx_packet : STD_LOGIC_VECTOR(DATA_BITS + 1 DOWNTO 0); -- packet: [1 start_bit (bit 0) | 8 data_bits | 1 stop_bit (bit 1)]
BEGIN
    tx_packet <= '1' & tx_data & '0';
    Serialiser_inst : Serialiser
    GENERIC MAP(
        DATA_WIDTH => DATA_BITS + 2,
        DEFAULT_STATE => '1'
    )
    PORT MAP(
        clk => clk,
        rst => rst,
        shift_en => baud_clk,
        load => tx_start,
        data_in => tx_packet,
        data_out => tx_pin
    );
    BaudClockGenerator_inst : BaudClockGenerator
    GENERIC MAP(
        NUMBER_OF_CLOCKS => DATA_BITS + 2,
        SYS_CLK_FREQ => SYS_CLK_FREQ,
        BAUD_RATE => BAUD_RATE,
        IS_RX => false -- True if BaudClockGenerator is used in Rx module
    )
    PORT MAP(
        -- inputs
        clk => clk,
        rst => rst,
        start => tx_start,
        -- outputs
        baud_clk => baud_clk,
        ready => tx_ready
    );

END ARCHITECTURE;