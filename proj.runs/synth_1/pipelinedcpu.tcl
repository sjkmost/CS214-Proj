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
set_property webtalk.parent_dir {D:/workshops/sundry workshop/CO/project/CS214-Proj/proj.cache/wt} [current_project]
set_property parent.project_path {D:/workshops/sundry workshop/CO/project/CS214-Proj/proj.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo {d:/workshops/sundry workshop/CO/project/CS214-Proj/proj.cache/ip} [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  {D:/workshops/sundry workshop/CO/project/CS214-Proj/proj.srcs/sources_1/new/alu.v}
  {D:/workshops/sundry workshop/CO/project/CS214-Proj/proj.srcs/sources_1/new/dffe32.v}
  {D:/workshops/sundry workshop/CO/project/CS214-Proj/proj.srcs/sources_1/new/mux2x32.v}
  {D:/workshops/sundry workshop/CO/project/CS214-Proj/proj.srcs/sources_1/new/mux2x5.v}
  {D:/workshops/sundry workshop/CO/project/CS214-Proj/proj.srcs/sources_1/new/mux4x32.v}
  {D:/workshops/sundry workshop/CO/project/CS214-Proj/proj.srcs/sources_1/new/pipedereg.v}
  {D:/workshops/sundry workshop/CO/project/CS214-Proj/proj.srcs/sources_1/new/pipeemreg.v}
  {D:/workshops/sundry workshop/CO/project/CS214-Proj/proj.srcs/sources_1/new/pipeexe.v}
  {D:/workshops/sundry workshop/CO/project/CS214-Proj/proj.srcs/sources_1/new/pipeid.v}
  {D:/workshops/sundry workshop/CO/project/CS214-Proj/proj.srcs/sources_1/new/pipeidcu.v}
  {D:/workshops/sundry workshop/CO/project/CS214-Proj/proj.srcs/sources_1/new/pipeif.v}
  {D:/workshops/sundry workshop/CO/project/CS214-Proj/proj.srcs/sources_1/new/pipeimem.v}
  {D:/workshops/sundry workshop/CO/project/CS214-Proj/proj.srcs/sources_1/new/pipeir.v}
  {D:/workshops/sundry workshop/CO/project/CS214-Proj/proj.srcs/sources_1/new/pipemem.v}
  {D:/workshops/sundry workshop/CO/project/CS214-Proj/proj.srcs/sources_1/new/pipemwreg.v}
  {D:/workshops/sundry workshop/CO/project/CS214-Proj/proj.srcs/sources_1/new/pipepc.v}
  {D:/workshops/sundry workshop/CO/project/CS214-Proj/proj.srcs/sources_1/new/regfile.v}
  {D:/workshops/sundry workshop/CO/project/CS214-Proj/proj.srcs/sources_1/new/shift.v}
  {D:/workshops/sundry workshop/CO/project/CS214-Proj/proj.srcs/sources_1/new/pipelinedcpu.v}
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}

synth_design -top pipelinedcpu -part xc7a100tfgg484-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef pipelinedcpu.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file pipelinedcpu_utilization_synth.rpt -pb pipelinedcpu_utilization_synth.pb"
