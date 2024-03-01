library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity InvSBox_tb is
end entity;

architecture rtl of InvSBox_tb is
    signal input_byte, output_byte : STD_LOGIC_VECTOR(7 DOWNTO 0);
begin
    invsbox_inst: entity work.InvSBox
    port map (
      input_byte  => input_byte,
      output_byte => output_byte
    );
    processTest : process
    begin
        input_byte <= x"de"; -- 9c
        wait for 20 ns;
        input_byte <= x"f9"; -- 69
        wait for 20 ns;
        input_byte <= x"0f"; -- fb
        wait for 20 ns;
        input_byte <= x"ce"; -- ec
        wait for 20 ns;
        input_byte <= x"d0"; -- 60
        wait;
    end process;
end architecture;
