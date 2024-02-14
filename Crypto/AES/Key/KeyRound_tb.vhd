LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY KeyRound_tb IS
END ENTITY;

ARCHITECTURE rtl OF KeyRound_tb IS
    COMPONENT KeyRound IS
        PORT (
            input_round_key : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
            round_rcon : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            output_round_key : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL input_round_key, output_round_key : STD_LOGIC_VECTOR(127 DOWNTO 0);
    signal round_rcon : std_logic_vector(31 downto 0);
BEGIN
    KeyRound_inst : KeyRound
    PORT MAP(
        input_round_key => input_round_key,
        round_rcon => round_rcon,
        output_round_key => output_round_key
    );
    processTest : process
    begin
        -- 01 02 04 08 10 20 40 80 1B 36
        input_round_key <= x"09cf4f3cabf7158828aed2a62b7e1516";
        round_rcon <= x"01000000";
        wait for 10 ns;
        input_round_key <= output_round_key;
        round_rcon <= x"02000000";
        wait for 10 ns;
        input_round_key <= output_round_key;
        round_rcon <= x"04000000";
        wait for 10 ns;
        input_round_key <= output_round_key;
        round_rcon <= x"08000000";
        wait for 10 ns;
        input_round_key <= output_round_key;
        round_rcon <= x"10000000";
        wait for 10 ns;
        input_round_key <= output_round_key;
        round_rcon <= x"20000000";
        wait for 10 ns;
        input_round_key <= output_round_key;
        round_rcon <= x"40000000";
        wait for 10 ns;
        input_round_key <= output_round_key;
        round_rcon <= x"80000000";
        wait for 10 ns;
        input_round_key <= output_round_key;
        round_rcon <= x"1B000000";
        wait for 10 ns;
        input_round_key <= output_round_key;
        round_rcon <= x"36000000";
        wait;
    end process;
END ARCHITECTURE;