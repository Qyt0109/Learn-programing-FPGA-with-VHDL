LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ALU_Case1 IS
    GENERIC (
        NUMBER_OF_BIT : POSITIVE := 4
    );
    PORT (
        INPUT_A, INPUT_B : IN STD_LOGIC_VECTOR(NUMBER_OF_BIT - 1 DOWNTO 0);
        SELECT_S : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        OUTPUT_F : OUT STD_LOGIC_VECTOR(NUMBER_OF_BIT - 1 DOWNTO 0)
    );
END ENTITY ALU_Case1;

ARCHITECTURE rtl OF ALU_Case1 IS
BEGIN
    processALU : PROCESS (INPUT_A, INPUT_B, SELECT_S)
    BEGIN
        CASE SELECT_S IS
            WHEN "000" =>
                OUTPUT_F <= STD_LOGIC_VECTOR(signed(INPUT_A) + signed(INPUT_B));
            WHEN "001" =>
                OUTPUT_F <= STD_LOGIC_VECTOR(signed(INPUT_A) - signed(INPUT_B));
            WHEN "010" =>
                OUTPUT_F <= STD_LOGIC_VECTOR(signed(INPUT_A) MOD signed(INPUT_B));
            WHEN "100" =>
                OUTPUT_F <= INPUT_A AND INPUT_B;
            WHEN "101" =>
                OUTPUT_F <= INPUT_A OR INPUT_B;
            WHEN "111" =>
                OUTPUT_F <= INPUT_A XOR INPUT_B;
            WHEN OTHERS =>
                OUTPUT_F <= (OTHERS => 'X');
        END CASE;
    END PROCESS;
END ARCHITECTURE;