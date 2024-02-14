LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.pkg_round_keys.type_round_keys;

ENTITY RoundKeys_tb IS
END ENTITY;

ARCHITECTURE rtl OF RoundKeys_tb IS
    COMPONENT RoundKeys IS
        PORT (
            key : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
            round_keys : OUT type_round_keys
        );
    END COMPONENT;
    SIGNAL key : STD_LOGIC_VECTOR(127 DOWNTO 0);
    SIGNAL round_keys : type_round_keys;
begin
    RoundKeys_inst : RoundKeys
    port map (
        key => key,
        round_keys => round_keys
    );
    processTest:process
    begin
        key <= x"09cf4f3cabf7158828aed2a62b7e1516";
        wait;
    end process;
END ARCHITECTURE;