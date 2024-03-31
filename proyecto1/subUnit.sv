module subUnit #(parameter N=32)(
	input logic [N-1:0] a, b,
	output logic [N-1:0] c,
	output logic cout, zero, overflow, neg);

	logic [15:0] a_op, b_op, c_op;
	
	assign a_op[14:0] = a[14:0];
	assign b_op[14:0] = b[14:0];
	
	assign a_op[15] = 0;
	assign b_op[15] = 0;

	always_comb begin
		if((~a[15] & b[15]) | (a[15] & ~b[15])) begin
			c_op = (a_op + b_op);
		end
		else begin
			c_op = (a_op < b_op) ? (b_op - a_op) : (a_op - b_op);
		end
	end

	always_comb begin
		c[31:16] = 0;

		if(a[15] & ~b[15]) begin
			c[15] = 1;
		end
		else if((a[15] & b[15]) & (a_op > b_op)) begin
			c[15] = 1;
		end
		else if((~a[15] & ~b[15]) & (a_op < b_op)) begin
			c[15] = 1;
		end
		else begin
			c[15] = 0;
		end

		c[14:0] = c_op[14:0];
		
		zero = (c_op == 0);
		cout = c_op[15];
		overflow = 0;
		neg = c[15];
	end
endmodule