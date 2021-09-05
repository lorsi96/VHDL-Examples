library IEEE;
use IEEE.std_logic_1164.all;

entity ffd is
    port(
        d_i: in std_logic;
        en_i: in std_logic;
        clk_i: in std_logic;
        rst_i: in std_logic;
        q_o: out std_logic := '0'
    );
end;

architecture ffd_arch of ffd is
begin
    process(clk_i, rst_i)
    begin
            if rst_i = '1' then
                q_o <= '0';
            elsif clk_i = '1' then
                if en_i = '1' then
                    q_o <= d_i;
                end if;
            end if;
    end process;
end ffd_arch;
