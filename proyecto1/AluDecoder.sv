
module AluDecoder(input logic aluOp, s, input logic [2:0] cmd, output logic [3:0] aluControl, output 
       logic [1:0] flagW);

   
	//assign aluControl[1] = (aluOp == 1'b1)&((cmd == 4'b0000)|(cmd == 4'b1100));
	//assign aluControl[0] = (aluOp == 1'b1)&((cmd == 4'b0010)|(cmd == 4'b1100)|cmd == 4'b1010);
	assign aluControl = cmd;
	assign flagW[1] = (s == 1'b1);
	assign flagW[0] = ((aluOp == 1'b1)&(cmd == 3'b000)&(s == 1'b1))|
						((aluOp == 1'b1)&(cmd == 3'b001)&(s == 1'b1))|
						((aluOp == 1'b1)&(cmd == 3'b010)&(s == 1'b1))|
						((aluOp == 1'b1)&(cmd == 3'b011)&(s == 1'b1))|
						((aluOp == 1'b1)&(cmd == 3'b111)&(s == 1'b1))|
						((aluOp == 1'b1)&(cmd == 3'b100)&(s == 1'b1));


endmodule