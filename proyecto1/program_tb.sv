`timescale 1 ps / 1 ps
module program_tb();
	logic clk, rst, clkArduino, readEnable;
	logic  [15:0] dataArduino;

	//procesadorArm(input logic clk, clkArduino, rst, readEnable, output logic  [15:0] dataArduino);
	procesadorArm PARM(clk, clkArduino, rst, readEnable, dataArduino);
	
	initial begin 

		rst = 0;
		clk = 0;
		#40
		rst = 1;
		#40
		rst = 0;
		#40
		
		for (int i =0; i<120; i=i+1 ) begin
			clk = 0;
			#40
			clk = 1;
			#40
		   clk = 0;	
		end
			
			
		clk = 0;
		
	end
	

endmodule