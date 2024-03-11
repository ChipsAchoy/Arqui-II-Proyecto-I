
module cpu(input logic clk, rst, input logic [31:0] instructionD, 
            input logic [31:0] dataRead, input logic [31:0] pc,
				output logic [31:0] pcOut, dataWrite, output logic memWrite, 
				output [20:0] addr);
	
	logic [3:0] aluFlags, aluControl, CondE, FlagsD, FlagsE;
	logic pcSrc, regWrite, memtoReg, aluSrc;
	logic [1:0] regSrc, FlagWriteD, FlagWriteE, ImmSrcD;
	logic [3:0]  ALUControlD, ALUControlE;
	logic [3:0] a1, a2, a3;
	logic [31:0] pc_plus_4, pc_plus_4D;
	logic [31:0] pc_plus_8;
	logic [31:0] rd1D, rd1E, rd2D, rd2E;
	logic [31:0] extImm, extImmE, aluResult, aluResultD, aluResultW, srcB, srcA; 
	logic [31:0] resultPc;
	logic [3:0] WA3D, WA3E, WA3M, WA3W;
	logic [31:0] ReadDataM, ReadDataW, ExtImmD, ExtImmE, WriteDataM, ALUResultE, ALUResultM, ALUResultW;
	
	logic PCSrcD, PCSrcE, PCSrcE2, PCSrcM, PCSrcW, 
	RegWriteD, RegWriteE, RegWriteE2, RegWriteM, 
	RegWriteW, MemWriteD, MemWriteM, MemWriteE, MemWriteE2, 
	MemtoRegD, MemtoRegE, MemtoRegM, MemtoRegW, ALUSrcD, ALUSrcE, BranchD, BranchE;

	
	Decoder D0(instructionD[31:30], instructionD[25:24], instructionD[29:26], instructionD[23:20], 
					FlagWriteD, ImmSrcD, regSrc, ALUControlD, PCSrcD, RegWriteD, MemWriteD, MemtoRegD,
					ALUSrcD, BranchD);
	
	PipeRegDE regDE(clk, rst, 
						 rd1D, rd2D, ExtImmD, instructionD[23:20], FlagsD, PCSrcD, RegWriteD, MemtoRegD, MemWriteD, ALUControlD, BranchD, ALUSrcD, FlagWriteD, instructionD[23:20],
						 rd1E, rd2E, ExtImmE, CondE, FlagsE, PCSrcE, RegWriteE, MemtoRegE, MemWriteE, ALUControlE, BranchE, ALUSrcE, FlagWriteE, WA3E);
	
	ConditionLogic C1(CondE, aluFlags, FlagWriteE, 
						   PCSrcE, RegWriteE, MemWriteE, clk, rst, PCSrcE2, RegWriteE2, MemWriteE2);
	
	PipeRegEM regEM(clk, rst, 
						 ALUResultE, rd2E, PCSrcE2, RegWriteE2, MemtoRegE, MemWriteE2, WA3E,
						 ALUResultM, WriteDataM, PCSrcM, RegWriteM, MemtoRegM, MemWriteM, WA3M);
	
	PipeRegMW regMW(clk, rst, 
						 ALUResultM, dataRead, PCSrcM, RegWriteM, MemtoRegM, WA3M,
						 ALUResultW, ReadDataW, PCSrcW, RegWriteW, MemtoRegW, WA3W);
	
	mux_2_to_1_4 M0(4'd15, instructionD[19:16], regSrc[0], a1);
	mux_2_to_1_4 M1(instructionD[23:20], instructionD[3:0], regSrc[1], a2);
	
	
	plus_n P4(pc, 32'd4, pc_plus_4);
	//plus_n P8(pc_plus_4, 32'd4, pc_plus_8);
	
	RegisterFile R0(clk,rst, RegWriteW, 
               a1, a2, WA3W, 
               resultPc, pc_plus_4,
               rd1D, rd2D);
	
	Extend E0(instructionD[15:0], ImmSrcD, ExtImmD);
	mux_2_to_1_32 M2(ExtImmE, rd2E, ALUSrcE, srcB);
	
	alu A0(rd1E, srcB, ALUControlE, ALUResultE, aluFlags[1], aluFlags[2], aluFlags[3], aluFlags[0]);
	
	mux_2_to_1_32 M3(ReadDataW, ALUResultW, MemtoRegW, resultPc);
	mux_2_to_1_32 M4(resultPc, pc_plus_4, PCSrcW, pcOut);
	
	
	assign addr = ALUResultM[20:0];
	assign dataWrite = WriteDataM;
	assign memWrite = MemWriteM;
	

endmodule
