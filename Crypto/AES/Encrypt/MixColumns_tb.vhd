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
    signal input_state, output_state : STD_LOGIC_VECTOR(127 DOWNTO 0);
BEGIN
    MixColumns_inst : MixColumns
    port map (
        input_state=>input_state,
        output_state => output_state
    );
    processTest:process
    begin
        -- Output should be 591ceea1c28636d1caddaf024a27dca2
        input_state <= x"305dbfd4305dbfd4305dbfd4305dbfd4";
        wait;
    end process;
END ARCHITECTURE;