LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ALU_CaseIfElse2 IS
    GENERIC (
        NUMBER_OF_BIT : POSITIVE := 4
    );
    PORT (
        INPUT_A, INPUT_B : IN STD_LOGIC_VECTOR(NUMBER_OF_BIT - 1 DOWNTO 0);
        SELECT_S : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        OUTPUT_F : OUT STD_LOGIC_VECTOR(NUMBER_OF_BIT - 1 DOWNTO 0)
    );
END ENTITY ALU_CaseIfElse2;

ARCHITECTURE rtl OF ALU_CaseIfElse2 IS
BEGIN
    processALU : PROCESS (INPUT_A, INPUT_B, SELECT_S)
    BEGIN
        CASE SELECT_S(2) IS
            WHEN '0' =>
                IF SELECT_S(1 DOWNTO 0) = "00" THEN
                    OUTPUT_F <= STD_LOGIC_VECTOR(signed(INPUT_A) + signed(INPUT_B));
                ELSIF SELECT_S(1 DOWNTO 0) = "01" THEN
                    OUTPUT_F <= STD_LOGIC_VECTOR(signed(INPUT_A) + signed(INPUT_B));
                ELSIF SELECT_S(1 DOWNTO 0) = "10" THEN
                    OUTPUT_F <= STD_LOGIC_VECTOR(signed(INPUT_A) MOD signed(INPUT_B));
                ELSE
                    OUTPUT_F <= (OTHERS => 'X');
                END IF;
            WHEN '1' =>
                IF SELECT_S(1 DOWNTO 0) = "00" THEN
                    OUTPUT_F <= INPUT_A AND INPUT_B;
                ELSIF SELECT_S(1 DOWNTO 0) = "01" THEN
                    OUTPUT_F <= INPUT_A OR INPUT_B;
                ELSIF SELECT_S(1 DOWNTO 0) = "11" THEN
                    OUTPUT_F <= INPUT_A XOR INPUT_B;
                ELSE
                    OUTPUT_F <= (OTHERS => 'X');
                END IF;
            WHEN OTHERS =>
                OUTPUT_F <= (OTHERS => 'X');
        END CASE;
    END PROCESS;
END ARCHITECTURE;