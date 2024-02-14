LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY SubByte_tb IS
END ENTITY;

ARCHITECTURE rtl OF SubByte_tb IS
    COMPONENT SubByte IS
        PORT (
            input_state : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
            output_state : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL input_state, output_state : STD_LOGIC_VECTOR(127 DOWNTO 0);
    signal test_output : STD_LOGIC_VECTOR(127 DOWNTO 0);
    SIGNAL is_test_true : STD_LOGIC;
BEGIN
    SubByte_inst : SubByte
    PORT MAP(
        input_state => input_state,
        output_state => output_state
    );
    processCheck : PROCESS (output_state)
    BEGIN
        IF output_state = test_output THEN
            is_test_true <= '1';
        ELSE
            is_test_true <= '0';
        END IF;
    END PROCESS;
    processTest : PROCESS
    BEGIN
        input_state <= x"00000101030307070f0f1f1f3f3f7f7f";
        test_output <= x"63637c7c7b7bc5c57676c0c07575d2d2";
        WAIT FOR 30 ns;
        input_state <= x"3b7f8dc2a0e555b2a8becc612844bfc1";
        test_output <= x"e2d25d25e0d9fc37c2ae4bef341b0878";
        wait for 30 ns;
        input_state <= x"0776bd96e661ca7d43bca2bcef80d41d";
        test_output <= x"c5387a908eef74ff1a653a65dfcd48a4";
        WAIT;
    END PROCESS;
END ARCHITECTURE;