LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MixColumns_tb IS
END ENTITY;

ARCHITECTURE rtl OF MixColumns_tb IS
    COMPONENT MixColumns IS
        PORT (
            input_state : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
            output_state : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL input_state, output_state : STD_LOGIC_VECTOR(127 DOWNTO 0);
BEGIN
    MixColumns_inst : MixColumns
    PORT MAP(
        input_state => input_state,
        output_state => output_state
    );
    processTest : PROCESS
    BEGIN
        -- Output should be 591ceea1 c28636d1 caddaf02 4a27dca2
        input_state <= x"637bc0d2_7b76d27c_76757cc5_7563c5c0";
        WAIT;
    END PROCESS;
END ARCHITECTURE;