LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY giaima7thanh_topmodule IS
  GENERIC (
    NUMBER_OF_LED : POSITIVE := 4
  );
  PORT (
    input : IN STD_LOGIC_VECTOR(NUMBER_OF_LED * 4 - 1 DOWNTO 0);
    output : OUT STD_LOGIC_VECTOR(NUMBER_OF_LED * 7 - 1 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE rtl OF giaima7thanh_topmodule IS
BEGIN
  generate7SegLed : FOR led_index IN 0 TO NUMBER_OF_LED - 1 GENERATE
    giaima7thanh_inst : ENTITY work.giaima7thanh
      PORT MAP(
        input => input((led_index + 1) * 4 - 1 DOWNTO led_index * 4),
        output => output((led_index + 1) * 7 - 1 DOWNTO led_index * 7)
      );
  END GENERATE;
END ARCHITECTURE;