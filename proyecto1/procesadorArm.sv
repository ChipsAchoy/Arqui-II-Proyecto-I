
module procesadorArm(input logic clk, clkArduino, rst, start, 
input logic [7:0] dataIn, output logic  [7:0] dataArduino);

	
	
	procesador PR(clk, clkArduino, rst, start, dataIn, dataArduino);
				  

endmodule