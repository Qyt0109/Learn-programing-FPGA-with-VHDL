LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE aes_data_types IS
    TYPE word_vector IS ARRAY(NATURAL RANGE <>) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
    TYPE block_vector IS ARRAY(NATURAL RANGE <>) OF STD_LOGIC_VECTOR(127 DOWNTO 0);
    TYPE column_cells IS ARRAY(0 TO 3) OF STD_LOGIC_VECTOR(7 DOWNTO 0); -- column = cell0 cell1 cell2 cell3
END PACKAGE;