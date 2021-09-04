library IEEE;
use IEEE.std_logic_1164.all;

entity shift_register is
    generic(N: natural:= 4);
    port(
        e: in std_logic;
        clk: in std_logic;
        s: out std_logic 
    );
end;

architecture shift_register_arch of shift_register is
    component ffd is
        port(
            d_i: in std_logic;
            en_i: in std_logic;
            clk_i: in std_logic;
            rst_i: in std_logic;
            q_o: out std_logic 
        );
    end component;

    signal ff_wires: std_logic_vector(N downto 0);
    begin
        ff_wires(0) <= e;
        ffd_i: for i in 0 to N-1 generate
            ff: ffd port map(
                d_i => ff_wires(i),
                en_i => '1',
                clk_i => clk,
                rst_i => '0',
                q_o => ff_wires(i+1)
            );
        end generate;
        s <= ff_wires(N);
    end;