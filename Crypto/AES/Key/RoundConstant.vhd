-- 01 02 04 08 10 20 40 80 1B 36

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY RoundConstant IS
    PORT (
        round_index : IN integer;
        round_constant_word : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF RoundConstant IS
BEGIN
    processRoundConstant : PROCESS (round_index)
    BEGIN
        CASE round_index IS
            WHEN 1 =>
                round_constant_word(31 DOWNTO 24) <= x"01";
            WHEN 2 =>
                round_constant_word(31 DOWNTO 24) <= x"02";
            WHEN 3 =>
                round_constant_word(31 DOWNTO 24) <= x"04";
            WHEN 4 =>
                round_constant_word(31 DOWNTO 24) <= x"08";
            WHEN 5 =>
                round_constant_word(31 DOWNTO 24) <= x"10";
            WHEN 6 =>
                round_constant_word(31 DOWNTO 24) <= x"20";
            WHEN 7 =>
                round_constant_word(31 DOWNTO 24) <= x"40";
            WHEN 8 =>
                round_constant_word(31 DOWNTO 24) <= x"80";
            WHEN 9 =>
                round_constant_word(31 DOWNTO 24) <= x"1B";
            WHEN 10 =>
                round_constant_word(31 DOWNTO 24) <= x"36";
            WHEN OTHERS =>
                round_constant_word(31 DOWNTO 24) <= x"00";
        END CASE;
    END PROCESS;
    round_constant_word(23 DOWNTO 0) <= x"000000";
END ARCHITECTURE;