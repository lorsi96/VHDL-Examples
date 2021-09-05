library IEEE;
use IEEE.std_logic_1164.all;

entity counter is
    generic(N: natural:= 4);
    port(
        ena: in std_logic;
        rst: in std_logic; 
        clk: in std_logic;
        q: out std_logic_vector(N-1 downto 0)
    );
end;

architecture counter_arch of counter is
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
    signal aux2: std_logic_vector(N-1 downto 0);
    signal aux3: std_logic_vector(N-1 downto 0);

    begin
        ff_wires(0) <= ena;
        ffd_i: for i in 0 to N-1 generate
            ff_wires(i+1) <= ff_wires(i) and aux3(i);
            aux2(i) <= aux3(i) xor ff_wires(i);
            ff: ffd port map(
                d_i => aux2(i),
                en_i => '1',
                clk_i => clk,
                rst_i => rst,
                q_o => aux3(i)
            );
            q(i) <= aux3(i);
        end generate;
        
  end;

