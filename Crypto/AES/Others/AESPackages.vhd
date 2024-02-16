LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE aes_data_types IS
    TYPE word_vector IS ARRAY(natural range<>) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
    TYPE block_vector IS ARRAY(natural range<>) OF STD_LOGIC_VECTOR(127 DOWNTO 0);
END PACKAGE;