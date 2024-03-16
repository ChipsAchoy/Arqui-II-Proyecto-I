
module procesador(input logic clk, clkArduino, rst,  readEnable, 
input logic [7:0] dataIn, output logic [7:0] dataArduino);
	
	logic [31:0] instructionF;
	logic [31:0] instructionD;
	logic [31:0] pc;
	logic [31:0] pcUse;
	logic [15:0][31:0] dataRead, dataWrite;
	logic memWrite;
	logic [17:0] addr;
	logic [1:0] select; 
	logic [19:0] out_addr;
	logic [31:0] i1, i2, i3;
	logic [31:0] result;
	logic [19:0] arduinoAdd;
	logic [19:0] arduinoAddUse;
	logic [15:0] arduinoW;
	logic [15:0] dataArduinoAux;
	
	logic ardwen;
	logic vec_scalar;
	
	initial begin
	
		//arduinoAdd = 0;
		pc = 0;
		pcUse = 0;
		
	end
	
	
	
   //RegisterArduino ARD(clkArduino, rst, arduinoAddUse, arduinoAdd);
	
	//ArduinoLogic ALG(arduinoAdd, arduinoAddUse);
	
	pcRegister P0(clk, rst, pc, pcUse);
	
	InstructionMemory IM(clk,rst, pcUse, instructionF);
	
	PipeRegFD regFD(clk, rst, instructionF, instructionD);
	
	cpu CPU(clk, rst, instructionD, dataRead, pcUse, pc, dataWrite, memWrite, addr, vec_scalar);
	
	mem_control MEM(
	rst,
	clk, 
	dataWrite,
	addr,
	memWrite,
	vec_scalar,
	dataRead);
	
	
	
	//ChipSet CS(addr, select, out_addr);
	
	//mux_3_to_1_32 MUX(i1, i2, i3, select, result);
	
	
	//DROMMemory DROM(rst, out_addr[15:0], clk, i2);
	/*
   DRAMMemory DRAM(
	rst,
	out_addr,
	clk,
	dataWrite,
	memWrite,
	i1);
	
	*/
	/*
	DRAMMemoryArd DRAM(
	rst,
	out_addr,
	arduinoAdd,
	clk,
	dataWrite,
	arduinoW,
	memWrite,
	ardwen,
	i1,
	dataArduinoAux);
	
	*/
	
	//assign dataArduino = dataArduinoAux;
	//assign dataRead = result;
	//assign arduinoAdd[3:0] = dataIn[3:0];
	//assign arduinoAdd[19:4] = 0;
	//assign dataArduino[3:0] = dataArduinoAux[3:0];
	//assign dataArduino[7:4] = 0;
	
endmodule