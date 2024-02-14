library ieee;
use ieee.std_logic_1164.all;

entity Parity is
    generic(
        DATA_WIDTH : integer := 4
    );
    port (
        data:in std_logic_vector(DATA_WIDTH - 1 downto 0);
        parity:out std_logic
    );
end entity;

architecture rtl of Parity is
begin
    processParity:process(data)
    variable parity_out : std_logic;
    begin
        parity_out := '0';
        for bit_index in 0 to DATA_WIDTH - 1 loop
            parity_out := parity_out xor data(bit_index);
        end loop;
        parity <= parity_out;
    end process;
end architecture;