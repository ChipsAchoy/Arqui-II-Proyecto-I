module mem_control(
	rst,
	clk, 
	data,
	rdaddress,
	wraddress,
	wren,
	vec_scalar,
	q);
	input	  rst;
	input	  clk;
	input	[15:0][31:0]  data;
	input	[17:0]  rdaddress;
	input	[17:0]  wraddress;
	input	  wren, vec_scalar;
	output [15:0][31:0]  q;


endmodule