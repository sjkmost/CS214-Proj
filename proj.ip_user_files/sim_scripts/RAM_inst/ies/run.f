-makelib ies_lib/xil_defaultlib -sv \
  "D:/Class/CS211/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/Class/CS211/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/blk_mem_gen_v8_4_1 \
  "../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../proj.srcs/sources_1/ip/RAM_inst/sim/RAM_inst.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

