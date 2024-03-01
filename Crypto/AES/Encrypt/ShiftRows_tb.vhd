LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ShiftRows_tb IS
END ENTITY;

ARCHITECTURE rtl OF ShiftRows_tb IS
    SIGNAL input_state, output_state : STD_LOGIC_VECTOR(127 DOWNTO 0);
BEGIN
    ShiftRows_imst : ENTITY work.ShiftRows
        PORT MAP(
            input_state => input_state,
            output_state => output_state
        );
    processTest : PROCESS
    BEGIN
        -- 637bc0d2 7b76d27c 76757cc5 7563c5c0
        input_state <= x"63637c7c_7b7bc5c5_7676c0c0_7575d2d2";
        WAIT;
    END PROCESS;
END ARCHITECTURE;