library IEEE;
use IEEE.std_logic_1164.all;

entity shift_register is
    port(
        a_i: in std_logic;
        b_o: out std_logic 
    );
end;

architecture shift_register_arch of shift_register is
    begin
        b_o <= not a_i;
    end;