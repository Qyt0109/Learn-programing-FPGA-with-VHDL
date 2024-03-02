LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY giaima7thanh_tb IS
END ENTITY;

ARCHITECTURE rtl OF giaima7thanh_tb IS
    SIGNAL input : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL output : STD_LOGIC_VECTOR(6 DOWNTO 0);
    CONSTANT CLK_PERIOD : TIME := 10 ns;
BEGIN
    giaima7thanh_inst : ENTITY work.giaima7thanh
        PORT MAP(
            input => input,
            output => output
        );
    processTest : PROCESS
    BEGIN
        loopTest : FOR input_value IN 0 TO 15 LOOP
            input <= STD_LOGIC_VECTOR(to_unsigned(input_value, input'length));
            WAIT FOR CLK_PERIOD;
        END LOOP;
        WAIT;
    END PROCESS;
END ARCHITECTURE;