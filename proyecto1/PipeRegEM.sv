module PipeRegEM (
    // Clock signal
    input logic CLK,
	 input logic RST,
    // Input signals       					 	
    input logic [15:0][31:0] ALUResultE,
	 input logic [2:0] ALUControlE,
    input logic [15:0][31:0] WriteDataE,
    input logic PCSrcE,
    input logic RegWriteE,
    input logic MemtoRegE,
    input logic MemWriteE,
	 input logic [3:0] WA3E,
	 input logic v_s_e,
    // Output signals
    output logic [15:0][31:0] ALUResultM,
	 output logic [2:0] ALUControlM,
    output logic [15:0][31:0] WriteDataM,
    output logic PCSrcM,
    output logic RegWriteM,
    output logic MemtoRegM,
    output logic MemWriteM,
	 output logic [3:0] WA3M,
	 output logic v_s_m
);

    //parameter DATA_WIDTH = 32; 					// Define the data width

    logic [15:0][31:0] ALUResultReg;
    logic [15:0][31:0] WriteDataReg;
	 logic [2:0] ALUControlReg;
    logic PCSrcReg;
    logic RegWriteReg;
    logic MemtoRegReg;
    logic MemWriteReg;
	 logic [3:0] WA3Reg;
	 logic v_s_reg;

    always @(posedge CLK or posedge RST) begin
	 
		 if (RST) begin
		  ALUResultReg <= 0;
        WriteDataReg <= 0;
        PCSrcReg <= 0;
        RegWriteReg <= 0;
        MemtoRegReg <= 0;
        MemWriteReg <= 0;
		  WA3Reg <= 0;
		  v_s_reg <= 0;
		  ALUControlReg <= 0;
		 end else begin
		  ALUResultReg <= ALUResultE;
		  ALUControlReg <= ALUControlE;
        WriteDataReg <= WriteDataE;
        PCSrcReg <= PCSrcE;
        RegWriteReg <= RegWriteE;
        MemtoRegReg <= MemtoRegE;
        MemWriteReg <= MemWriteE;
		  WA3Reg <= WA3E;
		  v_s_reg <= v_s_e;
		 end

    end

    assign ALUResultM = ALUResultReg;
    assign WriteDataM = WriteDataReg;
	 assign ALUControlM = ALUControlReg;
    assign PCSrcM = PCSrcReg;
    assign RegWriteM = RegWriteReg;
    assign MemtoRegM = MemtoRegReg;
    assign MemWriteM = MemWriteReg;
	 assign WA3M = WA3Reg;
	 assign v_s_m = v_s_reg;

endmodule
