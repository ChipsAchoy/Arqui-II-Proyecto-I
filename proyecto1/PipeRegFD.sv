module PipeRegFD (
  input logic CLK,       					 	// Clock signal
  input logic RST,
  input logic [31:0] InstrF,   	// Input data
  input logic[5:0][31:0] perf_in,
  output logic [31:0] InstrD,  	// Output data
  output logic[5:0][31:0] perf_out
);

	//parameter DATA_WIDTH = 32; 					// Define the data width

	logic [31:0] InstrReg;
	logic [5:0][31:0] perf_reg;

	always @(posedge CLK or posedge RST) begin
	
		 if (RST) begin
			InstrReg <= 3221225472;  // Reset the register to 0
			perf_reg[5:0] = 0;
		 end else begin
		 
			InstrReg <= InstrF; // Store the input data in the register
			
			if ((InstrF[31:30] == 0)||(InstrF[31:30] == 1)||(InstrF[31:30] == 2)||
				(InstrF[31:30] == 3)) begin
				perf_reg[5] = perf_in[5] + 5;
				
			end
			
			if (InstrF[31:30] == 3) begin
				perf_reg[4] = perf_in[4] + 1;
			end
			
			if ((InstrF[31:30] == 0) && (InstrF[26] == 0)) begin
				perf_reg[3] = perf_in[3] + 1;
				
			end else if ((InstrF[31:30] == 0) && (InstrF[26] == 1)) begin
				perf_reg[3] = perf_in[3] + 16;
				
			end
			
			if ((InstrF[31:30] == 1) && (InstrF[26] == 0)) begin
				perf_reg[2] = perf_in[2] + 1;
				
			end else if ((InstrF[31:30] == 1) && (InstrF[26] == 1)) begin
				perf_reg[2] = perf_in[2] + 16;
				
			end
			
		 end
		 
   end

	assign InstrD = InstrReg;
	assign perf_out = perf_reg;

endmodule
