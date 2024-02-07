LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Serialiser_tb IS
    GENERIC (
        DATA_WIDTH : INTEGER := 8;
        DEFAULT_STATE : STD_LOGIC := '1'
    );
END ENTITY;

ARCHITECTURE rtl OF Serialiser_tb IS

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
    -- Signals
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL rst : STD_LOGIC;
    SIGNAL shift_en : STD_LOGIC;
    SIGNAL load : STD_LOGIC;
    SIGNAL data_in : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL data_out : STD_LOGIC;
BEGIN
    clk <= NOT clk AFTER 10 ns; -- Simulate the 50MHz clock input

    Serialiser_inst : Serialiser
    GENERIC MAP(
        DATA_WIDTH => DATA_WIDTH,
        DEFAULT_STATE => DEFAULT_STATE
    )
    PORT MAP(
        clk => clk,
        rst => rst,
        shift_en => shift_en,
        load => load,
        data_in => data_in,
        data_out => data_out
    );
    -- Process
    processTest : PROCESS
    BEGIN
        -- init
        rst <= '1';
        shift_en <= '0';
        load <= '0';
        data_in <= (OTHERS => '0');
        WAIT FOR 100 ns;
        rst <= '0';
        WAIT FOR 100 ns;

        -- load a data (69h)
        WAIT UNTIL rising_edge(clk);
        load <= '1';
        data_in <= x"69"; -- 0x01101001
        WAIT UNTIL rising_edge(clk);
        load <= '0';
        data_in <= (OTHERS => '0');
        FOR i IN 0 TO 7 LOOP
            WAIT FOR 8.7 us;
            WAIT UNTIL rising_edge(clk);
            shift_en <= '1';
            WAIT UNTIL rising_edge(clk);
            shift_en <= '0';
        END LOOP;

        WAIT; -- 1 time process
    END PROCESS;
END ARCHITECTURE rtl;