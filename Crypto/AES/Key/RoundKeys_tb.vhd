LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.aes_data_types.all;

ENTITY RoundKeys_tb IS
END ENTITY;

ARCHITECTURE rtl OF RoundKeys_tb IS
    SIGNAL key : STD_LOGIC_VECTOR(127 DOWNTO 0);
    SIGNAL round_keys : word_vector(1 to 10);
begin
    RoundKeys_inst : entity work.RoundKeys
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