LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ShiftRegister_tb IS
END ENTITY;

ARCHITECTURE rtl OF ShiftRegister_tb IS
    -- Components
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
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL rst : STD_LOGIC;
    SIGNAL shift_en : STD_LOGIC;
    SIGNAL data_in : STD_LOGIC;
    SIGNAL data_out : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN
    clk <= NOT clk AFTER 10 ns; -- Simulate the 50MHz clock input
    ShiftRegister_inst : ShiftRegister
    GENERIC MAP(
        DATA_BITS => 8,
        IS_RIGHT_SHIFT => true
    )
    PORT MAP(
        clk => clk,
        rst => rst,
        shift_en => shift_en,
        data_in => data_in,
        data_out => data_out
    );
    processTest : PROCESS
    BEGIN
        -- init - run 200 ns
        rst <= '1';
        shift_en <= '0';
        data_in <= '0';
        WAIT FOR 100 ns;
        rst <= '0';
        WAIT FOR 100 ns;

        -- Transmit 0C5h - 11000101b - run 100 us
        -- Transmit 05h - 0101 (LSB first)
        FOR i IN 0 TO 1 LOOP
            data_in <= '1';
            WAIT FOR 4.3 us;
            WAIT UNTIL rising_edge(clk);
            shift_en <= '1';
            WAIT UNTIL rising_edge(clk);
            shift_en <= '0';
            WAIT FOR 4.3 us;
            data_in <= '0';
            WAIT FOR 4.3 us;
            WAIT UNTIL rising_edge(clk);
            shift_en <= '1';
            WAIT UNTIL rising_edge(clk);
            shift_en <= '0';
            WAIT FOR 4.3 us;
        END LOOP;
        -- Transmit 0Ch - 1100 (LSB first)
        FOR i IN 0 TO 1 loop
            data_in <= '0';
            WAIT FOR 4.3 us;
            WAIT UNTIL rising_edge(clk);
            shift_en <= '1';
            WAIT UNTIL rising_edge(clk);
            shift_en <= '0';
            WAIT FOR 4.3 us;
        END LOOP;
        FOR i IN 0 TO 1 loop
            data_in <= '1';
            WAIT FOR 4.3 us;
            WAIT UNTIL rising_edge(clk);
            shift_en <= '1';
            WAIT UNTIL rising_edge(clk);
            shift_en <= '0';
            WAIT FOR 4.3 us;
        END LOOP;
        WAIT;
    END PROCESS;

END ARCHITECTURE;