library IEEE;
use IEEE.std_logic_1164.all;

entity barrel_shifter_tb is
end;

architecture barrel_shifter_tb_arch of barrel_shifter_tb is
    -- Component Declaration --
    component barrel_shifter is
        generic(N: natural:=2);
        port(
            a: in std_logic_vector(2**N-1 downto 0);
            des: in std_logic_vector(N-1 downto 0);
            s: out std_logic_vector(2**N-1 downto 0)
        );
    end component;

    signal a_tb: std_logic_vector(3 downto 0);
    signal des_tb: std_logic_vector(1 downto 0);
    signal s_tb: std_logic_vector(3 downto 0);
    
begin

    -- Sequence Goes Here --

    DUT: barrel_shifter
        port map(
            a => a_tb,
            des => des_tb,
            s => s_tb
        );
    
    TEST: process
    begin
    wait for 10 ns;
    end process;
end;