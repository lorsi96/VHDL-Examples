library IEEE;
use IEEE.std_logic_1164.all;

entity counter_tb is
end;

architecture counter_tb_arch of counter_tb is
    -- Component Declaration --
    component counter is
        generic(N: natural:= 5);
        port(
            ena: in std_logic;
            rst: in std_logic; 
            clk: in std_logic;
            q: out std_logic_vector(N-1 downto 0)
        );
    end component;

    -- Signals Definition --
    signal ena_tb: std_logic := '1';
    signal rst_tb: std_logic := '0';
    signal clk_tb: std_logic := '0';
    signal q_tb: std_logic_vector(4 downto 0) := (others => '0');

begin

    clk_tb <= not clk_tb after 10 ns;

    -- Sequence Goes Here --
    DUT: counter
        port map(
            ena => ena_tb,
            rst => rst_tb,
            clk => clk_tb,
            q => q_tb
        );
    
    TEST: process
    begin
        wait for 20*31 ns;
        assert q_tb = "11111" report "Counter failed" severity failure;
        wait;
    end process;
end;