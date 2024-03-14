module mux_2_to_1_32_vec #(parameter N=32)(input [15:0][N-1:0] i1, i2, input logic sel, output logic [15:0][N-1:0] result);
	
	always @(*) begin
    if (sel) begin
      result = i1;
    end else begin
      result = i2;
	end
  end

endmodule