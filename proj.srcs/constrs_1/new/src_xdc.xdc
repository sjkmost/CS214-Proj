set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property PACKAGE_PIN Y18 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports reset]
set_property PACKAGE_PIN P20 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports button]
set_property PACKAGE_PIN P4 [get_ports button]

set_property IOSTANDARD LVCMOS33 [get_ports {io_r1[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_r1[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_r1[0]}]
set_property PACKAGE_PIN Y9 [get_ports {io_r1[2]}]
set_property PACKAGE_PIN W9 [get_ports {io_r1[1]}]
set_property PACKAGE_PIN Y7 [get_ports {io_r1[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports {io_r2[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_r2[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_r2[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_r2[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_r2[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_r2[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_r2[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_r2[0]}]
set_property PACKAGE_PIN U6 [get_ports {io_r2[7]}]
set_property PACKAGE_PIN W5 [get_ports {io_r2[6]}]
set_property PACKAGE_PIN W6 [get_ports {io_r2[5]}]
set_property PACKAGE_PIN U5 [get_ports {io_r2[4]}]
set_property PACKAGE_PIN T5 [get_ports {io_r2[3]}]
set_property PACKAGE_PIN T4 [get_ports {io_r2[2]}]
set_property PACKAGE_PIN R4 [get_ports {io_r2[1]}]
set_property PACKAGE_PIN W4 [get_ports {io_r2[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports io_w_led]
set_property PACKAGE_PIN A21 [get_ports io_w_led]

set_property IOSTANDARD LVCMOS33 [get_ports {seg_en[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_en[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_en[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_en[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_en[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_en[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_en[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_en[0]}]
set_property PACKAGE_PIN A18 [get_ports {seg_en[0]}]
set_property PACKAGE_PIN A20 [get_ports {seg_en[1]}]
set_property PACKAGE_PIN B20 [get_ports {seg_en[2]}]
set_property PACKAGE_PIN E18 [get_ports {seg_en[3]}]
set_property PACKAGE_PIN F18 [get_ports {seg_en[4]}]
set_property PACKAGE_PIN D19 [get_ports {seg_en[5]}]
set_property PACKAGE_PIN E19 [get_ports {seg_en[6]}]
set_property PACKAGE_PIN C19 [get_ports {seg_en[7]}]

set_property IOSTANDARD LVCMOS33 [get_ports {seg_out[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_out[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_out[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_out[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_out[0]}]
set_property PACKAGE_PIN F15 [get_ports {seg_out[7]}]
set_property PACKAGE_PIN F13 [get_ports {seg_out[6]}]
set_property PACKAGE_PIN F14 [get_ports {seg_out[5]}]
set_property PACKAGE_PIN F16 [get_ports {seg_out[4]}]
set_property PACKAGE_PIN E17 [get_ports {seg_out[3]}]
set_property PACKAGE_PIN C14 [get_ports {seg_out[2]}]
set_property PACKAGE_PIN C15 [get_ports {seg_out[1]}]
set_property PACKAGE_PIN E13 [get_ports {seg_out[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports {state[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {state[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {state[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {state[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {state[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {state[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {state[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {state[0]}]
set_property PACKAGE_PIN K17 [get_ports {state[7]}]
set_property PACKAGE_PIN L13 [get_ports {state[6]}]
set_property PACKAGE_PIN M13 [get_ports {state[5]}]
set_property PACKAGE_PIN K14 [get_ports {state[4]}]
set_property PACKAGE_PIN K13 [get_ports {state[3]}]
set_property PACKAGE_PIN M20 [get_ports {state[2]}]
set_property PACKAGE_PIN N20 [get_ports {state[1]}]
set_property PACKAGE_PIN N19 [get_ports {state[0]}]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {reset_IBUF}]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {button_IBUF}]