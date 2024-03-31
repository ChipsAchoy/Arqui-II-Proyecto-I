
module perfRegister(input logic clk, rst, input logic [5:0][31:0] pcin, 
						output logic [5:0][31:0] pcout);

	
	always @ (posedge clk or posedge rst) begin
		
		if (rst) begin 
			pcout[5:0] = 0;
			
			
		end else begin
			pcout = pcin;
			
		end
	
	end

endmodule