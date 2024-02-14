LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY AESEncrypt IS
    PORT (
        clk : IN STD_LOGIC;
        input_data : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        key : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        output_data : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF AESEncrypt IS
    COMPONENT EncryptRound IS
        PORT (
            input_state : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
            round_key : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
            output_state : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
        );
    END COMPONENT;
    component AddRoundKey IS
    PORT (
        input_state : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        round_key : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        output_state : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
    END component;
BEGIN
    
END ARCHITECTURE;