# Viết các trường hợp If Else/Switch case

## 1) Spec:
- Yêu cầu: tự nghĩ trường hợp cho một bài toán nào đó. EX:
``` verilog
if s1 = 0
    y = a + b
else 
    y = a - b
if s2 = 0
    y = a + b
else
    y = a - b
```

- Viết các trường hợp if else lồng nhau, không lồng nhau, có if không else,...
## 2) Thực hiện:
### 2.1. Bài toán đặt ra
- Thiết kế ALU tự chế, thực hiện các chức năng tính toán số học, logic dựa trên opcode được đưa vào các chân <b>Select[2:0]</b>:
  <table>
    <tbody>
        <tr>
            <td>S1S0 \ S2</td>
            <td>0</td>
            <td>1</td>
        </tr>
        <tr>
            <td>00</td>
            <td>ADD</td>
            <td>AND</td>
        </tr>
        <tr>
            <td>01</td>
            <td>SUB</td>
            <td>OR</td>
        </tr>
        <tr>
            <td>10</td>
            <td>MOD</td>
            <td>X</td>
        </tr>
        <tr>
            <td>11</td>
            <td>X</td>
            <td>XOR</td>
        </tr>
    </tbody>
  </table>
- Chi tiết:
    - Đầu vào:
      - <b>INPUT_A</b> (4 bit) và <b>INPUT_B</b> (4 bit): Mỗi cụm sẽ biểu diễn cho một số nguyên có dấu với khoảng giá trị từ -8 đến 7 hoặc dãy 4 bit tuỳ vào chế độ tính toán số học hay logic.
      - <b>SELLECT_S</b> (3 bit): Chọn phép toán dựa trên opcode đưa vào S, S2 = 0 sẽ thực hiện phép toán số học, S2 = 1 sẽ thực hiện phép toán logic. S1S0 sẽ lựa chọn 1 phép toán \$ để thực hiện A \$ B.
    - Đầu ra:
      - <b>OUTPUT_F</b> (4 bit): Cụm biểu diễn một số nguyên có dấu với khoảng giá trị từ -8 đến 7 hoặc dãy 4 bit tuỳ vào chế độ tính toán số học hay logic.
- Các trường hợp thiết kế:
  - if else lồng nhau
  - if else không lồng
  - chỉ if không else
  - lồng không lồng
  - không lồng trong có lồng
  - switch case thay if else
### 2.2. Thiết kế khung module
#### 2.2.1. Module structure:
``` VHDL
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
--  ┌─────────┬─────────┬─────────┐
--  │S1S0 / S2│    0    │    1    │
--  ├─────────┼─────────┼─────────┤
--  │   00    │   ADD   │   AND   │
--  ├─────────┼─────────┼─────────┤
--  │   01    │   SUB   │   OR    │
--  ├─────────┼─────────┼─────────┤
--  │   10    │   MOD   │    X    │
--  ├─────────┼─────────┼─────────┤
--  │   11    │    X    │   XOR   │
--  └─────────┴─────────┴─────────┘
ENTITY ALU IS
    GENERIC (
        NUMBER_OF_INPUT_BIT : POSITIVE := 4
    );
    PORT (
        INPUT_A, INPUT_B : IN STD_LOGIC_VECTOR(NUMBER_OF_INPUT_BIT - 1 DOWNTO 0);
        SELECT_S : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        OUTPUT_F : OUT STD_LOGIC_VECTOR(NUMBER_OF_INPUT_BIT * 2 - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF ALU IS
BEGIN
    processALU : PROCESS (INPUT_A, INPUT_B, SELECT_S)
    BEGIN
        -- IMPLEMENT HERE
        -- IMPLEMENT HERE
        -- IMPLEMENT HERE
    END PROCESS;
END ARCHITECTURE;
```
Với các trường hợp thiết kế, chỉ cần thực hiện thay đổi trong phạm vi
``` VHDL
-- IMPLEMENT HERE
-- IMPLEMENT HERE
-- IMPLEMENT HERE
```
#### 2.2.2. Module test
``` VHDL
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ALU_tb IS
    GENERIC (
        NUMBER_OF_BIT : POSITIVE := 4
    );
END ENTITY;

ARCHITECTURE rtl OF ALU_tb IS
    SIGNAL INPUT_A, INPUT_B : STD_LOGIC_VECTOR(NUMBER_OF_BIT - 1 DOWNTO 0);
    SIGNAL SELECT_S : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL OUTPUT_F : STD_LOGIC_VECTOR(NUMBER_OF_BIT - 1 DOWNTO 0);
    CONSTANT CLK_PERIOD : TIME := 10 ns;
BEGIN
    alu_inst : ENTITY work.ALU -- <== CHANGE THIS 'ALU' FOR TESTING
        GENERIC MAP(
            NUMBER_OF_BIT => NUMBER_OF_BIT
        )
        PORT MAP(
            INPUT_A => INPUT_A,
            INPUT_B => INPUT_B,
            SELECT_S => SELECT_S,
            OUTPUT_F => OUTPUT_F
        );
    processTest : PROCESS
    BEGIN
        INPUT_A <= "0100";
        INPUT_B <= "1101";
        loopTest : FOR select_value IN 0 TO 7 LOOP
            SELECT_S <= STD_LOGIC_VECTOR(to_unsigned(select_value, SELECT_S'length));
            WAIT FOR CLK_PERIOD;
        END LOOP;
        WAIT;
    END PROCESS;
END ARCHITECTURE;
```
Test expected:
``` VHDL
INPUT_A = 0100 (4)
INPUT_B = 1101 (-3)
SELECT_S =
000 => OUTPUT_F = INPUT_A ADD INPUT_B = 0001 (1)
001 => OUTPUT_F = INPUT_A SUB INPUT_B = 0111 (7)
010 => OUTPUT_F = INPUT_A MOD INPUT_B = 0100 (-2)
011 => OUTPUT_F = X

100 => OUTPUT_F = INPUT_A AND INPUT_B = 0100
100 => OUTPUT_F = INPUT_A OR INPUT_B = 1101
100 => OUTPUT_F = X
100 => OUTPUT_F = INPUT_A XOR INPUT_B = 1001
```

