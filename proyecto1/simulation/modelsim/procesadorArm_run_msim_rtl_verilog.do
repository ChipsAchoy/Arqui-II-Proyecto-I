transcript on
if ![file isdirectory verilog_libs] {
	file mkdir verilog_libs
}

vlib verilog_libs/altera_ver
vmap altera_ver ./verilog_libs/altera_ver
vlog -vlog01compat -work altera_ver {d:/quartuslite/quartus/eda/sim_lib/altera_primitives.v}

vlib verilog_libs/lpm_ver
vmap lpm_ver ./verilog_libs/lpm_ver
vlog -vlog01compat -work lpm_ver {d:/quartuslite/quartus/eda/sim_lib/220model.v}

vlib verilog_libs/sgate_ver
vmap sgate_ver ./verilog_libs/sgate_ver
vlog -vlog01compat -work sgate_ver {d:/quartuslite/quartus/eda/sim_lib/sgate.v}

vlib verilog_libs/altera_mf_ver
vmap altera_mf_ver ./verilog_libs/altera_mf_ver
vlog -vlog01compat -work altera_mf_ver {d:/quartuslite/quartus/eda/sim_lib/altera_mf.v}

vlib verilog_libs/altera_lnsim_ver
vmap altera_lnsim_ver ./verilog_libs/altera_lnsim_ver
vlog -sv -work altera_lnsim_ver {d:/quartuslite/quartus/eda/sim_lib/altera_lnsim.sv}

vlib verilog_libs/cyclonev_ver
vmap cyclonev_ver ./verilog_libs/cyclonev_ver
vlog -vlog01compat -work cyclonev_ver {d:/quartuslite/quartus/eda/sim_lib/mentor/cyclonev_atoms_ncrypt.v}
vlog -vlog01compat -work cyclonev_ver {d:/quartuslite/quartus/eda/sim_lib/mentor/cyclonev_hmi_atoms_ncrypt.v}
vlog -vlog01compat -work cyclonev_ver {d:/quartuslite/quartus/eda/sim_lib/cyclonev_atoms.v}

vlib verilog_libs/cyclonev_hssi_ver
vmap cyclonev_hssi_ver ./verilog_libs/cyclonev_hssi_ver
vlog -vlog01compat -work cyclonev_hssi_ver {d:/quartuslite/quartus/eda/sim_lib/mentor/cyclonev_hssi_atoms_ncrypt.v}
vlog -vlog01compat -work cyclonev_hssi_ver {d:/quartuslite/quartus/eda/sim_lib/cyclonev_hssi_atoms.v}

vlib verilog_libs/cyclonev_pcie_hip_ver
vmap cyclonev_pcie_hip_ver ./verilog_libs/cyclonev_pcie_hip_ver
vlog -vlog01compat -work cyclonev_pcie_hip_ver {d:/quartuslite/quartus/eda/sim_lib/mentor/cyclonev_pcie_hip_atoms_ncrypt.v}
vlog -vlog01compat -work cyclonev_pcie_hip_ver {d:/quartuslite/quartus/eda/sim_lib/cyclonev_pcie_hip_atoms.v}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/ram.v}
vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/PipeRegMW.sv}
vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/PipeRegFD.sv}
vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/PipeRegEM.sv}
vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/PipeRegDE.sv}
vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/RegisterFile.sv}
vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/MainDecoder.sv}
vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/AluDecoder.sv}
vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/PCLogic.sv}
vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/Decoder.sv}
vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/ConditionCheck.sv}
vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/ConditionLogic.sv}
vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/Extend.sv}
vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/plus_n.sv}
vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/mux_2_to_1_32.sv}
vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/mux_2_to_1_4.sv}
vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/alu.sv}
vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/arith_alu.sv}
vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/logic_alu.sv}
vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/pcRegister.sv}
vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/cpu.sv}
vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/procesador.sv}
vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/procesadorArm.sv}
vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/multiplyUnit.sv}
vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/divUnit.sv}
vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/mux_2_to_1_32_vec.sv}
vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/modUnit.sv}
vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/mem_control.sv}
vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/InstructionMemory.sv}

vlog -sv -work work +incdir+C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1 {C:/Users/INTEL/Documents/GitHub/Arqui-II-Proyecto-I/proyecto1/program_final_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  program_final_tb

add wave *
view structure
view signals
run -all
