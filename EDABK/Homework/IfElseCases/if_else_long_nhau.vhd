LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY if_else_long_nhau IS
    PORT (
        a, b : IN INTEGER RANGE -8 TO 7;
        s1, s2 : IN STD_LOGIC;
        y : OUT INTEGER RANGE -8 TO 7
    );
END ENTITY;

ARCHITECTURE rtl OF if_else_long_nhau IS
BEGIN
    processCheck : PROCESS (a, b, s1, s2)
    BEGIN
        IF (s1 = '0') THEN
            y <= a + b;
        ELSIF (s2 = '0') THEN
            y <= a - b;
        ELSE
            y <= a * b;
        END IF;
    END PROCESS;
END ARCHITECTURE;