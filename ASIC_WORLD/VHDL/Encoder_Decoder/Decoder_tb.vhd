LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Decoder_tb IS
END ENTITY;

ARCHITECTURE rtl OF Decoder_tb IS
    -- Components
    COMPONENT Decoder IS
        PORT (
            en : IN STD_LOGIC; -- enable
            i : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- input
            o : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) -- output
        );
    END COMPONENT;
    -- Signals
    SIGNAL en : STD_LOGIC;
    SIGNAL i : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL o : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
    Decoder_inst : Decoder
    PORT MAP(
        en => en,
        i => i,
        o => o
    );
    processTest : PROCESS
    BEGIN
        -- run 800 ns
        -- Disable by default
        en <= '0';
        WAIT FOR 100 ns;
        -- Test change inputs while still disable
        i <= "01";
        WAIT FOR 100 ns;
        -- Enable decoder
        en <= '1';
        -- Test cases
        i <= "00";
        WAIT FOR 100 ns;
        i <= "01";
        WAIT FOR 100 ns;
        i <= "10";
        WAIT FOR 100 ns;
        i <= "11";
        WAIT FOR 100 ns;
        -- Disable decoder
        en <= '0';
        WAIT FOR 100 ns;
        -- Test change inputs while still disable
        i <= "01";
        WAIT;
    END PROCESS;
END ARCHITECTURE;