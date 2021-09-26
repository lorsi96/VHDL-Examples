library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity sine_gen_top is
    port(clk: in std_logic);
end;

architecture sine_gen_top_arch of sin_gen_top is

    component meta_harden is
        port(
            clk_dst: 	in std_logic;	-- Destination clock
            rst_dst: 	in std_logic;	-- Reset - synchronous to destination clock
            signal_src: in std_logic;	-- Asynchronous signal to be synchronized
            signal_dst: out std_logic	-- Synchronized signal
        );
    end component;

    component sinewave_generator is
        generic(
            BASE_SIN_FREQ_HZ: natural := 100;
            CLOCK_RATE: natural := 50e6 
        );
        port(
            clk: in std_logic;
            up: in std_logic;
            down: in std_logic;
            result: out std_logic
        );
    end component;

    signal up_btn_async: std_logic := '0';
    signal dwn_btn_async: std_logic := '0';
    signal up_btn: std_logic := '0';
    signal dwn_btn: std_logic := '0';
    signal analog_sine: std_logic := '0';

begin

    META_HARDEN_UP: meta_harden 
    port map (
        clk_dst => clk,
        rst_dst => '0',
        signal_src => up_btn_async,
        signal_dst => up_btn
    );

    META_HARDEN_DOWN: meta_harden 
    port map (
        clk_dst => clk,
        rst_dst => '0',
        signal_src => dwn_btn_async,
        signal_dst => dwn_btn
    );

    SINE_GEN: sinewave_generator
    port map (
        clk => clk,
        up => up_btn,
        down => dwn_btn,
        result => analog_sine
    );

end;