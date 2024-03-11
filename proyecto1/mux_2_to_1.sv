module mux_2_to_1_32 #(parameter N=32)(input [N-1:0] i1, i2, input logic sel, output [N-1:0] result);
	
	always @* begin
    if (sel)
      result = i1;
    else
      result = i2;
  end

endmodule