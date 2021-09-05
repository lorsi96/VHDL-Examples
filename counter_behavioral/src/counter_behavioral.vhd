library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_behavioral is
    generic(N: natural:= 4);
    port(
        ena: in std_logic;
        rst: in std_logic; 
        clk: in std_logic;
        q: out std_logic_vector(N-1 downto 0) := (others => '0')
    );
end;

architecture counter_behavioral_arch of counter_behavioral is
    begin 
    process(clk, rst)
        variable cnt: unsigned(N-1 downto 0) := (others => '0');
    begin
        if(rst = '1') then
            cnt := (others => '0');
        elsif((ena = '1') and (clk = '1')) then
            cnt := cnt + 1;
            q <= std_logic_vector(cnt);
        end if;
    end process;   
  end;

