LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY GF2MultiplyBy8 IS
    PORT (
        input_byte : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        output_byte : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF GF2MultiplyBy8 IS
    SIGNAL connection_byte : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
    GF2MultiplyBy4_inst0 : ENTITY work.GF2MultiplyBy4
        PORT MAP(
            input_byte => input_byte,
            output_byte => connection_byte
        );
    GF2MultiplyBy4_inst1 : ENTITY work.GF2MultiplyBy4
        PORT MAP(
            input_byte => connection_byte,
            output_byte => output_byte
        );
END ARCHITECTURE;