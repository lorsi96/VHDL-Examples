library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sine_generator_tb is
end;

architecture sine_generator_tb_arch of sine_generator_tb is
    component sinewave_generator is
      -- Generic Configuration --
      generic(
          -- Output Sine Base (min) Frequency --
          BASE_SIN_FREQ_HZ: natural := 100;
          -- Input Frequency Clk Speed --
          CLOCK_RATE: natural := 50e6 
      );
      
      -- Port Declaration --
      port(
          -- Input Clock, shall run at CLOCK_RATE Hz --
          clk: in std_logic;
                    
        -- Frequency Manipulators --
          up: in std_logic;
          down: in std_logic;

          -- 8 bit sinewave output --
          result: out std_logic
      );
    end component;

    -- Signals --
    signal clk_tb: std_logic := '0';
    signal up_tb: std_logic := '0';
    signal dwn_tb: std_logic := '0';
    
    -- signal rst_tb: std_logic := '0';
    -- signal clk_out_bt: std_logic;
    signal result_tb: std_logic;

begin

    SINEWAVE_GEN : sinewave_generator 
    port map (
      clk => clk_tb,
      up => up_tb,
      down => dwn_tb,
      result => result_tb
    );
    
    --- Test Procedure ---
    clk_tb <= not clk_tb after 10 ns;
    TEST: process
    begin
        wait for 6 ms;
        up_tb <= '1';
        wait for 6 ms;
        up_tb <= '0';
        dwn_tb <= '1';
        wait for 6 ms;
        dwn_tb <= '0';
        wait;
    end process;
end;