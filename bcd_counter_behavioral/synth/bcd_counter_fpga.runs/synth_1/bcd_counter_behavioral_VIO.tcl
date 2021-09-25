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
set_param synth.incrementalSynthesisCache ./.Xil/Vivado-80772-lorsi-ThinkPad-T490/incrSyn
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7z010clg400-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /home/lorsi/FPGA/bcd_counter_behavioral/synth/bcd_counter_fpga.cache/wt [current_project]
set_property parent.project_path /home/lorsi/FPGA/bcd_counter_behavioral/synth/bcd_counter_fpga.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property board_part digilentinc.com:arty-z7-10:part0:1.0 [current_project]
set_property ip_output_repo /home/lorsi/FPGA/bcd_counter_behavioral/synth/bcd_counter_fpga.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  /home/lorsi/FPGA/bcd_counter_behavioral/src/bcd_counter_behavioral.vhd
  /home/lorsi/FPGA/bcd_counter_behavioral/src/bcd_counter_behavioral_VIO.vhd
}
read_ip -quiet /home/lorsi/FPGA/bcd_counter_behavioral/synth/bcd_counter_fpga.srcs/sources_1/ip/vio_1/vio_1.xci
set_property used_in_implementation false [get_files -all /home/lorsi/FPGA/bcd_counter_behavioral/synth/bcd_counter_fpga.srcs/sources_1/ip/vio_1/vio_1.xdc]
set_property used_in_implementation false [get_files -all /home/lorsi/FPGA/bcd_counter_behavioral/synth/bcd_counter_fpga.srcs/sources_1/ip/vio_1/vio_1_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc /home/lorsi/FPGA/bcd_counter_behavioral/src/Arty-Z7-10-Master.xdc
set_property used_in_implementation false [get_files /home/lorsi/FPGA/bcd_counter_behavioral/src/Arty-Z7-10-Master.xdc]

set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top bcd_counter_behavioral_VIO -part xc7z010clg400-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef bcd_counter_behavioral_VIO.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file bcd_counter_behavioral_VIO_utilization_synth.rpt -pb bcd_counter_behavioral_VIO_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
