library IEEE;
use IEEE.std_logic_1164.all;

entity ffd_tb is
end;

architecture ffd_tb_arch of ffd_tb is
    -- Component Declaration --
    component ffd is
        port(
            d_i: in std_logic;
            en_i: in std_logic;
            clk_i: in std_logic;
            rst_i: in std_logic;
            q_o: out std_logic 
        );
    end component;

    -- Signals Definition --
    signal d_tb: std_logic := '0';
    signal en_tb: std_logic := '0';
    signal clk_tb: std_logic := '0';
    signal rst_tb: std_logic := '0';
    signal q_tb: std_logic;
    
begin

    clk_tb <= not clk_tb after 10 ns;

    DUT: ffd
        port map(
            en_i => en_tb,
            d_i => d_tb,
            clk_i => clk_tb,
            rst_i => rst_tb,
            q_o => q_tb
        );
    
            
    TEST: process

    begin

        en_tb <= '1';
        d_tb <= '1';
        wait for 10 ns;
        en_tb <= '0';
        wait for 40 ns;
        assert (en_tb = '0') report "D didn't work" severity failure;

        en_tb <= '1';
        d_tb <= '0';
        wait for 40 ns;

        wait;

    end process;

end;