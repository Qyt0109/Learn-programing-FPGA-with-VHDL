LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY TopModule IS
    PORT (
        -- inputs
        en : IN STD_LOGIC;
        i : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- input
        -- outputs
        o : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) -- output
    );
END ENTITY;

ARCHITECTURE rtl OF TopModule IS
    -- Components
    COMPONENT Encoder IS
        PORT (
            en : IN STD_LOGIC; -- enable
            i : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- input
            o : OUT STD_LOGIC_VECTOR(1 DOWNTO 0) -- output
        );
    END COMPONENT;
    COMPONENT Decoder IS
        PORT (
            en : IN STD_LOGIC; -- enable
            i : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- input
            o : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) -- output
        );
    END COMPONENT;
    -- Signals
    SIGNAL signal_o : STD_LOGIC_VECTOR(1 DOWNTO 0);
BEGIN
    Encoder_inst : Encoder
    PORT MAP(
        en => en,
        i => i,
        o => signal_o
    );
    Decoder_inst : Decoder
    PORT MAP(
        en => en,
        i => signal_o,
        o => o
    );
END ARCHITECTURE;