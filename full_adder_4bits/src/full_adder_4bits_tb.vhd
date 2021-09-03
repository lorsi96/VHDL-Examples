library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder_4bits_tb is
end;

architecture full_adder_4bits_tb_arch of full_adder_4bits_tb is
    -- Component Declaration --
    component full_adder_4bits is
        port(
            a_i: in std_logic_vector(3 downto 0);
            b_i: in std_logic_vector(3 downto 0);
            ci_i: in std_logic;
            s_o: out std_logic_vector(3 downto 0);
            co_o: out std_logic  
        );
    end component;

    -- Signals Definition --
    signal a_tb: std_logic_vector(3 downto 0);
    signal b_tb: std_logic_vector(3 downto 0);
    signal ci_tb: std_logic;
    
    signal s_tb: std_logic_vector(3 downto 0);
    signal co_tb: std_logic;
    
begin
    DUT: full_adder_4bits
        port map(
            a_i => a_tb,
            b_i => b_tb,
            ci_i => ci_tb,
            s_o => s_tb,
            co_o => co_tb
        );
    
    TEST: process
    begin
        a_tb <= "1010";
        b_tb <= "1010";
        ci_tb <= '1';
        wait for 10 ns;
        assert (co_tb = '1') report "Cary out is incorrect" severity failure;
        assert (s_tb = "0101") report "Result is incorrect" severity failure;
        wait;
    end process;
    
end;