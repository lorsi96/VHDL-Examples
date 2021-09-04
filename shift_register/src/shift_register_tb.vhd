library IEEE;
use IEEE.std_logic_1164.all;

entity shift_register_tb is
end;

architecture shift_register_tb_arch of shift_register_tb is
    -- Component Declaration --
    component shift_register is
        port(
            e: in std_logic;
            clk: in std_logic;
            s: out std_logic 

        );
    end component;

    -- Signals Definition --
    signal e_tb: std_logic := '0';
    signal clk_tb: std_logic := '0';
    signal s_tb: std_logic;

begin

    clk_tb <= not clk_tb after 10 ns;

    -- Sequence Goes Here --

    DUT: shift_register
        port map(
            e => e_tb,
            clk => clk_tb,
            s => s_tb
        );
    
    TEST: process
        begin
            e_tb <= '1';
            wait for 20 ns;
            e_tb <= '0';        
            wait for 60 ns;
            assert (s_tb = '1') report "Bit not shifter successfully" severity failure;
            wait for 20 ns;
            assert (s_tb = '0') report "Bit not shifter successfully" severity failure;
            wait;
        end process;
end;