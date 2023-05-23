-makelib ies_lib/xil_defaultlib -sv \
  "D:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../proj.srcs/sources_1/ip/memclk/memclk_clk_wiz.v" \
  "../../../../proj.srcs/sources_1/ip/memclk/memclk.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

