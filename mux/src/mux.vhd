library IEEE;
use IEEE.std_logic_1164.all;

entity mux is
    port(
        a_i: in std_logic;
        b_i: in std_logic;
        s_i: in std_logic; 
        q_o: out std_logic
    );
end;

architecture mux_arch of mux is
    begin
        q_o <= (not s_i and a_i) or (s_i and b_i);
    end;