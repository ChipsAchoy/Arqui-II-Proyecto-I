`timescale 1 ps / 1 ps
module program_final_tb();
	
	logic clk, rst;
	logic clk_step, clk_select;
	
	procesadorArm PARM(clk, clk_step, rst, clk_select);
	
	initial begin 
	
		clk_select = 0;
		rst = 0;
		clk = 0;
		#40
		rst = 1;
		#40
		rst = 0;
		#40
		
		for (int i =0; i<30; i=i+1 ) begin
			clk = 0;
			#40
			clk = 1;
			#40
			
			clk = 0;
			
			/*
			#40
			clk = 1;
			#40
			
			clk = 0;
			#40
			clk = 1;
			#40
			
			*/
			
			clk = 0;
		end
		
	end
	

endmodule