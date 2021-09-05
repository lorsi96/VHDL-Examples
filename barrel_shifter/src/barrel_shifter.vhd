library IEEE;
use IEEE.std_logic_1164.all;

entity barrel_shifter is
    generic(N: natural:= 2);
    port(
        a: in std_logic_vector(2**N-1 downto 0);
        des: in std_logic_vector(N-1 downto 0);
        s: out std_logic_vector(2**N-1 downto 0)
    );
end;

architecture barrel_shifter_arch of barrel_shifter is
    begin

        process
        begin
            function word_to_int(word: std_logic_vector) return integer is
                variable result : integer := 0;
               begin
                for index in word'range loop
                result := result * 2;
                if (word(index) = '1') then
                result := result + 1;
                end if;
                end loop;
                return result;
               end word_to_int;
            
            s <= a(2**N-1 downto 1 lsl word_to_int(des-1)) & a(1 lsl des-1 downto 0);
        end process;
    end;