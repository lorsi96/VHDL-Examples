library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder_subs_4bit is
    port(
        sr_i: in std_logic;
        a_i: in std_logic_vector(3 downto 0);
        b_i: in std_logic_vector(3 downto 0);
        s_o: out std_logic_vector(3 downto 0);
        co_o: out std_logic 
    );
end;

architecture full_adder_subs_4bit_arch of full_adder_subs_4bit is

    component full_adder_4bits is
    port(
        a_i: in std_logic_vector(3 downto 0);
        b_i: in std_logic_vector(3 downto 0);
        ci_i: in std_logic;
        s_o: out std_logic_vector(3 downto 0);
        co_o: out std_logic 
    );
    end component;

    signal b_i_aux: std_logic_vector(3 downto 0);
    
    begin
        b_i_aux <= b_i xor (sr_i & sr_i & sr_i & sr_i);
        uadder: full_adder_4bits port map(
            a_i => a_i,
            b_i => b_i_aux,
            ci_i => sr_i,
            s_o => s_o,
            co_o => co_o            
        );
    end;