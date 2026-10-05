set_attr lib_search_path ../lib/
set_attr hdl_search_path ../rtl/
set_attr library slow.lib

read_hdl -v2001 des_round.v
elaborate des_round

read_sdc ../constraints/des_round.g

synthesize -to_mapped -effort medium

# Display reports in the RC console.
report area
report gates
report timing
report power

# Save reports for the submission.
report area   > area.rpt
report gates  > gates.rpt
report timing > timing.rpt
report power  > power.rpt

# Export mapped design and constraints.
write_hdl > des_round_netlist.v
write_sdc > des_round.sdc