
module divUnit #(parameter N=32)(
	input logic [N-1:0] a, b,
	output logic [N-1:0] c,
	output logic cout, zero, overflow, neg);

	logic [31:0] a_op, b_op;
	logic [31:0] c_op;

	always_comb begin
		a_op[31:15] = 0;
		b_op[31:15] = 0;
		
		a_op[14:0] = a[14:0];
		b_op[14:0] = b[14:0];
	end
	
	always_comb begin
		if(a_op[7:0]) begin
			c_op = ((a_op << 8) / b_op);
		end
		else begin
			c_op = (a_op / b_op) << 8;
		end

		c[31:16] = 0;
		c[15] = a[15] ^ b[15];
		c[14:0] = c_op[14:0];
	end
	
	always_comb begin
		zero = (a_op == 0);
		cout = c_op[15];
		overflow = 0;
		neg = c[15];
	end
endmodule