LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Parity_tb IS
    GENERIC (
        DATA_WIDTH : INTEGER := 4
    );
END ENTITY;

ARCHITECTURE rtl OF Parity_tb IS
    COMPONENT Parity IS
        GENERIC (
            DATA_WIDTH : INTEGER
        );
        PORT (
            data : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            parity : OUT STD_LOGIC
        );
    END COMPONENT;
    SIGNAL data : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL parity_out : STD_LOGIC;
BEGIN
    Parity_inst : Parity
    GENERIC MAP(
        DATA_WIDTH => DATA_WIDTH
    )
    PORT MAP(
        data => data,
        parity => parity_out
    );
    processTest : PROCESS
    BEGIN
        data <= "0011";
        WAIT FOR 100 ns;
        data <= "1101";
        WAIT FOR 100 ns;
        data <= "0100";
        WAIT;
    END PROCESS;
END ARCHITECTURE;