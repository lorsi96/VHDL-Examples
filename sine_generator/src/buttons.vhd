library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity buttons is
    generic(BTN_CNT_MAX_BITS: natural := 4);
    port(
        btn_up: in std_logic;
        btn_down: in std_logic;
        btn_cnt_out: out unsigned(BTN_CNT_MAX_BITS-1 downto 0)
    );
end;

architecture buttons_arch of buttons is
begin
    process(btn_up, btn_down) is
        constant BTN_CNT_MIN: unsigned(BTN_CNT_MAX_BITS-1 downto 0) := (others => '0'); 
        constant BTN_CNT_MAX: unsigned(BTN_CNT_MAX_BITS-1 downto 0) := (others => '1'); 
        variable counter: unsigned(BTN_CNT_MAX_BITS-1 downto 0) := (others => '0'); 
    begin
        if(rising_edge(btn_up)) then
            if counter /= BTN_CNT_MAX then
                counter := counter + 1;
            end if;
        end if;
        
        if(rising_edge(btn_down)) then
            if counter /= BTN_CNT_MIN then
                counter := counter - 1;
            end if;
        end if;

        btn_cnt_out <= counter;
    end process;
end;