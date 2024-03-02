LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY InvSubByte IS
    PORT (
        input_state : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        output_state : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF InvSubByte IS
BEGIN
    generateInvSBoxes : FOR byte_index IN 0 TO 15 GENERATE
        InvSBox_inst : ENTITY work.InvSBox
            PORT MAP(
                input_byte => input_state((byte_index + 1) * 8 - 1 DOWNTO byte_index * 8),
                output_byte => output_state((byte_index + 1) * 8 - 1 DOWNTO byte_index * 8)
            );
    END GENERATE;
END ARCHITECTURE;