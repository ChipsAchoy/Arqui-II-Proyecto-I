module ChipSet (input logic [20:0] addr,output logic [1:0] select,output logic [19:0] out_addr);


	logic [15:0] addr_assign;
	
	always @(*) begin
		
		if(addr >= 0 && addr < 20'd819199) begin
		
			select <= 2'b00;
			addr_assign <= addr;
		
		end else if(addr >= 20'd819199) begin
		
			select <= 2'b01;
			addr_assign <= addr-20'd819199;
			
		
		end
		
	end

	assign out_addr = addr_assign;
	
endmodule

