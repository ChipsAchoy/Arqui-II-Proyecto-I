
module MainDecoder(input logic [1:0] op, input logic imm, mem, 
					output logic branch, memtoReg, memW, aluSrc, regW, aluOp,
					output logic [1:0] immSrc,  regSrc);
	
	
	assign branch = (op == 2'b10);
	assign memtoReg = (op == 2'b01) & (mem == 1'b1);
	assign memW = (op == 2'b01) & (mem == 1'b0);
	assign aluSrc = (op != 2'b11)& (!((op == 00) & (imm == 1'b0)));
	assign immSrc[1] = 0;
	assign immSrc[0] = 0;
	assign regW = (op != 2'b11)& (!( ((op == 2'b01)&(mem == 0)) | (op == 2'b10) ));
	assign regSrc[1] = ((op == 2'b01)&(mem == 0));
	assign regSrc[0] = (op == 2'b10);
	assign aluOp = (op == 2'b00)|(op == 2'b10);

endmodule


