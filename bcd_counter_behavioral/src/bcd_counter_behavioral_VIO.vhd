library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd_counter_behavioral_VIO is
    port(
        clk_vio: in std_logic
    );
end;

architecture bcd_counter_behavioral_VIO_arch of bcd_counter_behavioral_VIO is

    component bcd_counter_behavioral is
        port(
            en: in std_logic; 
            clk: in std_logic;
            q: out std_logic_vector(3 downto 0);
            c_o: out std_logic
        );
    end component;
    
    COMPONENT vio_1
      PORT (
        clk : IN STD_LOGIC;
        probe_in0 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        probe_in1 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        probe_out0 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
        probe_out1 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
      );
    END COMPONENT;
    
    signal probe_a, probe_b, probe_d: std_logic_vector(0 downto 0);
    signal probe_c: std_logic_vector(3 downto 0);
    
    begin 
    
    your_instance_name : vio_1
      PORT MAP (
        clk => clk_vio,
        probe_in0 => probe_c,
        probe_in1 => probe_d,
        probe_out0 => probe_a,
        probe_out1 => probe_b
      );
    
    
    inst: bcd_counter_behavioral port map (
            en => probe_a(0),
            clk => probe_b(0),
            q => probe_c,
            c_o => probe_d(0)
        );
  end;

