# Author: lorsi@itba.edu.ar
import argparse
import os

# ******************************************************************************************************************** #
#                                                  Testbench Template                                                  #
# ******************************************************************************************************************** #
MODULE_TEMPLATE = '''library IEEE;
use IEEE.std_logic_1164.all;

entity {0} is
    port(
        a_i: in std_logic;
        b_o: out std_logic 
    );
end;

architecture {0}_arch of {0} is
    begin
        b_o <= not a_i;
    end;'''

TESTBENCH_TEMPLATE = '''library IEEE;
use IEEE.std_logic_1164.all;

entity {0}_tb is
end;

architecture {0}_tb_arch of {0}_tb is
    -- Component Declaration --
    component {0} is
        port(
{1}
        );
    end component;

    -- Signals Definition --
    XXX

begin

    -- Sequence Goes Here --

    DUT: {0}
        port map(
            XXX
        );
end;'''



STOP_TIME = 1000  # Nanoseconds.

def get_deps(name):
    with open(f'./{name}/{name}.deps') as f:
        return ' '.join(['../../{0}/src/{0}.vhd'.format(l.strip()) for l in f.readlines()])


def get_create_command(name):
    return f'mkdir {name}; cd {name} && mkdir src && mkdir sim && mkdir synth && touch ./src/{name}.vhd && touch ./src/{name}_tb.vhd && touch {name}.deps'

def get_sim_command(name):
    deps = get_deps(name)
    sim_path = os.path.join(name, 'sim')
    vhd_path = os.path.join('..', 'src', name + '.vhd')
    vhd_tb_path = os.path.join('..', 'src', name + '_tb.vhd')
    cmds = [
        f'cd {sim_path}',
        f'ghdl -a {vhd_path} {vhd_tb_path} {deps}',
        f'ghdl -s {vhd_path} {vhd_tb_path} {deps}',
        f'ghdl -e {name}_tb',
        f'ghdl -r {name}_tb --vcd={name}_tb.vcd --stop-time={STOP_TIME}ns',
        f'gtkwave {name}_tb.vcd'
    ]
    return ' && '.join(cmds)


run =  os.system

parser = argparse.ArgumentParser(description='Create a simple VHDL module.')
parser.add_argument('--create', type=str,
                    help='create a new example following the suggested folder structure')
parser.add_argument('--sim', type=str,
                    help='run a ghdl + gtk wave for a given example')

parser.add_argument('--testbench', type=str,
                    help='run a ghdl + gtk wave for a given example')


if __name__ == '__main__':
    args = parser.parse_args()
    if args.create:
        run(get_create_command(args.create))
        with open(f'./{args.create}/src/{args.create}.vhd', 'w+') as f:
            f.write(MODULE_TEMPLATE.format(args.create))
    if args.sim:
        run(get_sim_command(args.sim))
    if args.testbench:
        (f0, f1, f2, f3) = ('', '', '', '')
        f0 = args.testbench

        port_matched = False
        with open(f'./{args.testbench}/src/{args.testbench}.vhd') as f:
            for line in f.readlines():
                if 'port' in line:
                    port_matched = True
                    continue
                if port_matched:
                    if ');' in line:
                        break
                    else:
                        f1 += '            ' + line.lstrip()
                
        print(TESTBENCH_TEMPLATE.format(f0, f1))

    


        

