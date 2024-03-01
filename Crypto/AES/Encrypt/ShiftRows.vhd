LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ShiftRows IS
    PORT (
        input_state : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        output_state : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF ShiftRows IS
BEGIN
    -- row 0
    output_state(127 DOWNTO 120) <= input_state(127 DOWNTO 120);
    output_state(95 DOWNTO 88) <= input_state(95 DOWNTO 88);
    output_state(63 DOWNTO 56) <= input_state(63 DOWNTO 56);
    output_state(31 DOWNTO 24) <= input_state(31 DOWNTO 24);

    -- row 1
    output_state(119 DOWNTO 112) <= input_state(87 DOWNTO 80);
    output_state(87 DOWNTO 80) <= input_state(55 DOWNTO 48);
    output_state(55 DOWNTO 48) <= input_state(23 DOWNTO 16);
    output_state(23 DOWNTO 16) <= input_state(119 DOWNTO 112);

    -- row 2
    output_state(111 DOWNTO 104) <= input_state(47 DOWNTO 40);
    output_state(79 DOWNTO 72) <= input_state(15 DOWNTO 8);
    output_state(47 DOWNTO 40) <= input_state(111 DOWNTO 104);
    output_state(15 DOWNTO 8) <= input_state(79 DOWNTO 72);

    -- row 3
    output_state(103 DOWNTO 96) <= input_state(7 DOWNTO 0);
    output_state(71 DOWNTO 64) <= input_state(103 DOWNTO 96);
    output_state(39 DOWNTO 32) <= input_state(71 DOWNTO 64);
    output_state(7 DOWNTO 0) <= input_state(39 DOWNTO 32);
END ARCHITECTURE;