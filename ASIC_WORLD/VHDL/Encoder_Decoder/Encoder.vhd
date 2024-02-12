LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Encoder IS
    PORT (
        en : IN STD_LOGIC; -- enable
        i : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- input
        o : OUT STD_LOGIC_VECTOR(1 DOWNTO 0) -- output
    );
END ENTITY;

ARCHITECTURE rtl OF Encoder IS

BEGIN

    processEncode : PROCESS (en, i)
    BEGIN
        IF (en = '1') THEN
            CASE(i) IS
                WHEN "0001" =>
                o <= "00";
                WHEN "0010" =>
                o <= "01";
                WHEN "0100" =>
                o <= "10";
                WHEN "1000" =>
                o <= "11";
                WHEN OTHERS =>
                o <= "00";
            END CASE;
        END IF;
    END PROCESS;

END ARCHITECTURE;