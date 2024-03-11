
`timescale 1 ps / 1 ps
module RAM_ARD_tb();
	
	
	logic clk, rst, memWrite, ardwen;
	logic [19:0] arduinoAdd, out_addr;
	logic [15:0] dataWrite, arduinoW;
	logic [15:0] i1, dataArduino;
	
	
	
	//RegisterArduino ARD(clkArduino, rst, arduinoAdd, ArduinoAddUse);
	
	//ArduinoLogic ALG(ArduinoAddUse, arduinoAdd);
	
	
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
	dataArduino);
	
	*/
	
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
	dataArduino);
	

	
	
	initial begin 
		arduinoAdd = 0;
		rst = 0;
		clk = 0;
		#40
		rst = 1;
		#40
		rst = 0;
		#40
		
		for (int i =0; i<4; i=i+1 ) begin
		   arduinoAdd++;
			clk = 0;
			#40
			clk = 1;
			#40
		   clk = 0;	
		end
			
			
		clk = 0;
		
	end
	

endmodule