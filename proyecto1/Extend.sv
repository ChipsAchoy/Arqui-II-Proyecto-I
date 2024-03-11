
module Extend(input logic [15:0] immediate, input logic [1:0] immSrc, output logic [31:0] extImm);
/*
	always_comb begin
	
		case (immSrc) 
		
			2'b00: begin
				extImm[31:16] = 16'd0;
				extImm[15:0] = immediate[15:0];
			end
			2'b01: begin
				extImm[31:24] = 8'd0;
				extImm[23:0] = immediate[23:0];
			end
			default: begin
				extImm[31:8] = 16'd0;
				extImm[15:0] = immediate[15:0];
			end
		endcase
	
	end
	*/
	assign extImm[31:16] = 16'd0;
	assign extImm[15:0] = immediate;

endmodule