
module Commonregister(input logic clk, rst, input logic [19:0] varIn, output logic [19:0] varOut);

	
	always @ (posedge clk or posedge rst) begin
		
		if (rst) varOut = 0;
		else
		varOut = varIn;
	
	end

endmodule