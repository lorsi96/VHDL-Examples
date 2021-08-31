# Author: lorsi@itba.edu.ar
import argparse
import os

# ******************************************************************************************************************** #
#                                                  Testbench Template                                                  #
# ******************************************************************************************************************** #
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

def get_create_command(name):
    return f'mkdir {name}; cd {name} && mkdir src && mkdir sim && mkdir synth && touch ./src/{name}.vhd && touch ./src/{name}_tb.vhd'

def get_sim_command(name):
    sim_path = os.path.join(name, 'sim')
    vhd_path = os.path.join('..', 'src', name + '.vhd')
    vhd_tb_path = os.path.join('..', 'src', name + '_tb.vhd')
    cmds = [
        f'cd {sim_path}',
        f'ghdl -a {vhd_path} {vhd_tb_path}',
        f'ghdl -s {vhd_path} {vhd_tb_path}',
        f'ghdl -e {name}_tb',
        f'ghdl -r {name}_tb --vcd={name}_tb.vcd --stop-time={STOP_TIME}ns',
        f'gtkwave {name}_tb.vcd'
    ]
    return ' && '.join(cmds)


run = os.system

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

    


        