### 2.3. Implement các trường hợp thiết kế:
#### 2.3.1. If else
##### a) If else thông thường:
``` VHDL
IF SELECT_S = "000" THEN
    OUTPUT_F <= STD_LOGIC_VECTOR(signed(INPUT_A) + signed(INPUT_B));
ELSIF SELECT_S = "001" THEN
    OUTPUT_F <= STD_LOGIC_VECTOR(signed(INPUT_A) - signed(INPUT_B));
ELSIF SELECT_S = "010" THEN
    OUTPUT_F <= STD_LOGIC_VECTOR(signed(INPUT_A) MOD signed(INPUT_B));
ELSIF SELECT_S = "100" THEN
    OUTPUT_F <= INPUT_A AND INPUT_B;
ELSIF SELECT_S = "101" THEN
    OUTPUT_F <= INPUT_A OR INPUT_B;
ELSIF SELECT_S = "111" THEN
    OUTPUT_F <= INPUT_A XOR INPUT_B;
ELSE
    OUTPUT_F <= (OTHERS => 'X');
END IF;
```

<img src="./imgs/ALU_IfElse.png">

Total logic elements: 74

<img src="./imgs/ALU1_tb.png">
Test chính xác

##### b) Nested If else theo SELECT_S(1 DOWNTO 0)
``` VHDL
IF SELECT_S(1 DOWNTO 0) = "00" THEN
    IF SELECT_S(2) = '0' THEN
        OUTPUT_F <= STD_LOGIC_VECTOR(signed(INPUT_A) + signed(INPUT_B));
    ELSE
        OUTPUT_F <= INPUT_A AND INPUT_B;
    END IF;
ELSIF SELECT_S(1 DOWNTO 0) = "01" THEN
    IF SELECT_S(2) = '0' THEN
        OUTPUT_F <= STD_LOGIC_VECTOR(signed(INPUT_A) - signed(INPUT_B));
    ELSE
        OUTPUT_F <= INPUT_A OR INPUT_B;
    END IF;
ELSIF SELECT_S(1 DOWNTO 0) = "10" THEN
    IF SELECT_S(2) = '0' THEN
        OUTPUT_F <= STD_LOGIC_VECTOR(signed(INPUT_A) MOD signed(INPUT_B));
    ELSE
        OUTPUT_F <= (OTHERS => 'X');
    END IF;
ELSIF SELECT_S(1 DOWNTO 0) = "11" THEN
    IF SELECT_S(2) = '0' THEN
        OUTPUT_F <= (OTHERS => 'X');
    ELSE
        OUTPUT_F <= INPUT_A XOR INPUT_B;
    END IF;
ELSE
    OUTPUT_F <= (OTHERS => 'X');
END IF;
```

<img src="./imgs/ALU_NestedIfElse.png">

Total logic elements: 78

<img src="./imgs/ALU1_tb.png">
Test chính xác

##### c) Nested If else theo SELECT_S(2)
``` VHDL
IF SELECT_S(2) = '0' THEN
    IF SELECT_S(1 DOWNTO 0) = "00" THEN
        OUTPUT_F <= STD_LOGIC_VECTOR(signed(INPUT_A) + signed(INPUT_B));
    ELSIF SELECT_S(1 DOWNTO 0) = "01" THEN
        OUTPUT_F <= STD_LOGIC_VECTOR(signed(INPUT_A) + signed(INPUT_B));
    ELSIF SELECT_S(1 DOWNTO 0) = "10" THEN
        OUTPUT_F <= STD_LOGIC_VECTOR(signed(INPUT_A) MOD signed(INPUT_B));
    ELSE
        OUTPUT_F <= (OTHERS => 'X');
    END IF;
ELSIF SELECT_S(2) = '1' THEN
    IF SELECT_S(1 DOWNTO 0) = "00" THEN
        OUTPUT_F <= INPUT_A AND INPUT_B;
    ELSIF SELECT_S(1 DOWNTO 0) = "01" THEN
        OUTPUT_F <= INPUT_A OR INPUT_B;
    ELSIF SELECT_S(1 DOWNTO 0) = "11" THEN
        OUTPUT_F <= INPUT_A XOR INPUT_B;
    ELSE
        OUTPUT_F <= (OTHERS => 'X');
    END IF;
ELSE
    OUTPUT_F <= (OTHERS => 'X');
END IF;
```

