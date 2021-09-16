library IEEE;
use IEEE.std_logic_1164.all;

entity sine_generator_tb is
end;

architecture sine_generator_tb_arch of sine_generator_tb is
    -- Component Declaration --
    component counter_behavioral is
        generic(N: integer := 8);
        port(
            ena: in std_logic;
            rst: in std_logic; 
            clk: in std_logic;
            q: out std_logic_vector(N-1 downto 0)
        );
    end component;

    component sine_generator is
        port(
          address: in std_logic_vector(7 downto 0);
          result: out std_logic_vector(7 downto 0)
        );
    end component;

    -- Signals Definition --
    signal ena_tb: std_logic := '1';
    signal rst_tb: std_logic := '0';
    signal clk_tb: std_logic := '0';
    signal q_tb: std_logic_vector(7 downto 0);
    signal result_tb: std_logic_vector(7 downto 0);

begin

    clk_tb <= not clk_tb after 10 ns;

    CNT: counter_behavioral
        port map(
            ena => ena_tb,
            rst => rst_tb,
            clk => clk_tb,
            q => q_tb
        );
    
    SIN: sine_generator
      port map(
            address => q_tb,
            result => result_tb
      );
    
    TEST: process
    begin
        wait for 20*512 ns;
    end process;
end;