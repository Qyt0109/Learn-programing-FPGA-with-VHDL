#### The test bench can print messages on the simulator console window.
##### Syntax:
``` vhdl
report message_string severity severity_level;
```
with
``` vhdl
severity_level = note, warning, error, failure
```
##### Ex:
``` vhdl
report "This is a message"; -- severity_level = note as default
report "This is a warning" severity warning;
```

#### Assert statement tests a Boolean condition, if false, it outputs a message string to the simulator output console.

##### Syntax:
``` vhdl
assert condition report string severity severity_level;
```
##### Ex:
``` vhdl
assert Overflow = '0' report "An overflow has orrcurred!" severity warning;
```

#### Using Text files
``` vhdl
user std.textio.all; -- declare Textio package
```
open, read, write to a file
##### Syntax:
``` vhdl
-- Declaring a text file
file file_handler_name : text; -- declare at declarative region of the architecture or a process

-- Opening a text file in OpenMode
file_open(file_handler_name, "file_name.txt", OpenMode);
-- with OpenMode = read_mode, write_mode, append

-- WRITE DATA TO A TEXT FILE
-- Opening a text file in write_mode
file_open(file_handler_name, "file_name.txt", write_mode);

-- Write to a text file
-- Step 1: write data to a line buffer
write(line_buffer_name, data)
-- Step 2: write line buffer to a file
writeline(file_handler_name, line_buffer_name)

-- Closing a text file
file_close(file_handler_name);

-- READ DATA FROM A TEXT FILE
-- Opening a text file in read_mode
file_open(file_handler_name, "file_name.txt", read_mode);

-- Read from a text file
-- Step 1: read a line buffer from the text file
readline(file_handler_name, line_buffer_name)
-- Step 2: read data from line buffer
read(line_buffer_name, signal_name)

-- Closing a text file
file_close(file_handler_name);
```