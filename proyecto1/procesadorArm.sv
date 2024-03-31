
module procesadorArm(input logic clk, clk_step, rst, clk_select);

	
	
	procesador PR(clk_final, rst);
	

	assign clk_final = (clk_select == 0) ? clk : clk_step;

endmodule