module PipeRegFD (
  input logic CLK,       					 	// Clock signal
  input logic RST,
  input logic [31:0] InstrF,   	// Input data
  output logic [31:0] InstrD  	// Output data
);

	//parameter DATA_WIDTH = 32; 					// Define the data width

	logic [31:0] InstrReg;

	always @(posedge CLK or posedge RST) begin
	
		 if (RST) begin
			InstrReg <= 3221225472;  // Reset the register to 0
		 end else begin
			InstrReg <= InstrF; // Store the input data in the register
		 end
		 
   end

	assign InstrD = InstrReg;

endmodule
