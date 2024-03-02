LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY InvShiftRows_tb IS
END ENTITY;

ARCHITECTURE rtl OF InvShiftRows_tb IS
    SIGNAL input_state, output_state : STD_LOGIC_VECTOR(127 DOWNTO 0);
BEGIN
    invshiftrows_inst : ENTITY work.InvShiftRows
        PORT MAP(
            input_state => input_state,
            output_state => output_state
        );
    processTest : PROCESS
    BEGIN
        -- 63637c7c 7b7bc5c5 7676c0c0 7575d2d2
        input_state <= x"637bc0d2_7b76d27c_76757cc5_7563c5c0";
        wait;
    END PROCESS;
END ARCHITECTURE;