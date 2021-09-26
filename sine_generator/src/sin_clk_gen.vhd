-------------------------------------------------------------------------------
--  
--  Copyright (c) Lucas Orsi
--

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity clk_gen is
	generic(
		SIN_SAMPLES_N: natural := 256;
		SIN_LEVELS: natural := 256;
		BASE_SIN_FREQ_HZ: natural := 100;
		CLOCK_RATE: natural := 50E6
	);
	port(
		clk: 			in std_logic;
		rst: 			in std_logic;       
		clk_out:		out std_logic
	);
end;

architecture clk_gen_arch of clk_gen is

	-- Generate the ceiling of the log base 2 - i.e. the number of bits
	-- required to hold N values. A vector of size clogb2(N) will hold the
	-- values 0 to N-1
	function clogb2(value: integer) return integer is
		variable my_value: integer;
		variable i: integer := 0;
	begin
		my_value :=  value - 1;
		while my_value > 0 loop
			i := i + 1;
	        my_value := to_integer(shift_right(to_unsigned(my_value, 32), 1));
		end loop;
		return i;
	end function;
	
	-- Frequecy to fit all of the sine samples within a period.
	constant SAMPLE_RATE_HZ: natural := BASE_SIN_FREQ_HZ * SIN_SAMPLES_N * SIN_LEVELS;
	constant DIVIDER: natural := (CLOCK_RATE+SAMPLE_RATE_HZ/2) / SAMPLE_RATE_HZ;
	constant OVERSAMPLE_VALUE: integer := DIVIDER - 1;

	-- The required width of the counter is the ceiling of the base 2 logarithm
	-- of the DIVIDER
	constant CNT_WID: natural := clogb2(DIVIDER);

	signal internal_count: std_logic_vector(CNT_WID-1 downto 0) := (others => '0');
	signal internal_count_m_1: std_logic_vector(CNT_WID-1 downto 0) := (others => '0');

begin

	internal_count_m_1 <= std_logic_vector(unsigned(internal_count) - 1);

	process(clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				internal_count <= std_logic_vector(to_unsigned(OVERSAMPLE_VALUE, CNT_WID));
				clk_out <= '0';
			else
				-- Assert baud_x16_en_reg in the next clock when internal_count will be
				-- zero in that clock (thus when internal_count_m_1 is 0).
				if internal_count_m_1 = (CNT_WID-1 downto 0 => '0') then
					clk_out	<= '1';
				else
					clk_out	<= '0';
				end if;
				
				-- Count from OVERSAMPLE_VALUE down to 0 repeatedly
				if internal_count = (CNT_WID-1 downto 0 => '0') then
					internal_count <= std_logic_vector(to_unsigned(OVERSAMPLE_VALUE, CNT_WID));
				else -- internal_count is not 0
					internal_count <= internal_count_m_1;
				end if;	
				
			end if;
		end if;
	end process;
	
	--clk_out <= clk_out;
end;
		