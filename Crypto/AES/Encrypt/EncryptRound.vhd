LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY EncryptRound IS
    PORT (
        input_state : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        round_key : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        is_last_round : IN STD_LOGIC;
        output_state : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF EncryptRound IS
    SIGNAL sub_byte_out, shift_rows_out, mix_columns_in, mix_columns_out, add_round_key_in : STD_LOGIC_VECTOR(127 DOWNTO 0);
BEGIN
    SubByte_inst : ENTITY work.SubByte
        PORT MAP(
            input_state => input_state,
            output_state => sub_byte_out
        );
    ShiftRows_imst : ENTITY work.ShiftRows
        PORT MAP(
            input_state => sub_byte_out,
            output_state => shift_rows_out
        );
    MixColumns_inst : ENTITY work.MixColumns
        PORT MAP(
            input_state => mix_columns_in,
            output_state => mix_columns_out
        );
    AddRoundKey_inst : ENTITY work.AddRoundKey
        PORT MAP(
            input_state => add_round_key_in,
            round_key => round_key,
            output_state => output_state
        );

        add_round_key_in <= shift_rows_out when is_last_round = '1' else mix_columns_out;
        mix_columns_in <= shift_rows_out when is_last_round = '0';
END ARCHITECTURE;