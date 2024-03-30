module alu #(parameter N=32)(input [N-1:0] a, b, input logic[2:0] aluControl, output [N-1:0] resultado, 
									 output cout, zero, neg, overflow);
	logic[N:0] rs, rr;
	logic[N-1:0] resultado_s, resultado_r, resultado_m, resultado_d, resultado_aux, resultado_mod;
	
	logic [N-1:0] shiftR1;
	logic [N-1:0] shiftR2;
	logic cout_aux , neg_aux, zero_aux, overflow_aux;
	logic cout_aux_s, neg_aux_s, zero_aux_s, overflow_aux_s;
	logic cout_aux_r, neg_aux_r, zero_aux_r, overflow_aux_r;
	logic cout_aux_m, zero_aux_m, overflow_aux_m;
	logic cout_aux_d, zero_aux_d, overflow_aux_d;
	logic cout_aux_mod, zero_aux_mod, overflow_aux_mod;
		
	
	
	logic [N-1:0] aux;
	logic_alu LU(a, b, r_and, r_or, r_xor, r_shiftR, r_shiftL, r_not);
	addUnit AUS(a, b, resultado_s, cout_aux_s, zero_aux_s, overflow_aux_s, neg_aux_s);
	subUnit AUR(a, b, resultado_r, cout_aux_r, zero_aux_r, overflow_aux_r, neg_aux_r);
	multiplyUnit MUL(a, b, resultado_m, cout_aux_m, zero_aux_m, overflow_aux_m);
	divUnit DIV(a, b, resultado_d, cout_aux_d, zero_aux_d, overflow_aux_d);
	modUnit MOD(a, b, resultado_mod, cout_aux_mod, zero_aux_mod, overflow_aux_mod);
	
	
	
	always @* begin
	case (aluControl)
		3'b000:
			resultado_aux = resultado_s;
		3'b001:
			resultado_aux = resultado_r;
		3'b010:
			resultado_aux = resultado_m;
		3'b011:
			resultado_aux = resultado_d;
		3'b100:
			resultado_aux = resultado_mod;
		3'b101:
			resultado_aux = r_shiftL;
		3'b110:
			resultado_aux = b;
		3'b111:
			resultado_aux = resultado_r;
		
		default: resultado_aux = 32'd0;
	endcase
	end
	
	
	always_comb begin
		
		if (aluControl == 3'b000) begin
			cout_aux = cout_aux_s;
			neg_aux = neg_aux_s;
			zero_aux = zero_aux_s;
			overflow_aux = 0;
			
		end else if (aluControl == 3'b001) begin
			cout_aux = cout_aux_r;
			neg_aux = neg_aux_r;
			zero_aux = zero_aux_r;
			overflow_aux = 0;
		
		end else if (aluControl == 3'b010) begin
			cout_aux = cout_aux_m;
			neg_aux = 0;
			zero_aux = zero_aux_m;
			overflow_aux = overflow_aux_m;
			
		end else if (aluControl == 3'b011) begin
			cout_aux = cout_aux_d;
			neg_aux = 0;
			zero_aux = zero_aux_d;
			overflow_aux = overflow_aux_d;
			
		end else if (aluControl == 3'b100) begin
			cout_aux = cout_aux_mod;
			neg_aux = 0;
			zero_aux = zero_aux_mod;
			overflow_aux = overflow_aux_mod;
			
		end else if (aluControl == 3'b111) begin
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
