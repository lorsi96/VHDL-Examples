library IEEE;
use IEEE.std_logic_1164.all;

entity bcd_counter is
    port(
        en: in std_logic; 
        clk: in std_logic;
        q: out std_logic_vector(3 downto 0) := (others => '0');
        c_o: out std_logic := '0'
    );
end;

architecture bcd_counter_arch of bcd_counter is
    -- Flip Flops D -> 4 bit Register --
    component ffd_sync is
        port(
            d_i: in std_logic;
            en_i: in std_logic;
            clk_i: in std_logic;
            rst_i: in std_logic;
            q_o: out std_logic 
        );
    end component;

    -- 4 Bit Full Adder -> Incrementer --
    component full_adder_4bits is
        port(
            a_i: in std_logic_vector(3 downto 0);
            b_i: in std_logic_vector(3 downto 0);
            ci_i: in std_logic;
            s_o: out std_logic_vector(3 downto 0);
            co_o: out std_logic 
        );
    end component;

    -- Muxes -> Enable --
    component mux is
        port(
            a_i: in std_logic;
            b_i: in std_logic;
            s_i: in std_logic; 
            q_o: out std_logic
        );
    end component;

    signal cmp: std_logic := '0';
    signal mux_to_reg: std_logic_vector(3 downto 0) := (others => '0');
    signal reg_out: std_logic_vector(3 downto 0) := (others => '0');
    signal inc_out: std_logic_vector(3 downto 0) := (others => '0');
    begin
        cnt_i: for i in 0 to 3 generate
            ff: ffd_sync port map(
                d_i => mux_to_reg(i),
                en_i => '1',
                clk_i => clk,
                rst_i => cmp,
                q_o => reg_out(i)
            );
            mx: mux port map(
                a_i => reg_out(i),
                b_i => inc_out(i),
                s_i => en,
                q_o => mux_to_reg(i)
            );
        end generate;

        adder: full_adder_4bits port map(
            a_i => reg_out,
            b_i => "0000",
            ci_i => '1',
            s_o => inc_out 
        );

        cout_delay: ffd_sync port map (
            d_i => cmp,
            en_i => '1',
            clk_i => clk,
            rst_i => '0',
            q_o => c_o
        );

        cmp <= (not ('1' xor reg_out(3))) and  
               (not ('0' xor reg_out(2))) and
               (not ('0' xor reg_out(1))) and
               (not ('1' xor reg_out(0)));
        
        q <= reg_out;
  end;

