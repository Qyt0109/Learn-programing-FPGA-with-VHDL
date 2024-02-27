LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY KeyRound_tb IS
    GENERIC (
        MIN_ROUND_INDEX : NATURAL := 0;
        MAX_ROUND_INDEX : POSITIVE := 10
    );
END ENTITY;

ARCHITECTURE rtl OF KeyRound_tb IS
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL input_round_key, output_round_key : STD_LOGIC_VECTOR(127 DOWNTO 0);
    SIGNAL round_index : INTEGER RANGE MIN_ROUND_INDEX TO MAX_ROUND_INDEX;

    CONSTANT CLK_PERIOD : TIME := 10 ns;
BEGIN
    KeyRound_inst : ENTITY work.KeyRound
        GENERIC MAP(
            MIN_ROUND_INDEX => MIN_ROUND_INDEX,
            MAX_ROUND_INDEX => MAX_ROUND_INDEX
        )
        PORT MAP(
            clk => clk,
            input_round_key => input_round_key,
            round_index => round_index,
            output_round_key => output_round_key
        );
    clk <= NOT clk AFTER CLK_PERIOD / 2;
    processTest : PROCESS
    BEGIN
        -- Round 0: 54 68 61 74 73 20 6D 79 20 4B 75 6E 67 20 46 75
        -- Round 1: E2 32 FC F1 91 12 91 88 B1 59 E4 E6 D6 79 A2 93
        -- Round 2: 56 08 20 07 C7 1A B1 8F 76 43 55 69 A0 3A F7 FA
        -- Round 3: D2 60 0D E7 15 7A BC 68 63 39 E9 01 C3 03 1E FB
        -- Round 4: A1 12 02 C9 B4 68 BE A1 D7 51 57 A0 14 52 49 5B
        -- Round 5: B1 29 3B 33 05 41 85 92 D2 10 D2 32 C6 42 9B 69
        -- Round 6: BD 3D C2 B7 B8 7C 47 15 6A 6C 95 27 AC 2E 0E 4E
        -- Round 7: CC 96 ED 16 74 EA AA 03 1E 86 3F 24 B2 A8 31 6A
        -- Round 8: 8E 51 EF 21 FA BB 45 22 E4 3D 7A 06 56 95 4B 6C
        -- Round 9: BF E2 BF 90 45 59 FA B2 A1 64 80 B4 F7 F1 CB D8
        -- Round 10: 28 FD DE F8 6D A4 24 4A CC C0 A4 FE 3B 31 6F 26
        input_round_key <= x"5468617473206D79204B756E67204675";
        round_index <= 1;
        WAIT FOR CLK_PERIOD;
        loopTest : FOR r_index IN 2 TO 10 LOOP
            input_round_key <= output_round_key;
            round_index <= r_index;
            WAIT FOR CLK_PERIOD;
        END LOOP;
        WAIT;
    END PROCESS;
END ARCHITECTURE;