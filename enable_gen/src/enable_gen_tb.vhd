library IEEE;
use IEEE.std_logic_1164.all;

entity enable_gen_tb is
end;

architecture enable_gen_tb_arch of enable_gen_tb is
    -- Component Declaration --
    component enable_gen is
        generic(N: natural := 2);
        port(
            clk: in std_logic;
            rst: in std_logic;
            s_o: out std_logic 
        );
    end component;

    -- Signals Definition --
    signal clk_tb: std_logic := '0';
    signal rst_tb: std_logic := '0';
    signal s_o_tb: std_logic; 
    
begin

    clk_tb <= not clk_tb after 10 ns;

    DUT: enable_gen
        port map(
            clk => clk_tb,
            rst => rst_tb,
            s_o => s_o_tb
        );
            
    TEST: process

    begin
        wait for 20 * 3 ns;
        assert (s_o_tb = '0') report "Enable Gen didn't work" severity failure;
        wait for 20 ns;
        assert (s_o_tb = '1') report "Enable Gen didn't work" severity failure;
        wait for 20 ns;
        assert (s_o_tb = '0') report "Enable Gen didn't work" severity failure;

        wait;

    end process;

end;