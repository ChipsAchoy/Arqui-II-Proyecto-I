module alu #(parameter N=32)(input [N-1:0] a, b, input logic[3:0] aluControl, output [N-1:0] resultado, 
									 output cout, zero, neg, overflow);
	logic[N:0] rs, rr;
	logic[N-1:0] resultado_s, resultado_r, resultado_m, resultado_d, resultado_aux;
	
	logic [N-1:0] shiftR1;
	logic [N-1:0] shiftR2;
	logic cout_aux , neg_aux, zero_aux, overflow_aux;
	logic cout_aux_s, neg_aux_s, zero_aux_s, overflow_aux_s;
	logic cout_aux_r, neg_aux_r, zero_aux_r, overflow_aux_r;
	logic cout_aux_m, zero_aux_m, overflow_aux_m;
	logic cout_aux_d, zero_aux_d, overflow_aux_d;
		
	
	
	logic [N-1:0] aux;
	logic_alu LU(a, b, r_and, r_or, r_xor, r_shiftR, r_shiftL, r_not);
	arith_alu AUS(a, b, 0, resultado_s, cout_aux_s, neg_aux_s, zero_aux_s, overflow_aux_s, shiftR1);
	arith_alu AUR(a, b, 1, resultado_r, cout_aux_r, neg_aux_r, zero_aux_r, overflow_aux_r, shiftR2);
	multiplyUnit MUL(a, b, resultado_m, cout_aux_m, zero_aux_m, overflow_aux_m);
	divUnit DIV(a, b, resultado_d, cout_aux_d, zero_aux_d, overflow_aux_d);
	
	
	
	always @* begin
	case (aluControl)
		4'b0000:
			resultado_aux = resultado_s;
		4'b0001:
			resultado_aux = resultado_r;
		4'b0010:
			resultado_aux = resultado_m;
		4'b0011:
			resultado_aux = resultado_d;
		4'b0100:
			resultado_aux = r_shiftR;
		4'b0101:
			resultado_aux = r_shiftL;
		4'b0110:
			resultado_aux = b;
		4'b0111:
			resultado_aux =resultado_r;
		4'b1000:
			resultado_aux =r_and;
		4'b1001:
			resultado_aux =r_or;
		4'b1010:
			resultado_aux =r_not;
		4'b1011:
			resultado_aux =r_xor;
		
		default: resultado_aux = 32'd0;
	endcase
	end
	
	
	always_comb begin
		
		if (aluControl == 4'b0000) begin
			cout_aux = cout_aux_s;
			neg_aux = neg_aux_s;
			zero_aux = zero_aux_s;
			overflow_aux = 0;
			
		end else if (aluControl == 4'b0001) begin
			cout_aux = cout_aux_r;
			neg_aux = neg_aux_r;
			zero_aux = zero_aux_r;
			overflow_aux = 0;
		
		end else if (aluControl == 4'b0010) begin
			cout_aux = cout_aux_m;
			neg_aux = 0;
			zero_aux = zero_aux_m;
			overflow_aux = overflow_aux_m;
			
		end else if (aluControl == 4'b0011) begin
			cout_aux = cout_aux_d;
			neg_aux = 0;
			zero_aux = zero_aux_d;
			overflow_aux = overflow_aux_d;
			
		end else if (aluControl == 4'b0111) begin
			cout_aux = cout_aux_r;
			neg_aux = neg_aux_r;
			zero_aux = zero_aux_r;
			overflow_aux = 0;
			
		end else begin
			cout_aux = 0;
			neg_aux = 0;
			zero_aux = 0;
			overflow_aux = 0;
			
		end
		
	end
	
	
	assign resultado = resultado_aux;
	assign cout = cout_aux;
	assign neg = neg_aux;
	assign zero = zero_aux;
	assign overflow = overflow_aux;
	
	
endmodule 