LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY AddRoundKey IS
    PORT (
        input_state : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        key : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        output_state : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF AddRoundKey IS
BEGIN
    output_state <= input_state XOR key;
END ARCHITECTURE;