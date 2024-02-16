LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.aes_data_types.word_vector;

ENTITY RCons_tb IS
END ENTITY;

ARCHITECTURE rtl OF RCons_tb IS
    SIGNAL round_rcons : word_vector(1 to 10);
BEGIN
    RCons_inst : entity work.RCons
    PORT MAP(
        round_rcons => round_rcons
    );
    processTest : PROCESS
    BEGIN
        WAIT;
    END PROCESS;
END ARCHITECTURE;