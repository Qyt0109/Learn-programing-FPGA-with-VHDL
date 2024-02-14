LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY EncryptRound IS
    PORT (
        input_state : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        round_key : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        output_state : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF EncryptRound IS
    COMPONENT SubByte IS
        PORT (
            input_state : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
            output_state : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
        );
    END COMPONENT;
    COMPONENT ShiftRows IS
        PORT (
            input_state : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
            output_state : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
        );
    END COMPONENT;
    COMPONENT MixColumns IS
        PORT (
            input_state : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
            output_state : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
        );
    END COMPONENT;
    COMPONENT AddRoundKey IS
        PORT (
            input_state : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
            round_key : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
            output_state : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
        );
    END COMPONENT;
    signal sub_byte, shift_rows, mix_columns : STD_LOGIC_VECTOR(127 DOWNTO 0);
BEGIN
    SubByte_inst : SubByte
    PORT MAP(
        input_state => input_state,
        output_state => sub_byte
    );
    ShiftRows_imst : ShiftRows
    PORT MAP(
        input_state => sub_byte,
        output_state => shift_rows
    );
    MixColumns_inst : MixColumns
    PORT MAP(
        input_state => shift_rows,
        output_state => mix_columns
    );
    AddRoundKey_inst : AddRoundKey
    PORT MAP(
        input_state => mix_columns,
        round_key => round_key,
        output_state => output_state
    );
END ARCHITECTURE;