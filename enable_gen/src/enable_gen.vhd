library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity enable_gen is
    generic(N: natural := 1);
    port(
        clk: in std_logic;
        rst: in std_logic;
        s_o: out std_logic := '0' 
    );
end;

architecture enable_gen_arch of enable_gen is
    signal dbg: unsigned(N-1 downto 0) := (others => '1');
    begin
    process(clk)
        constant max: unsigned(N-1 downto 0) := (others => '1');
        variable cnt: unsigned(N-1 downto 0) := (others => '0');
    begin
        if(rst = '1') then
            cnt := (others => '0'); 
        elsif(clk = '1') then
            if(cnt = max) then
                s_o <= '1';
            else
                s_o <= '0';
            end if;
            cnt := cnt + 1;
            dbg <= cnt;
        end if;
    end process;
end;