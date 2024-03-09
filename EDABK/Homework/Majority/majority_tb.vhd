LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY majority_tb IS
    GENERIC (
        NUMBER_OF_BITS : POSITIVE := 5
    );
END ENTITY;

ARCHITECTURE rtl OF majority_tb IS
    SIGNAL x : STD_LOGIC_VECTOR(NUMBER_OF_BITS - 1 DOWNTO 0);
    SIGNAL f : STD_LOGIC;
    CONSTANT CLK_PERIOD : TIME := 10 ns;
BEGIN
    majority_inst : ENTITY work.majority
        GENERIC MAP(
            NUMBER_OF_BITS => NUMBER_OF_BITS
        )
        PORT MAP(
            x => x,
            f => f
        );
    processTest : PROCESS
    BEGIN
        loopTest : FOR x_value IN 0 TO 2 ** NUMBER_OF_BITS - 1 LOOP
            x <= STD_LOGIC_VECTOR(to_unsigned(x_value, x'length));
            WAIT FOR CLK_PERIOD;
        END LOOP;
        WAIT;
    END PROCESS;
END ARCHITECTURE;