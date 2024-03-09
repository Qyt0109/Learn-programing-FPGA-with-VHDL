LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY majority IS
    GENERIC (
        NUMBER_OF_BITS : NATURAL := 5
    );
    PORT (
        x : IN STD_LOGIC_VECTOR(NUMBER_OF_BITS - 1 DOWNTO 0);
        f : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE rtl OF majority IS
BEGIN
    PROCESS (x)
        VARIABLE count : NATURAL RANGE 0 TO 8;
    BEGIN
        count := 0;
        loopCount : FOR bit_index IN 0 TO NUMBER_OF_BITS - 1 LOOP
            IF (x(bit_index) = '1') THEN
                count := count + 1;
            END IF;
        END LOOP;
        IF count > NUMBER_OF_BITS / 2 THEN
            f <= '1';
        ELSE
            f <= '0';
        END IF;
    END PROCESS;
END ARCHITECTURE;