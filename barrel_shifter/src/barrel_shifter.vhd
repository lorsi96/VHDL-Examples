library IEEE;
use IEEE.std_logic_1164.all;

entity barrel_shifter is
    generic(N: natural:= 4);
    port(
        a: in std_logic_vector(N**2-1 downto 0);
        des: in std_logic_vector(N-1 downto 0);
        s: out std_logic_vector(N**2-1 downto 0)
    );
end;

architecture barrel_shifter_arch of barrel_shifter is

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

    begin
        process(a)
            variable int_temp: integer;
        begin
            int_temp := word_to_int(des);
            s <=  a(N**2 - 1 - int_temp downto 0) & a(N**2-1 downto N**2 - int_temp);
        end process;
    end;