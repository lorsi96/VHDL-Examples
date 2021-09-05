library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd_counter_behavioral is
    port(
        en: in std_logic; 
        clk: in std_logic;
        q: out std_logic_vector(3 downto 0) := (others => '0');
        c_o: out std_logic := '0'
    );
end;

architecture bcd_counter_behavioral_arch of bcd_counter_behavioral is
    begin 
    process(clk)
        variable cnt: unsigned(3 downto 0) := (others => '0');
        begin
            if(clk = '1') then
                c_o <= '0';
                if (en = '1') then
                    cnt := cnt + 1;
                    if cnt = 10 then
                        cnt := (others => '0');
                        c_o <= '1';
                    end if;
                    q <= std_logic_vector(cnt);
                end if;
            end if;
    end process; 
  end;

