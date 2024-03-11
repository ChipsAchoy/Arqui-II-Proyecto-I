
module AluDecoder(input logic aluOp, s, input logic [3:0] cmd, output logic [3:0] aluControl, output 
       logic [1:0] flagW);

   
	//assign aluControl[1] = (aluOp == 1'b1)&((cmd == 4'b0000)|(cmd == 4'b1100));
	//assign aluControl[0] = (aluOp == 1'b1)&((cmd == 4'b0010)|(cmd == 4'b1100)|cmd == 4'b1010);
	assign aluControl = cmd;
	assign flagW[1] = (s == 1'b1);
	assign flagW[0] = ((aluOp == 1'b1)&(cmd == 4'b0000)&(s == 1'b1))|
						((aluOp == 1'b1)&(cmd == 4'b0001)&(s == 1'b1))|
						((aluOp == 1'b1)&(cmd == 4'b0010)&(s == 1'b1))|
						((aluOp == 1'b1)&(cmd == 4'b0011)&(s == 1'b1))|
						((aluOp == 1'b1)&(cmd == 4'b0111)&(s == 1'b1));

endmodule