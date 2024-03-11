
module instRegister(input logic clk, rst, input logic [32:0] instructionF, output logic [32:0] instructionD);

	
	always @ (posedge clk or posedge rst) begin
		
		if (rst) instructionD = 0;
		else
		instructionD = instructionF;
	
	end

endmodule