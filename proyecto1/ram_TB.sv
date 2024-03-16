`timescale 1ns/1ns

module ram_tb();
	

	/*
	---------------------------mem_control-------------------------------------
	*/
	logic   clk;
	logic	  rst;
	logic	[15:0][15:0]  data;
	logic	[17:0]  address;
	logic	  wren;
	logic	[15:0][15:0]  q;
	
	mem_control mem_c( 	rst,
								clk,
								data,
								address,
								wren,
								q );

	initial begin
		rst = 0;
		clk = 0;
		#1
		
		rst = 1;
		#1
		
		rst = 0;
		data = 0;
		address = 0;
		wren = 0;
		#3;
		clk = 1;
		#5
		clk = 0;
		#5;
		wren = 1;
		address = 0;
		data = 1;
		#5;
		clk = 1;
		#5
		clk = 0;
		#5;
		clk = 1;
		#10;
		
	end

	//always #5 clk = ~clk;

endmodule 