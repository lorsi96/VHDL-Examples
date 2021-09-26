library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sine_generator_tb is
end;

architecture sine_generator_tb_arch of sine_generator_tb is
    -- Component Declaration --
    -- component sine_generator is
    --     port(
    --       clk: in std_logic;
    --       mul: in unsigned(3 downto 0);
    --       result: out std_logic_vector(7 downto 0)
    --     );
    -- end component;

    -- component clk_gen is
    --   generic(
    --     SIN_SAMPLES_N: natural := 4;
    --     BASE_SIN_FREQ_HZ: natural := 2;
    --     CLOCK_RATE: natural := 16
    --   );
    --   port(
    --     clk: 			in std_logic;
    --     rst: 			in std_logic;       
    --     clk_out:	out std_logic
    --   );
    -- end component;

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
          -- Output Sine Freq = mul * BASE_SIN_FREQ_HZ --
          mul: in unsigned(3 downto 0);
          -- 8 bit sinewave output --
          result: out std_logic
      );
    end component;

    -- Signals --
    signal clk_tb: std_logic := '0';
    signal mul_tb: unsigned(3 downto 0) := "0001";
    -- signal rst_tb: std_logic := '0';
    -- signal clk_out_bt: std_logic;
    signal result_tb: std_logic;

begin
    SINEWAVE_GEN : sinewave_generator 
    port map (
      clk => clk_tb,
      mul => mul_tb,
      result => result_tb
    );
    
    --- Test Procedure ---
    clk_tb <= not clk_tb after 10 ns;
    TEST: process
    begin
        wait for 20 * 512 ns;
    end process;
end;