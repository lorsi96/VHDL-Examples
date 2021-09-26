library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pwm is
    generic(PWM_N_BITS: natural := 8);
    port(
        pwm_clk: in std_logic;
        pwm_cmp: in unsigned(PWM_N_BITS-1 downto 0);
        pwm_out: out std_logic;
        pwm_end: out std_logic
    );
end;

architecture pwm_arch of pwm is
    constant PWM_COUNTER_MAX: unsigned(PWM_N_BITS-1 downto 0) := (others => '1');
    constant PWM_COUNTER_MIN: unsigned(PWM_N_BITS-1 downto 0) := (others => '0');
begin
    process(pwm_clk) is
        variable counter: unsigned(PWM_N_BITS-1 downto 0) := PWM_COUNTER_MIN; 
    begin
        if (pwm_clk) = '1' then
            pwm_end <= '0';

            if counter > pwm_cmp then
                pwm_out <= '0';
            end if;

            if counter = PWM_COUNTER_MAX then
                pwm_out <= '1';
                pwm_end <= '1';    
            end if;

            counter := counter + 1;
        end if;
    end process;
end;