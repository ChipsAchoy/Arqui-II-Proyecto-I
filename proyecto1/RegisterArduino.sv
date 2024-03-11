

module RegisterArduino(input logic clk, rst, input logic [19:0] arduinoAddIn, 
 output logic [19:0] arduinoAddOut);

	logic [19:0] arduinoAddAux;
	always @(posedge clk or posedge rst) begin
    if (rst) begin
      // Reset: inicializar la variable en 0 cuando rst es alto
		arduinoAddOut <= 0;
    end else begin
      // Incrementar la variable en 1 en cada flanco de subida del reloj
      arduinoAddOut <= arduinoAddIn;
    end
  end
  
  //assign arduinoAddOut = arduinoAddAux;

endmodule
