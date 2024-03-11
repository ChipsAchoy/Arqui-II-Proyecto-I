
module ControlUnit(input logic clk, rst, input logic [1:0] op, input logic [3:0] cmd, input logic [1:0] ind, 
                  input logic [3:0] condRd, aluflags, 
						output logic pcSrc, regWrite, memWrite, memtoReg,
						aluSrc, output logic [1:0] immSrc, regSrc, output logic [3:0] aluControl);
	
	logic [1:0] flagW;
	logic pcs, regW, memW;
	
	logic pcSrcD, regWriteD, memWriteD, memtoRegD, aluSrcD; 
	//logic [1:0] immSrc, regSrc; 
	logic [3:0] aluControlD;
	
	Decoder D0(op, ind, cmd, condRd, 
					flagW, immSrc, regSrc, aluControl, pcs, regW, memW, memtoReg,
					aluSrc);

	ConditionLogic C1(condRd, aluFlags, flagW, 
						pcs, regW, memW, clk, rst, pcSrc, regWrite, memWrite);


endmodule