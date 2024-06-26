
module cpu(input logic clk, rst, input logic [31:0] instructionD, 
            input logic [15:0][31:0] dataRead_i, input logic [31:0] pc,
				output logic [31:0] pcOut, output logic [15:0][31:0] dataWrite_i, output logic memWrite, 
				output [12:0] addr, output logic vec_scalar);
	
	logic [3:0] aluFlags, CondE, FlagsD, FlagsE;
	logic [3:0] aluFlagsF1, aluFlagsF2, aluFlagsF3, aluFlagsF4, aluFlagsF5, aluFlagsF6, aluFlagsF7;
	logic [3:0] aluFlagsF8, aluFlagsF9, aluFlagsF10, aluFlagsF11, aluFlagsF12, aluFlagsF13, aluFlagsF14, aluFlagsF15;
	logic pcSrc, regWrite, memtoReg, aluSrc;
	logic [1:0] regSrc, FlagWriteD, FlagWriteE, ImmSrcD;
	logic [2:0] ALUControlD, ALUControlE, aluControl, ALUControlM, ALUControlW;
	logic [2:0] ALUControlE1, ALUControlE2, ALUControlE3, ALUControlE4, ALUControlE5, ALUControlE6, ALUControlE7, ALUControlE8;
	logic [2:0] ALUControlE9, ALUControlE10, ALUControlE11, ALUControlE12, ALUControlE13, ALUControlE14, ALUControlE15;
	logic [3:0] a1, a2, a3;
	logic [31:0] pc_plus_4, pc_plus_4D;
	logic [31:0] pc_plus_8;
	logic [15:0][31:0] rd1D, rd1E, rd2D, rd2E;
	logic [31:0] extImm, extImmE;
	logic [15:0][31:0] resultPc;
	logic [3:0] WA3D, WA3E, WA3M, WA3W;
	logic [31:0] ExtImmD, ExtImmE;
	logic [15:0][31:0] ALUResultE, ALUResultEUse, ALUResultM, ALUResultW, WriteDataM, ReadDataM, ReadDataW, ReadDataUse;
	logic [15:0][31:0] ExtImmSrc, srcB;
	logic [31:0] SUM_Result;
	logic v_s, v_s_d, v_s_e, v_s_m, v_s_z;
	
	logic PCSrcD, PCSrcE, PCSrcE2, PCSrcM, PCSrcW, 
	RegWriteD, RegWriteE, RegWriteE2, RegWriteM, 
	RegWriteW, MemWriteD, MemWriteM, MemWriteE, MemWriteE2, 
	MemtoRegD, MemtoRegE, MemtoRegM, MemtoRegW, ALUSrcD, ALUSrcE, BranchD, BranchE;

	
	Decoder D0(instructionD[31:30], instructionD[25:24], instructionD[29:27], instructionD[23:20], 
					FlagWriteD, ImmSrcD, regSrc, ALUControlD, PCSrcD, RegWriteD, MemWriteD, MemtoRegD,
					ALUSrcD, BranchD);
	
	PipeRegDE regDE(clk, rst, 
						 rd1D, rd2D, ExtImmD, instructionD[23:20], FlagsD, PCSrcD, RegWriteD, MemtoRegD, MemWriteD, ALUControlD, BranchD, ALUSrcD, FlagWriteD, 
						 instructionD[23:20], v_s,
						 rd1E, rd2E, ExtImmE, CondE, FlagsE, PCSrcE, RegWriteE, MemtoRegE, MemWriteE, ALUControlE, BranchE, ALUSrcE, FlagWriteE, WA3E, v_s_e);
	
	ConditionLogic C1(CondE, aluFlags, FlagWriteE, 
						   PCSrcE, RegWriteE, MemWriteE, clk, rst, PCSrcE2, RegWriteE2, MemWriteE2);
	
	PipeRegEM regEM(clk, rst, 
						 ALUResultEUse, ALUControlE, rd2E, PCSrcE2, RegWriteE2, MemtoRegE, MemWriteE2, WA3E, v_s_e,
						 ALUResultM, ALUControlM, WriteDataM, PCSrcM, RegWriteM, MemtoRegM, MemWriteM, WA3M, v_s_m);
	
	PipeRegMW regMW(clk, rst, 
						 ALUResultM, ALUControlM, dataRead_i, PCSrcM, RegWriteM, MemtoRegM, WA3M, v_s_m,
						 ALUResultW, ALUControlW, ReadDataW, PCSrcW, RegWriteW, MemtoRegW, WA3W, v_s_w);
						 
	
	mux_2_to_1_4 M0(4'd15, instructionD[19:16], regSrc[0], a1);
	mux_2_to_1_4 M1(instructionD[23:20], instructionD[3:0], regSrc[1], a2);
	
	
	plus_n P4(pc, 32'd4, pc_plus_4);
	//plus_n P8(pc_plus_4, 32'd4, pc_plus_8);
	
	RegisterFile R0(clk,rst, RegWriteW, 
               a1, a2, WA3W,
               resultPc, pc_plus_4, instructionD[26], v_s_w, ALUControlW,
               rd1D, rd2D);
	
	Extend E0(instructionD[15:0], ImmSrcD, ExtImmD);
	
	mux_2_to_1_32_vec M2(ExtImmSrc, rd2E, ALUSrcE, srcB);
	
	alu A0(rd1E[15], srcB[15], ALUControlE, ALUResultE[15], aluFlags[1], aluFlags[2], aluFlags[3], aluFlags[0]);
	alu A1(rd1E[14], srcB[14], ALUControlE, ALUResultE[14], aluFlagsF1[1], aluFlagsF1[2], aluFlagsF1[3], aluFlagsF1[0]);
	alu A2(rd1E[13], srcB[13], ALUControlE, ALUResultE[13], aluFlagsF2[1], aluFlagsF2[2], aluFlagsF2[3], aluFlagsF2[0]);
	alu A3(rd1E[12], srcB[12], ALUControlE, ALUResultE[12], aluFlagsF3[1], aluFlagsF3[2], aluFlagsF3[3], aluFlagsF3[0]);
	alu A4(rd1E[11], srcB[11], ALUControlE, ALUResultE[11], aluFlagsF4[1], aluFlagsF4[2], aluFlagsF4[3], aluFlagsF4[0]);
	alu A5(rd1E[10], srcB[10], ALUControlE, ALUResultE[10], aluFlagsF5[1], aluFlagsF5[2], aluFlagsF5[3], aluFlagsF5[0]);
	alu A6(rd1E[9], srcB[9], ALUControlE, ALUResultE[9], aluFlagsF6[1], aluFlagsF6[2], aluFlagsF6[3], aluFlagsF6[0]);
	alu A7(rd1E[8], srcB[8], ALUControlE, ALUResultE[8], aluFlagsF7[1], aluFlagsF7[2], aluFlagsF7[3], aluFlagsF7[0]);
	alu A8(rd1E[7], srcB[7], ALUControlE, ALUResultE[7], aluFlagsF8[1], aluFlagsF8[2], aluFlagsF8[3], aluFlagsF8[0]);
	alu A9(rd1E[6], srcB[6], ALUControlE, ALUResultE[6], aluFlagsF9[1], aluFlagsF9[2], aluFlagsF9[3], aluFlagsF9[0]);
	alu A10(rd1E[5], srcB[5], ALUControlE, ALUResultE[5], aluFlagsF10[1], aluFlagsF10[2], aluFlagsF10[3], aluFlagsF10[0]);
	alu A11(rd1E[4], srcB[4], ALUControlE, ALUResultE[4], aluFlagsF11[1], aluFlagsF11[2], aluFlagsF11[3], aluFlagsF11[0]);
	alu A12(rd1E[3], srcB[3], ALUControlE, ALUResultE[3], aluFlagsF12[1], aluFlagsF12[2], aluFlagsF12[3], aluFlagsF12[0]);
	alu A13(rd1E[2], srcB[2], ALUControlE, ALUResultE[2], aluFlagsF13[1], aluFlagsF13[2], aluFlagsF13[3], aluFlagsF13[0]);
	alu A14(rd1E[1], srcB[1], ALUControlE, ALUResultE[1], aluFlagsF14[1], aluFlagsF14[2], aluFlagsF14[3], aluFlagsF14[0]);
	alu A15(rd1E[0], srcB[0], ALUControlE, ALUResultE[0], aluFlagsF15[1], aluFlagsF15[2], aluFlagsF15[3], aluFlagsF15[0]);

	sumatoria SM(rd1E, SUM_Result);
	mux_2_to_1_32_vec M3(ReadDataW, ALUResultW, MemtoRegW, resultPc);
	mux_2_to_1_32 M4(resultPc[15], pc_plus_4, PCSrcW, pcOut);
	
	assign ExtImmSrc[15] = ExtImmE;
	assign ExtImmSrc[14:0] = 0;
	assign ALUResultEUse[15] = (ALUControlE == 3'b101) & (v_s_e == 1'b1) ? SUM_Result : ALUResultE[15];
	assign ALUResultEUse[14:0] = ALUResultE[14:0];
	assign ReadDataUse = v_s_w? dataRead_i : ReadDataW;
	assign addr = (ALUControlE == 3'b001) ? ALUResultEUse[15][12:0] : ALUResultM[15][12:0];
	assign dataWrite_i = WriteDataM;
	assign memWrite = MemWriteM;
	assign vec_scalar = v_s_m;
	assign v_s = instructionD[26];

endmodule


