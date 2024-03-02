LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Encoder_tb IS
END ENTITY;

ARCHITECTURE rtl OF Encoder_tb IS
    -- Components
    COMPONENT Encoder IS
        PORT (
            en : IN STD_LOGIC; -- enable
            i : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- input
            o : OUT STD_LOGIC_VECTOR(1 DOWNTO 0) -- output
        );
    END COMPONENT;
    -- Signals
    SIGNAL en : STD_LOGIC;
    SIGNAL i : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL o : STD_LOGIC_VECTOR(1 DOWNTO 0);
BEGIN
    Encoder_inst : Encoder
    PORT MAP(
        en => en,
        i => i,
        o => o
    );
    processTest : PROCESS
    BEGIN
        -- run 1000 ns
        -- Disable by default
        en <= '0';
        WAIT FOR 100 ns;
        -- Test change inputs while still disable
        i <= "0001";
        WAIT FOR 100 ns;
        -- Enable decoder
        en <= '1';
        -- Test cases
        i <= "0000";
        WAIT FOR 100 ns;
        i <= "0111";
        WAIT FOR 100 ns;
        i <= "0001";
        WAIT FOR 100 ns;
        i <= "0010";
        WAIT FOR 100 ns;
        i <= "0100";
        WAIT FOR 100 ns;
        i <= "1000";
        WAIT FOR 100 ns;
        -- Disable decoder
        en <= '0';
        WAIT FOR 100 ns;
        -- Test change inputs while still disable
        i <= "0001";
        WAIT;
    END PROCESS;

END ARCHITECTURE;