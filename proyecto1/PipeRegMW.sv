module PipeRegMW (
    // Clock signal
    input logic CLK,
	 input logic RST,
    // Input signals       					 	
    input logic [15:0][31:0] ALUOutM,
	 input logic [2:0] ALUControlM,
    input logic [15:0][31:0] ReadDataM,
    input logic PCSrcM,
    input logic RegWriteM,
    input logic MemtoRegM,
	 input logic [3:0] WA3M,
	 input logic v_s_m,
    // Output signals
    output logic [15:0][31:0] ALUOutW,
	 output logic [2:0] ALUControlW,
    output logic [15:0][31:0] ReadDataW,
    output logic PCSrcW,
    output logic RegWriteW,
    output logic MemtoRegW,
	 output logic [3:0] WA3W,
	 output logic v_s_w
);

    //parameter DATA_WIDTH = 32; 					// Define the data width

    logic [15:0][31:0] ALUOutReg;
    logic [15:0][31:0] ReadDataReg;
	 logic [2:0] ALUControlReg;
    logic PCSrcReg;
    logic RegWriteReg;
    logic MemtoRegReg;
	 logic [3:0] WA3Reg;
	 logic v_s_reg;

    always @(posedge CLK or posedge RST) begin
	 
		 if (RST) begin
        ALUOutReg <= 0;
        ReadDataReg <= 0;
        PCSrcReg <= 0;
        RegWriteReg <= 0;
        MemtoRegReg <= 0;
		  WA3Reg <= 0;
		  v_s_reg <= 0;
		  ALUControlReg <= 0;
		 end else begin
        ALUOutReg <= ALUOutM;
        ReadDataReg <= ReadDataM;
        PCSrcReg <= PCSrcM;
        RegWriteReg <= RegWriteM;
        MemtoRegReg <= MemtoRegM;
		  WA3Reg <= WA3M;
		  v_s_reg <= v_s_m;
		  ALUControlReg <= ALUControlM;
		 end

    end

    assign ALUOutW = ALUOutReg;
    assign ReadDataW = ReadDataReg;
    assign PCSrcW = PCSrcReg;
    assign RegWriteW = RegWriteReg;
    assign MemtoRegW = MemtoRegReg;
	 assign WA3W = WA3Reg;
	 assign v_s_w = v_s_reg;
	 assign ALUControlW = ALUControlReg;

endmodule
