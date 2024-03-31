
module modUnit #(parameter N=32)(
	input logic [N-1:0] a, b,
	output logic [N-1:0] c,
	output logic cout, zero, overflow);

	logic [N+1:0] a_op, b_op, c_op_temp, c_op;
	
	assign a_op[N+1:N] = 2'b00;
	assign b_op[N+1:N] = 2'b00;
	assign a_op[N-1:0] = a;
	assign b_op[N-1:0] = b;
	assign c_op_temp = a_op / b_op;
	assign c_op = a_op - c_op_temp*b_op;
	assign c = c_op[N-1:0];
	
	assign zero = (a_op == 0);
	assign cout = c_op[N];
	assign overflow = c_op[N+1];

endmodule