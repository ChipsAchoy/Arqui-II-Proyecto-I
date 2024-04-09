vsim -gui -voptargs=+acc=npr -l /dev/null -L altera_mf_ver -L altera_mf work.data_instructions_tb

add wave -position insertpoint sim:/data_instructions_tb/dut/PR/CPU/clk
add wave -position insertpoint sim:/data_instructions_tb/dut/PR/CPU/pc
add wave -position insertpoint sim:/data_instructions_tb/dut/PR/CPU/instructionD
add wave -position insertpoint sim:/data_instructions_tb/dut/PR/CPU/R0/rf_s
add wave -position insertpoint sim:/data_instructions_tb/dut/PR/MEM/ram0/altsyncram_component/m_default/altsyncram_inst/mem_data
add wave -position insertpoint sim:/data_instructions_tb/dut/PR/MEM/ram15/altsyncram_component/m_default/altsyncram_inst/mem_data