LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY SBox_tb IS
END ENTITY;

ARCHITECTURE rtl OF SBox_tb IS
    SIGNAL input_byte, output_byte : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
    SBox_inst : ENTITY work.SBox
        PORT MAP(
            input_byte => input_byte,
            output_byte => output_byte
        );
    processTest : PROCESS
    BEGIN
        -- 63
        input_byte <= x"00";
        WAIT FOR 20 ns;
        -- 77
        input_byte <= x"02";
        WAIT FOR 20 ns;
        -- 30
        input_byte <= x"08";
        WAIT FOR 20 ns;
        -- 67
        input_byte <= x"0a";
        WAIT FOR 20 ns;
        -- d7
        input_byte <= x"0d";
        WAIT;
    END PROCESS;
END ARCHITECTURE;