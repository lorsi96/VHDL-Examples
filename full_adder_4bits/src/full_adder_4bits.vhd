library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder_4bits is
    port(
        a_i: in std_logic_vector(3 downto 0);
        b_i: in std_logic_vector(3 downto 0);
        ci_i: in std_logic;
        s_o: out std_logic_vector(3 downto 0);
        co_o: out std_logic 
    );
end;

architecture full_adder_4bits_arch of full_adder_4bits is
    component full_adder 
    port(
        ci_i: in std_logic;
        a_i: in std_logic;
        b_i: in std_logic;
        s_o: out std_logic;
        co_o: out std_logic 
    );
    end component;

    signal carry_aux: std_logic_vector(4 downto 0);

    begin

        carry_aux(0) <= ci_i;
        add_gen: for add_i in 0 to 3 generate
            add: full_adder port map(
                ci_i => carry_aux(add_i),
                a_i => a_i(add_i),
                b_i => b_i(add_i),
                s_o => s_o(add_i),
                co_o => carry_aux(add_i + 1)     
            );
        end generate;
        co_o <= carry_aux(4);

    end;