library IEEE;
use IEEE.std_logic_1164.all;

entity sine_generator_tb is
end;

architecture sine_generator_tb_arch of sine_generator_tb is
    -- Component Declaration --
    component sine_generator is
        port(
          clk: in std_logic;
          result: out std_logic_vector(7 downto 0)
        );
    end component;

    component clk_gen is
      generic(
        SIN_SAMPLES_N: natural := 4;
        BASE_SIN_FREQ_HZ: natural := 2;
        CLOCK_RATE: natural := 16
      );
      port(
        clk: 			in std_logic;
        rst: 			in std_logic;       
        clk_out:	out std_logic
      );
    end component;



    -- Signals --
    signal clk_tb: std_logic := '0';
    signal rst_tb: std_logic := '0';
    signal clk_out_bt: std_logic;
    signal result_tb: std_logic_vector(7 downto 0);

begin


    CLKGEN: clk_gen
      port map(
        clk => clk_tb,
        rst => rst_tb,
        clk_out => clk_out_bt
      );

    -- SIN: sine_generator
    --  port map(
    --        clk => clk_tb,
    --        result => result_tb
    --  );
    

    --- Test Procedure ---
    clk_tb <= not clk_tb after 10 ns;
    TEST: process
    begin
        wait for 20*512 ns;
    end process;
end;