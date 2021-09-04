library IEEE;
use IEEE.std_logic_1164.all;

entity shift_register_behavioral is
    generic(N: natural:= 4);
    port(
        e: in std_logic;
        clk: in std_logic;
        s: out std_logic 
    );
end;

architecture shift_register_behavioral_arch of shift_register_behavioral is
    signal bits: std_logic_vector(N-2 downto 0);
    begin
        process(clk)
        begin
            if (clk = '1') then
                a: for i in 1 to N-2 loop
                    bits(i) <= bits(i-1);
                end loop;
                s <= bits(N-2);
                bits(0) <= e;
            end if;
        end process;
    end;