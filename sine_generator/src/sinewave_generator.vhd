library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity sinewave_generator is
    -- Generic Configuration --
    generic(
        -- Output Sine Base (min) Frequency --
        BASE_SIN_FREQ_HZ: natural := 2;
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
end;

architecture sinewave_generator_arch of sinewave_generator  is

    component sine_generator is
        port(
          clk: in std_logic;
          mul: in unsigned(3 downto 0);
          result: out std_logic
        );
    end component;

    component clk_gen is
      generic(
        SIN_SAMPLES_N: natural := 256;
        BASE_SIN_FREQ_HZ: natural := BASE_SIN_FREQ_HZ;
        SIN_LEVELS: natural := 256;
        CLOCK_RATE: natural := CLOCK_RATE
      );
      port(
        clk: in std_logic;
        rst: in std_logic;       
        clk_out: out std_logic
      );
    end component;

    signal downsampled_clk : std_logic := '0';

begin
    CLKGEN: clk_gen
    port map(
        clk => clk,
        rst => '0',
        clk_out => downsampled_clk
    );

    SIN: sine_generator
    port map(
        clk => downsampled_clk,
        mul => mul,
        result => result
    );
end;