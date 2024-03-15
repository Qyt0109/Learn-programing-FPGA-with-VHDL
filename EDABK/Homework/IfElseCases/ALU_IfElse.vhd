LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ALU_IfElse IS
    GENERIC (
        NUMBER_OF_BIT : POSITIVE := 4
    );
    PORT (
        INPUT_A, INPUT_B : IN STD_LOGIC_VECTOR(NUMBER_OF_BIT - 1 DOWNTO 0);
        SELECT_S : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        OUTPUT_F : OUT STD_LOGIC_VECTOR(NUMBER_OF_BIT - 1 DOWNTO 0)
    );
END ENTITY ALU_IfElse;

ARCHITECTURE rtl OF ALU_IfElse IS
BEGIN
    processALU : PROCESS (INPUT_A, INPUT_B, SELECT_S)
    BEGIN
        IF SELECT_S = "000" THEN
            OUTPUT_F <= STD_LOGIC_VECTOR(signed(INPUT_A) + signed(INPUT_B));
        ELSIF SELECT_S = "001" THEN
            OUTPUT_F <= STD_LOGIC_VECTOR(signed(INPUT_A) - signed(INPUT_B));
        ELSIF SELECT_S = "010" THEN
            OUTPUT_F <= STD_LOGIC_VECTOR(signed(INPUT_A) MOD signed(INPUT_B));
        ELSIF SELECT_S = "100" THEN
            OUTPUT_F <= INPUT_A AND INPUT_B;
        ELSIF SELECT_S = "101" THEN
            OUTPUT_F <= INPUT_A OR INPUT_B;
        ELSIF SELECT_S = "111" THEN
            OUTPUT_F <= INPUT_A XOR INPUT_B;
        ELSE
            OUTPUT_F <= (OTHERS => 'X');
        END IF;
    END PROCESS;
END ARCHITECTURE;