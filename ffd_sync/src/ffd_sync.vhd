library IEEE;
use IEEE.std_logic_1164.all;

entity ffd_sync is
    port(
        d_i: in std_logic;
        en_i: in std_logic;
        clk_i: in std_logic;
        rst_i: in std_logic;
        q_o: out std_logic := '0'
    );
end;

architecture ffd_sync_arch of ffd_sync is
begin
    process(clk_i)
    begin
            if clk_i = '1' then
                if rst_i = '1' then
                    q_o <= '0';
                elsif en_i = '1' then
                    q_o <= d_i;
                end if;
            end if;
    end process;
end ffd_sync_arch;
