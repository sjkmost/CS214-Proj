set_property SRC_FILE_INFO {cfile:d:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/ip/memclk/memclk.xdc rfile:../../../proj.srcs/sources_1/ip/memclk/memclk.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.1
