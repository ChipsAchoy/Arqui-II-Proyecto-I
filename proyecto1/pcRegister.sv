
module pcRegister(input logic clk, rst, input logic [32:0] pcin, 
						output logic [32:0] pcout);

	
	always @ (posedge clk or posedge rst) begin
		
		if (rst) begin 
			pcout = 0;
			
			
		end else begin
			pcout = pcin;
			
		end
	
	end

endmodule