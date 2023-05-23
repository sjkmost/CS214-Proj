# 
# Synthesis run script generated by Vivado
# 

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7a100tfgg484-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.cache/wt [current_project]
set_property parent.project_path D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo d:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/ip/RAM/dmem32.coe
add_files D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/ip/ROM/prgmip32.coe
read_verilog -library xil_defaultlib {
  D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/new/MemOrIO.v
  D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/new/alu.v
  D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/new/dffe32.v
  D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/new/mux2x32.v
  D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/new/mux2x5.v
  D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/new/mux4x32.v
  D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/new/pipedereg.v
  D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/new/pipeemreg.v
  D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/new/pipeexe.v
  D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/new/pipeid.v
  D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/new/pipeidcu.v
  D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/new/pipeif.v
  D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/new/pipeimem.v
  D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/new/pipeir.v
  D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/new/pipemem.v
  D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/new/pipemwreg.v
  D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/new/pipepc.v
  D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/new/regfile.v
  D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/new/seg_display.v
  D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/new/shift.v
  D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/new/pipelinedcpu.v
  D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/new/FSM2.v
}
read_ip -quiet D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/ip/RAM/RAM.xci
set_property used_in_implementation false [get_files -all d:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/ip/RAM/RAM_ooc.xdc]

read_ip -quiet D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/ip/ROM/ROM.xci
set_property used_in_implementation false [get_files -all d:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/ip/ROM/ROM_ooc.xdc]

read_ip -quiet d:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/ip/cpuclk/cpuclk.xci
set_property used_in_implementation false [get_files -all d:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/ip/cpuclk/cpuclk_board.xdc]
set_property used_in_implementation false [get_files -all d:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/ip/cpuclk/cpuclk.xdc]
set_property used_in_implementation false [get_files -all d:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/ip/cpuclk/cpuclk_ooc.xdc]

read_ip -quiet d:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/ip/memclk/memclk.xci
set_property used_in_implementation false [get_files -all d:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/ip/memclk/memclk_board.xdc]
set_property used_in_implementation false [get_files -all d:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/ip/memclk/memclk.xdc]
set_property used_in_implementation false [get_files -all d:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/sources_1/ip/memclk/memclk_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/constrs_1/new/src_xdc.xdc
set_property used_in_implementation false [get_files D:/lhy/semester2-2/computer_organization/lab/CS214-Proj/proj.srcs/constrs_1/new/src_xdc.xdc]


synth_design -top pipelinedcpu -part xc7a100tfgg484-1 -flatten_hierarchy none


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef pipelinedcpu.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file pipelinedcpu_utilization_synth.rpt -pb pipelinedcpu_utilization_synth.pb"