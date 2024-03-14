module PipeRegDE (
    // Clock signal
    input logic CLK,
	 input logic RST,
    // Input signals       					 	
    input logic [15:0][31:0] RD1D,
    input logic [15:0][31:0] RD2D,
    input logic [31:0] ExtImmD,
    input logic [3:0] CondD,
    input logic [3:0] FlagsD,
    input logic PCSrcD,
    input logic RegWriteD,
    input logic MemtoRegD,
    input logic MemWriteD,
    input logic [3:0]ALUControlD,
    input logic BranchD,
    input logic ALUSrcD,
    input logic [1:0] FlagWriteD,
	 input logic [3:0] WA3D,
    // Output signals
    output logic [15:0][31:0] RD1E,
    output logic [15:0][31:0] RD2E,
    output logic [31:0] ExtImmE,
    output logic [3:0] CondE,
    output logic [3:0] FlagsE,
    output logic PCSrcE,
    output logic RegWriteE,
    output logic MemtoRegE,
    output logic MemWriteE,
    output logic [3:0] ALUControlE,
    output logic BranchE,
    output logic ALUSrcE,
    output logic [1:0] FlagWriteE,
	 output logic [3:0] WA3E
);

    //parameter DATA_WIDTH = 32; 					// Define the data width

    logic [15:0][31:0] RD1Reg;
    logic [15:0][31:0] RD2Reg;
    logic [31:0] ExtImmReg;
    logic [3:0] CondReg;
    logic [3:0] FlagsReg;
    logic PCSrcReg;
    logic RegWriteReg;
    logic MemtoRegReg;
    logic MemWriteReg;
    logic [3:0]ALUControlReg;
    logic BranchReg;
    logic ALUSrcReg;
    logic [1:0] FlagWriteReg;
	 logic [3:0] WA3Reg;

    always @(posedge CLK or posedge RST) begin
	 
		 if (RST) begin
			RD1Reg <= 0;
			RD2Reg <= 0;
			ExtImmReg <= 0;
			CondReg <= 0;
			FlagsReg <= 0;
			PCSrcReg <= 0;
			RegWriteReg <= 0;
			MemtoRegReg <= 0;
			MemWriteReg <= 0;
			ALUControlReg <= 0;
			BranchReg <= 0;
			ALUSrcReg <= 0;
			FlagWriteReg <= 0;
			WA3Reg <= 0;
		 end else begin
			RD1Reg <= RD1D;
			RD2Reg <= RD2D;
			ExtImmReg <= ExtImmD;
			CondReg <= CondD;
			FlagsReg <= FlagsD;
			PCSrcReg <= PCSrcD;
			RegWriteReg <= RegWriteD;
			MemtoRegReg <= MemtoRegD;
			MemWriteReg <= MemWriteD;
			ALUControlReg <= ALUControlD;
			BranchReg <= BranchD;
			ALUSrcReg <= ALUSrcD;
			FlagWriteReg <= FlagWriteD;
			WA3Reg <= WA3D;
		 end


    end

    assign RD1E = RD1Reg;
    assign RD2E = RD2Reg;
    assign ExtImmE = ExtImmReg;
    assign CondE = CondReg;
    assign FlagsE = FlagsReg;
    assign PCSrcE = PCSrcReg;
    assign RegWriteE = RegWriteReg;
    assign MemtoRegE = MemtoRegReg;
    assign MemWriteE = MemWriteReg;
    assign ALUControlE = ALUControlReg;
    assign BranchE = BranchReg;
    assign ALUSrcE = ALUSrcReg;
    assign FlagWriteE = FlagWriteReg;
	 assign WA3E = WA3Reg;

endmodule
