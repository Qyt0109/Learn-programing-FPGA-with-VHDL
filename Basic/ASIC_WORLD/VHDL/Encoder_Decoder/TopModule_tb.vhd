LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY TopModule_tb IS
END ENTITY;

ARCHITECTURE rtl OF TopModule_tb IS
    -- Components
    COMPONENT TopModule IS
        PORT (
            -- inputs
            en : IN STD_LOGIC;
            i : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- input
            -- outputs
            o : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) -- output
        );
    END COMPONENT;
    -- Signals
    SIGNAL en : STD_LOGIC;
    SIGNAL i : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL o : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
    TopModule_inst : TopModule
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