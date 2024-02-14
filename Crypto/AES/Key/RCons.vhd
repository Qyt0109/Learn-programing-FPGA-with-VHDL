-- 01 02 04 08 10 20 40 80 1B 36

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE pkg_rcon IS
    TYPE type_round_rcons IS ARRAY(1 TO 10) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
END PACKAGE;

USE work.pkg_rcon.type_round_rcons;
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY RCons IS
    PORT (
        round_rcons : OUT type_round_rcons
    );
END ENTITY;

ARCHITECTURE rtl OF RCons IS
    TYPE RConArray IS ARRAY (1 TO 10) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    CONSTANT RConLUT : RConArray := (
        1 => x"01", 2 => x"02", 3 => x"04", 4 => x"08", 5 => x"10",
        6 => x"20", 7 => x"40", 8 => x"80", 9 => x"1B", 10 => x"36"
    );
BEGIN
    generateRCons : FOR round_index IN 1 TO 10 GENERATE
        round_rcons(round_index) <= RConLUT(round_index) & x"000000";
    END GENERATE;
END ARCHITECTURE;