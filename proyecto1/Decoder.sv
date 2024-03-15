
module Decoder(input logic [1:0] op, input logic [1:0] immS, input logic [2:0] cmd, input logic [3:0] condRd,
					output logic [1:0] flagW, immSrc, regSrc, output logic [2:0] aluControl, output logic pcs, regW, memW, memtoReg,
					aluSrc, branchOut);
	
	logic branch, aluOp;	
	
	MainDecoder M0(op, immS[1], cmd[0], 
					branch, memtoReg, memW, aluSrc, regW, aluOp,
					immSrc,  regSrc);
	
	PCLogic L0(condRd, branch, regW, pcs);
	AluDecoder A0(aluOp, immS[0], cmd, aluControl, flagW);
	
	assign branchOut = branch; 
	
endmodule