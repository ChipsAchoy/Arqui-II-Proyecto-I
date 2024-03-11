
module ArduinoLogic(input logic [19:0] arduinoAddI, output logic [19:0] arduinoAddO);

	
	logic [19:0] arduinoAddP1;
	
	
	initial begin
	
		arduinoAddP1 = 0;
	
	end
	
	
	ArduinoAdd_p1 AP1(arduinoAddI, arduinoAddP1);
	
	assign arduinoAddO = arduinoAddP1;
	

endmodule