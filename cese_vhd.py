# Author: lorsi@itba.edu.ar
import argparse
import os

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

args = parser.parse_args()
if args.create:
    run(get_create_command(args.create))
if args.sim:
    run(get_sim_command(args.sim))

