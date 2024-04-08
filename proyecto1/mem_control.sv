module mem_control(
	rst,
	clk, 
	data,
	address,
	wren,
	vec_scalar,
	q);

	input	  rst;
	input	  clk;
	input	[15:0][31:0]  data;
	input	[12:0]  address;
	input	  wren;
	input	  vec_scalar;
	output [15:0][31:0]  q;
	
	
	assign q[0][31:16] = 0;
	assign q[1][31:16] = 0;
	assign q[2][31:16] = 0;
	assign q[3][31:16] = 0;
	assign q[4][31:16] = 0;
	assign q[5][31:16] = 0;
	assign q[6][31:16] = 0;
	assign q[7][31:16] = 0;
	assign q[8][31:16] = 0;
	assign q[9][31:16] = 0;
	assign q[10][31:16] = 0;
	assign q[11][31:16] = 0;
	assign q[12][31:16] = 0;
	assign q[13][31:16] = 0;
	assign q[14][31:16] = 0;
	assign q[15][31:16] = 0;
	
	/*
	---------------------------RAM 0-------------------------------------
	*/
<<<<<<< Updated upstream
	logic [17:0] address0;
	logic [15:0]data0;
	assign data0 = vec_scalar ? data[0][15:0]: data[15][15:0];
=======
	logic [12:0] address0;
>>>>>>> Stashed changes
	assign address0 = address + 0;
	
	ram ram0( rst,
				clk,
				data0,
				address0,
				wren,
				q[0][15:0] );
	/*
	---------------------------RAM 1-------------------------------------
	*/
	logic [12:0] address1;
	assign address1 = address + 1;
	ram ram1( rst,
				clk,
				data[1][15:0],
				address1,
				wren && vec_scalar,
				q[1][15:0] );
	/*
	---------------------------RAM 2-------------------------------------
	*/
	
	logic [12:0] address2;
	assign address2 = address + 2;
	ram ram2( rst,
				clk,
				data[2][15:0],
				address2,
				wren && vec_scalar,
				q[2][15:0] );
	
	/*
	---------------------------RAM 3-------------------------------------
	*/
	
	
	logic [12:0] address3;
	assign address3 = address + 3;
	ram ram3( rst,
				clk,
				data[3][15:0],
				address3,
				wren && vec_scalar,
				q[3][15:0] );
	
	/*
	---------------------------RAM 4-------------------------------------
	*/
	
	logic [12:0] address4;
	assign address4 = address + 4;
	ram ram4( rst,
				clk,
				data[4][15:0],
				address4,
				wren && vec_scalar,
				q[4][15:0] );
	/*
	---------------------------RAM 5-------------------------------------
	*/
	
	logic [12:0] address5;
	assign address5 = address + 5;
	ram ram5( rst,
				clk,
				data[5][15:0],
				address5,
				wren && vec_scalar,
				q[5][15:0] );
	/*
	---------------------------RAM 6-------------------------------------
	*/
	
	logic [12:0] address6;
	assign address6 = address + 6;
	ram ram6( rst,
				clk,
				data[6][15:0],
				address6,
				wren && vec_scalar,
				q[6][15:0] );

	/*
	---------------------------RAM 7-------------------------------------
	*/

	logic [12:0] address7;
	assign address7 = address + 7;
	ram ram7( rst,
				clk,
				data[7][15:0],
				address7,
				wren && vec_scalar,
				q[7][15:0] );
	/*
	---------------------------RAM 8-------------------------------------
	*/
	
	logic [12:0] address8;
	assign address8 = address + 8;
	ram ram8( rst,
				clk,
				data[8][15:0],
				address8,
				wren && vec_scalar,
				q[8][15:0] );
	/*
	---------------------------RAM 9-------------------------------------
	*/
	
	logic [12:0] address9;
	assign address9 = address + 9;
	ram ram9( rst,
				clk,
				data[9][15:0],
				address9,
				wren && vec_scalar,
				q[9][15:0] );
	
	/*
	---------------------------RAM 10-------------------------------------
	*/
	
	logic [12:0] address10;
	assign address10 = address + 10;
	ram ram10( rst,
				clk,
				data[10][15:0],
				address10,
				wren && vec_scalar,
				q[10][15:0] );
	
	/*
	---------------------------RAM 11-------------------------------------
	*/
	
	logic [12:0] address11;
	assign address11 = address + 11;
	ram ram11( rst,
				clk,
				data[11][15:0],
				address11,
				wren && vec_scalar,
				q[11][15:0] );
	/*
	---------------------------RAM 12-------------------------------------
	*/
	
	logic [12:0] address12;
	assign address12 = address + 12;
	ram ram12( rst,
				clk,
				data[12][15:0],
				address12,
				wren && vec_scalar,
				q[12][15:0] );
	/*
	---------------------------RAM 13-------------------------------------
	*/
	
	logic [12:0] address13;
	assign address13 = address + 13;
	ram ram13( rst,
				clk,
				data[13][15:0],
				address13,
				wren && vec_scalar,
				q[13][15:0] );
	/*
	---------------------------RAM 14-------------------------------------
	*/
	
	logic [12:0] address14;
	assign address14 = address + 14;
	ram ram14( rst,
				clk,
				data[14][15:0],
				address14,
				wren && vec_scalar,
				q[14][15:0] );
	/*
	---------------------------RAM 15-------------------------------------
	*/
	
	logic [12:0] address15;
	assign address15 = address + 15;
	ram ram15( rst,
				clk,
				data[15][15:0],
				address15,
				wren && vec_scalar,
				q[15][15:0] );




endmodule 