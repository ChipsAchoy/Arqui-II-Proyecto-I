module multiplyUnit #(parameter N=32)(
	input logic [N-1:0] a, b,
	output logic [N-1:0] c, 
	output logic cout, zero, overflow, neg);

	logic [15:0] a_op, b_op;
	logic [31:0] c_op;
	
	assign a_op[14:0] = a[14:0];
	assign b_op[14:0] = b[14:0];
	
	assign a_op[15] = 0;
	assign b_op[15] = 0;
	
	assign c_op = (a_op * b_op) >> 8;
	assign c[31:16] = 0;
	assign c[15] = a[15] ^ b[15];
	assign c[14:0] = c_op[14:0];

	assign zero = (a_op == 0);
	assign cout = c_op[15];
	assign overflow = 0;
	assign neg = c[15];
endmodule