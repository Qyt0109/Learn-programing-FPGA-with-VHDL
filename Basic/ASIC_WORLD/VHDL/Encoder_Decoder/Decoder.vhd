LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Decoder IS
    PORT (
        en : IN STD_LOGIC; -- enable
        i : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- input
        o : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) -- output
    );
END ENTITY;

ARCHITECTURE rtl OF Decoder IS

BEGIN

    processDecode : PROCESS (en, i)
    BEGIN
        IF (en = '1') THEN
            CASE(i) IS
                WHEN "00" =>
                o <= "0001";
                WHEN "01" =>
                o <= "0010";
                WHEN "10" =>
                o <= "0100";
                WHEN "11" =>
                o <= "1000";
                WHEN OTHERS =>
                o <= "0000";
            END CASE;
        END IF;
    END PROCESS;

END ARCHITECTURE;