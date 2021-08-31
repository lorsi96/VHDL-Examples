# CESE VHD
## Installation Prequesites
- python3
- ghdl
- gtkwave


## Instructoins
Create a new project
```sh
python3 cese_vhd.py --create hello_project
```

Compile & Simulate project
```
python3 cese_vhd.py --sim hello_project
```


Generate Testbench template
```
python3 cese_vhd.py --testbench full_adder
```
note: it just prints the code, but does not alter any files.
note2: it requires the dut .vhd file to be complete.

Result:
```vhdl
library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder_tb is
end;

architecture full_adder_tb_arch of full_adder_tb is
    -- Component Declaration --
    component full_adder is
        port(
            ci_i: in std_logic;
            a_i: in std_logic;
            b_i: in std_logic;
            s_o: out std_logic;
            co_o: out std_logic 

        );
    end component;

    -- Signals Definition --
    XXX

begin

    -- Sequence Goes Here --

    DUT: full_adder
        port map(
            XXX
        );
end;
```

