LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY InvSubByte_tb IS
END ENTITY;

ARCHITECTURE rtl OF InvSubByte_tb IS
    SIGNAL input_state, output_state : STD_LOGIC_VECTOR(127 DOWNTO 0);
BEGIN
    invsubbyte_inst : ENTITY work.InvSubByte
        PORT MAP(
            input_state => input_state,
            output_state => output_state
        );

    processTest : PROCESS
    BEGIN
        input_state <= x"73d99473763e2968100c7ffc9b4bd9d2"; -- 8fe5e78f0fd14cf77c816b55e8cce57f
        WAIT FOR 30 ns;
        input_state <= x"a7d07e6c34c5a3494c141c6788b3bd23"; -- 89608ab8280771a45d9bc40a974bcd32
        WAIT FOR 30 ns;
        input_state <= x"d5ff5e13d4d0c04d76729f8468cbfe4d"; -- b57d9d8219601f650f1e6e4ff7590c65
        WAIT FOR 30 ns;
        WAIT;
    END PROCESS;
END ARCHITECTURE;