library IEEE;
use IEEE.std_logic_1164.all;

entity bcd_counter_tb is
end;

architecture bcd_counter_tb_arch of bcd_counter_tb is
    -- Component Declaration --
    component bcd_counter is
        port(
            en: in std_logic; 
            clk: in std_logic;
            q: out std_logic_vector(3 downto 0) := (others => '0');
            c_o: out std_logic := '0'
        );
    end component;

    -- Signals Definition --
    signal en_tb: std_logic := '1'; 
    signal clk_tb: std_logic := '0';
    signal q_tb: std_logic_vector(3 downto 0);
    signal c_o_tb: std_logic;

begin

    clk_tb <= not clk_tb after 10 ns;

    -- Sequence Goes Here --
    DUT: bcd_counter
        port map(
            en => en_tb,
            clk => clk_tb,
            q => q_tb,
            c_o => c_o_tb
        );
    
    TEST: process
    begin
        wait for 20*9 ns;
        assert q_tb = "1001" report "bcd_counter failed" severity failure;
        assert c_o_tb = '0'report "bcd_counter failed" severity failure;
        wait for 20 ns;
        assert q_tb = "0000" report "bcd_counter failed" severity failure;
        assert c_o_tb = '1'report "bcd_counter failed" severity failure;
        wait;
    end process;
end;