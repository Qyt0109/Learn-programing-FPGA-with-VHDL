LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ALU_tb IS
    GENERIC (
        NUMBER_OF_BIT : POSITIVE := 4
    );
END ENTITY;

ARCHITECTURE rtl OF ALU_tb IS
    SIGNAL INPUT_A, INPUT_B : STD_LOGIC_VECTOR(NUMBER_OF_BIT - 1 DOWNTO 0);
    SIGNAL SELECT_S : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL OUTPUT_F : STD_LOGIC_VECTOR(NUMBER_OF_BIT - 1 DOWNTO 0);
    CONSTANT CLK_PERIOD : TIME := 10 ns;
BEGIN
    alu1_inst : ENTITY work.ALU_NestedIfElse
        GENERIC MAP(
            NUMBER_OF_BIT => NUMBER_OF_BIT
        )
        PORT MAP(
            INPUT_A => INPUT_A,
            INPUT_B => INPUT_B,
            SELECT_S => SELECT_S,
            OUTPUT_F => OUTPUT_F
        );
    processTest : PROCESS
    BEGIN
        INPUT_A <= "0100";
        INPUT_B <= "1101";
        loopTest : FOR select_value IN 0 TO 7 LOOP
            SELECT_S <= STD_LOGIC_VECTOR(to_unsigned(select_value, SELECT_S'length));
            WAIT FOR CLK_PERIOD;
        END LOOP;
        WAIT;
    END PROCESS;
END ARCHITECTURE;