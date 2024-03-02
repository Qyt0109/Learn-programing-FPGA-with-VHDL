LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

LIBRARY std;
USE std.textio.ALL;

ENTITY test_bench_write_text_file IS
END ENTITY test_bench_write_text_file;

ARCHITECTURE rtl OF test_bench_write_text_file IS
    CONSTANT c : STRING := "This is a string";
    SIGNAL x : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1010";
    SIGNAL y : INTEGER := 100;
BEGIN
    file_write_process : PROCESS
        FILE output_file : text;
        VARIABLE line_buffer : line;
    BEGIN
        file_open(output_file, "output.txt", WRITE_MODE);

        write(line_buffer, STRING'("Signal X is: "));
        write(line_buffer, x);
        writeline(output_file, line_buffer);

        write(line_buffer, STRING'("Signal Y is: "));
        write(line_buffer, y);
        writeline(output_file, line_buffer);

        write(line_buffer, STRING'("String C is: "));
        write(line_buffer, c);
        writeline(output_file, line_buffer);

        file_close(output_file);
        WAIT;
    END PROCESS;
END ARCHITECTURE;