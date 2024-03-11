

module adder #(parameter N=16)(input logic [N-1:0] a, b, output logic [N-1:0] c, output logic neg, cout, zero);
   
	
	logic [N:0] b_neg, a_neg; 
	logic [N:0] a_op, b_op, c_op; 	
	
	always_comb begin
	
	   a_neg[N:N-1] = 2'b00;
		b_neg[N:N-1] = 2'b00;
		
		a_op[N:N-1] = 2'b00;
		b_op[N:N-1] = 2'b00;
		
		a_op[N-2:0] = a[N-2:0];
		b_op[N-2:0] = b[N-2:0];
		
		if (a[N-1] == b[N-1]) begin
			
			c_op <= a_op + b_op;
			neg <= a[N-1];
			c[N-1] <= a[N-1];
			cout <= c_op[N] & ~(a[N-1]);
		
		end else if ((a[N-1] == 0) && (b[N-1] == 1)) begin
			
			if ((a_op > b_op)) begin
			
				neg <= 0;
				c[N-1] <= 0;
			
			end else begin
			
				neg <= 1;
				c[N-1] <= 1;
			end
			
			b_neg[N-2] = ~(b[N-2:0]) + 1;
			
			c_op <= a_op + b_neg;
			cout <= 0;
			
		
		
		end else if ((a[N-1] == 1) && (b[N-1] == 0)) begin
			
			if ((a_op < b_op)) begin
			
				neg <= 0;
				c[N-1] <= 0;
			
			end else begin
			
				neg <= 1;
				c[N-1] <= 1;
			end
			
			
			a_neg[N-2] = ~(a[N-2:0]) + 1;
			
			c_op <= b_op + a_neg;
		   cout <= 0;
			
		
		end
	   
	
	end

	
	assign c[N-2:0] = c_op[N-2:0];


endmodule