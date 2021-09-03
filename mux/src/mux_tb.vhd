library IEEE;
use IEEE.std_logic_1164.all;

entity mux_tb is
end;

architecture mux_tb_arch of mux_tb is
    -- Component Declaration --
    component mux is
        port(
            a_i: in std_logic;
            b_i: in std_logic;
            s_i: in std_logic; 
            q_o: out std_logic

        );
    end component;

    -- Signals Definition --
    signal a_tb: std_logic := '0'; 
    signal b_tb: std_logic := '0'; 
    signal s_tb: std_logic := '0';
    signal q_tb: std_logic;  

begin
    -- Sequence Goes Here --

    DUT: mux
        port map(
            a_i => a_tb,
            b_i => b_tb,
            s_i => s_tb,
            q_o => q_tb
        );
    
    TEST: process

        begin
            -- A and B signals --
            a_tb <= '1';
            b_tb <= '0';

            -- Select A --
            s_tb <= '0';
            wait for 10 ns;
            assert (q_tb = '1') report "A Selection failed" severity failure;
            wait for 10 ns;

            -- Select B --
            s_tb <= '1';
            wait for 10 ns;
            assert (q_tb = '0') report "B Selection failed" severity failure;
            wait for 10 ns;

            -- Update B while keeping Select as is --
            b_tb <= '1';
            wait for 10 ns;
            assert (q_tb = '1') report "B Update failed" severity failure;
    
            -- End --
            wait;
    
        end process;
end;