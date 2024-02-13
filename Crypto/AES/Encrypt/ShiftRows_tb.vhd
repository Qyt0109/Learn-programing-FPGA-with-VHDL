LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ShiftRows_tb IS
END ENTITY;

ARCHITECTURE rtl OF ShiftRows_tb IS
    COMPONENT ShiftRows IS
        PORT (
            input_state : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
            output_state : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL input_state : STD_LOGIC_VECTOR(127 DOWNTO 0);
    SIGNAL output_state : STD_LOGIC_VECTOR(127 DOWNTO 0);
BEGIN
    ShiftRows_imst : ShiftRows
    PORT MAP(
        input_state => input_state,
        output_state => output_state
    );
    processTest : process
    begin
        input_state <= x"DDCCBBAADDCCBBAADDCCBBAADDCCBBAA";
        wait;
    end process;
END ARCHITECTURE;