<img src="./imgs/ALU_NestedIfElse2.png">

Total logic elements: 67

<img src="./imgs/ALU1_tb.png">
Test chính xác

#### 2.3.2. Case
##### a) Case thông thường:
``` VHDL
CASE SELECT_S IS
    WHEN "000" =>
        OUTPUT_F <= STD_LOGIC_VECTOR(unsigned(INPUT_A) + unsigned(INPUT_B));
    WHEN "001" =>
        OUTPUT_F <= STD_LOGIC_VECTOR(unsigned(INPUT_A) - unsigned(INPUT_B));
    WHEN "010" =>
        OUTPUT_F <= STD_LOGIC_VECTOR(unsigned(INPUT_A) MOD unsigned(INPUT_B));
    WHEN "100" =>
        OUTPUT_F <= INPUT_A AND INPUT_B;
    WHEN "101" =>
        OUTPUT_F <= INPUT_A OR INPUT_B;
    WHEN "111" =>
        OUTPUT_F <= INPUT_A XOR INPUT_B;
    WHEN OTHERS =>
        OUTPUT_F <= (OTHERS => 'X');
END CASE;
```
<img src="./imgs/ALU1.png">

Total logic elements: 44

<img src="./imgs/ALU1_tb.png">
Test chính xác

##### b) Case if else theo SELECT_S(1 DOWNTO 0)
```VHDL
CASE SELECT_S(1 DOWNTO 0) IS
    WHEN "00" =>
        IF SELECT_S(2) = '0' THEN
            OUTPUT_F <= STD_LOGIC_VECTOR(signed(INPUT_A) + signed(INPUT_B));
        ELSE
            OUTPUT_F <= INPUT_A AND INPUT_B;
        END IF;
    WHEN "01" =>
        IF SELECT_S(2) = '0' THEN
            OUTPUT_F <= STD_LOGIC_VECTOR(signed(INPUT_A) - signed(INPUT_B));
        ELSE
            OUTPUT_F <= INPUT_A OR INPUT_B;
        END IF;
    WHEN "10" =>
        IF SELECT_S(2) = '0' THEN
            OUTPUT_F <= STD_LOGIC_VECTOR(signed(INPUT_A) MOD signed(INPUT_B));
        ELSE
            OUTPUT_F <= (OTHERS => 'X');
        END IF;
    WHEN "11" =>
        IF SELECT_S(2) = '0' THEN
            OUTPUT_F <= (OTHERS => 'X');
        ELSE
            OUTPUT_F <= INPUT_A XOR INPUT_B;
        END IF;
    WHEN OTHERS =>
            OUTPUT_F <= (OTHERS => 'X');
END CASE;
```
<img src="./imgs/ALU_CaseIfElse.png">
Total logic elements: 74

<img src="./imgs/ALU1_tb.png">
Test chính xác

##### c) Case if else theo SELECT_S(2)
```VHDL
CASE SELECT_S(2) IS
    WHEN '0' =>
        IF SELECT_S(1 DOWNTO 0) = "00" THEN
            OUTPUT_F <= STD_LOGIC_VECTOR(signed(INPUT_A) + signed(INPUT_B));
        ELSIF SELECT_S(1 DOWNTO 0) = "01" THEN
            OUTPUT_F <= STD_LOGIC_VECTOR(signed(INPUT_A) + signed(INPUT_B));
        ELSIF SELECT_S(1 DOWNTO 0) = "10" THEN
            OUTPUT_F <= STD_LOGIC_VECTOR(signed(INPUT_A) MOD signed(INPUT_B));
        ELSE
            OUTPUT_F <= (OTHERS => 'X');
        END IF;
    WHEN '1' =>
        IF SELECT_S(1 DOWNTO 0) = "00" THEN
            OUTPUT_F <= INPUT_A AND INPUT_B;
        ELSIF SELECT_S(1 DOWNTO 0) = "01" THEN
            OUTPUT_F <= INPUT_A OR INPUT_B;
        ELSIF SELECT_S(1 DOWNTO 0) = "11" THEN
            OUTPUT_F <= INPUT_A XOR INPUT_B;
        ELSE
            OUTPUT_F <= (OTHERS => 'X');
        END IF;
    WHEN OTHERS =>
        OUTPUT_F <= (OTHERS => 'X');
END CASE;
```
<img src="./imgs/ALU_CaseIfElse2.png">
Total logic elements: 67

<img src="./imgs/ALU1_tb.png">
Test chính xác

## 3) Nhận xét:
-
-
-