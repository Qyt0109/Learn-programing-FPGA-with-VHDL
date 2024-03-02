LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

LIBRARY std;
USE std.textio.ALL;

ENTITY test_bench_read_text_file IS
END ENTITY test_bench_read_text_file;

ARCHITECTURE rtl OF test_bench_read_text_file IS
BEGIN
    file_read_process : PROCESS
        FILE input_file : text;
        VARIABLE line_buffer : line;
        VARIABLE int : INTEGER;
        VARIABLE char : CHARACTER;
        VARIABLE vector : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    BEGIN
        file_open(input_file, "input.txt", READ_MODE);

        WHILE NOT endfile(input_file) LOOP
            readline(input_file, line_buffer);
            read(line_buffer, int); -- 256
            read(line_buffer, char); -- space
            read(line_buffer, vector); -- 1101
        END LOOP;
        file_close(input_file);
        WAIT;
    END PROCESS;
END ARCHITECTURE;