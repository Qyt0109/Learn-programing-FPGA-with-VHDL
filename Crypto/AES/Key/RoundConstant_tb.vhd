LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY RoundConstant_tb IS
END ENTITY;

ARCHITECTURE rtl OF RoundConstant_tb IS
    SIGNAL round_index : NATURAL;
    SIGNAL round_constant_word : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
    RoundConstant_inst : ENTITY work.RoundConstant
        PORT MAP(
            round_index => round_index,
            round_constant_word => round_constant_word
        );
    processTest : PROCESS
    BEGIN
        loopTest : FOR r_index IN 0 TO 13 LOOP
            round_index <= r_index;
            WAIT FOR 5 ns;
        END LOOP;
        WAIT;
    END PROCESS;
END ARCHITECTURE;