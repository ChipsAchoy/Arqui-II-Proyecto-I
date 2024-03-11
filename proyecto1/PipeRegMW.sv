module PipeRegMW (
    // Clock signal
    input logic CLK,
	 input logic RST,
    // Input signals       					 	
    input logic [31:0] ALUOutM,
    input logic [31:0] ReadDataM,
    input logic PCSrcM,
    input logic RegWriteM,
    input logic MemtoRegM,
	 input logic [3:0] WA3M,
    // Output signals
    output logic [31:0] ALUOutW,
    output logic [31:0] ReadDataW,
    output logic PCSrcW,
    output logic RegWriteW,
    output logic MemtoRegW,
	 output logic [3:0] WA3W
);

    //parameter DATA_WIDTH = 32; 					// Define the data width

    logic [31:0] ALUOutReg;
    logic [31:0] ReadDataReg;
    logic PCSrcReg;
    logic RegWriteReg;
    logic MemtoRegReg;
	 logic [3:0] WA3Reg;

    always @(posedge CLK or posedge RST) begin
	 
		 if (RST) begin
        ALUOutReg <= 0;
        ReadDataReg <= 0;
        PCSrcReg <= 0;
        RegWriteReg <= 0;
        MemtoRegReg <= 0;
		  WA3Reg <= 0;
		 end else begin
        ALUOutReg <= ALUOutM;
        ReadDataReg <= ReadDataM;
        PCSrcReg <= PCSrcM;
        RegWriteReg <= RegWriteM;
        MemtoRegReg <= MemtoRegM;
		  WA3Reg <= WA3M;
		 end

    end

    assign ALUOutW = ALUOutReg;
    assign ReadDataW = ReadDataReg;
    assign PCSrcW = PCSrcReg;
    assign RegWriteW = RegWriteReg;
    assign MemtoRegW = MemtoRegReg;
	 assign WA3W = WA3Reg;

endmodule
