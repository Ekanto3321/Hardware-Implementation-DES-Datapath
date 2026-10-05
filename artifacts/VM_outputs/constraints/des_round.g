# Virtual clock: no physical clock port exists in this design.
create_clock -name VCLK -period 10 -waveform {0 5}

set_input_delay -max 1.0 -clock [get_clocks VCLK] [all_inputs]
set_input_delay -min 0.0 -clock [get_clocks VCLK] [all_inputs]

set_output_delay -max 1.0 -clock [get_clocks VCLK] [all_outputs]
set_output_delay -min 0.0 -clock [get_clocks VCLK] [all_outputs]