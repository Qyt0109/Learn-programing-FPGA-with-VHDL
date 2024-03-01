LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY SubByte_tb IS
END ENTITY;

ARCHITECTURE rtl OF SubByte_tb IS
    SIGNAL input_state, output_state : STD_LOGIC_VECTOR(127 DOWNTO 0);
BEGIN
    SubByte_inst : ENTITY work.SubByte
        PORT MAP(
            input_state => input_state,
            output_state => output_state
        );
    processTest : PROCESS
    BEGIN
        -- 63637c7c7b7bc5c57676c0c07575d2d2
        input_state <= x"00000101030307070f0f1f1f3f3f7f7f";
        WAIT FOR 30 ns;
        -- e2d25d25e0d9fc37c2ae4bef341b0878
        input_state <= x"3b7f8dc2a0e555b2a8becc612844bfc1";
        WAIT FOR 30 ns;
        -- c5387a908eef74ff1a653a65dfcd48a4
        input_state <= x"0776bd96e661ca7d43bca2bcef80d41d";
        WAIT;
    END PROCESS;
END ARCHITECTURE;