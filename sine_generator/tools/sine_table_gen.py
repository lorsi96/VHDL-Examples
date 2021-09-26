import numpy as np

import numpy as np
import matplotlib.pyplot as plt

# ******************************************************************************************************************** #
#                                                         Specs                                                        #
# ******************************************************************************************************************** #
BASE_CLOCK_HZ = 50e6
SINE_FREQUENCY_HZ = 100
SINE_N_SAMPLES = 2**6
SINE_N_LEVELS = 2**8

# ******************************************************************************************************************** #
#                                                     LUT Generator                                                    #
# ******************************************************************************************************************** #
LUT_TEMPLATE = '''begin
    case address is
{lut_entries}
    end case;
end process;'''

def lut_entry_gen(address, value, add_bits=8, val_bits=8):
  return ('        when "{0:0' + str(add_bits) +'b}" => result <= "{1:0' + str(val_bits) +'b}";').format(address, value)

def tab_gen(arr):
  add_bits = int(np.ceil(np.log2(len(arr))))
  val_bits = int(np.ceil(np.log2(max(arr))))
  return '\n'.join([lut_entry_gen(i, v, add_bits, val_bits) for i, v in enumerate(arr)])

x = np.linspace(0, 2*np.pi, SINE_N_SAMPLES)
y = (0.5 * np.sin(x) + 0.5)  * SINE_N_LEVELS
valid_levels = list(range(0, SINE_N_LEVELS))
y_quantized = np.digitize(y, range(0, SINE_N_LEVELS), True) - 1

# ******************************************************************************************************************** #
#                                                        Report                                                        #
# ******************************************************************************************************************** #
report = '''
--- Sinewave Specs ---
-- Clock Frequency (HZ):\t\t{clk_freq}
-- Sinewave Frequency (HZ):\t\t{sine_freq}
-- Sine Number of Samples:\t\t{sine_n_samples}
-- Sinewave Number of Bits:\t\t{sine_n_bits}
-- Table Clock Freq (HZ):\t\t{table_freq}
-- PWM Clock Frequency (HZ):\t\t{pwm_freq}
-- FPGA Clock Required Divider:\t\t{div}
-- Sine HZ with Int Divider ({int_div}):\t{freq_w_int}
-- Feasible:\t\t\t\t{feasible}
--- 
'''

div = BASE_CLOCK_HZ / (SINE_FREQUENCY_HZ * SINE_N_SAMPLES * SINE_N_LEVELS)
print(report.format(
    clk_freq = BASE_CLOCK_HZ,
    sine_freq = SINE_FREQUENCY_HZ,
    sine_n_samples = SINE_N_SAMPLES,
    sine_n_bits = int(np.ceil(np.log2(SINE_N_LEVELS))),
    table_freq = SINE_FREQUENCY_HZ * SINE_N_SAMPLES,
    pwm_freq = SINE_FREQUENCY_HZ * SINE_N_SAMPLES * SINE_N_LEVELS,
    int_div = int(div),
    freq_w_int = int(BASE_CLOCK_HZ / (int(div) * SINE_N_SAMPLES * SINE_N_LEVELS)),
    div = div,
    feasible = 'YES' if div >= 1 else 'NO'
))

if div >= 1:
    print(LUT_TEMPLATE.format(lut_entries = tab_gen(y_quantized)))
