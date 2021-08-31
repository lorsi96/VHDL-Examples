library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder is
    port(
        ci_i: in std_logic;
        a_i: in std_logic;
        b_i: in std_logic;
        s_o: out std_logic;
        co_o: out std_logic 
    );
end;

architecture full_adder_arch of full_adder is
    begin
        s_o <= a_i xor b_i xor ci_i;
        co_o <= (a_i and b_i) or (ci_i and (a_i xor b_i));
    end;