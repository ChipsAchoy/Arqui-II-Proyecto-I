
module RegisterFile(input  logic clk,rst,we3, 
               input  logic [3:0]  ra1, ra2, ra3, 
               input  logic [15:0][31:0] wd3, input  logic [31:0] r15, input logic selec_v_s,
               output logic [15:0][31:0] rd1, rd2);

	logic [15:0][15:0][31:0] rf_v;
	logic [14:0][31:0] rf_s;
	
	
	always_ff @(negedge clk or posedge rst) begin
	
		if(rst) begin
			
			rf_s[14:0] = 32'd0;
			rf_v[15][15:0] = 32d'0;
			rf_v[14][15:0] = 32d'0;
			rf_v[13][15:0] = 32d'0;
			rf_v[12][15:0] = 32d'0;
			rf_v[11][15:0] = 32d'0;
			rf_v[10][15:0] = 32d'0;
			rf_v[9][15:0] = 32d'0;
			rf_v[8][15:0] = 32d'0;
			rf_v[7][15:0] = 32d'0;
			rf_v[6][15:0] = 32d'0;
			rf_v[5][15:0] = 32d'0;
			rf_v[4][15:0] = 32d'0;
			rf_v[3][15:0] = 32d'0;
			rf_v[2][15:0] = 32d'0;
			rf_v[1][15:0] = 32d'0;
			rf_v[0][15:0] = 32d'0;
			
			/*
			Operaciones y memoria
			
			*/
			/*
			rf[14:0] = 32'd0;
			rf[0] = 32'd3;
			rf[1] = 32'd7;
			rf[2] = 32'd3;
			rf[3] = 32'd15;
			*/
			
			/*
			Salto condicional
			
			*/
			/*
			rf[14:0] = 32'd0;
			rf[2] = 32'd0;
			rf[4] = 32'd7;
			rf[5] = 32'd1;
			*/
		end
		else begin
			if (we3 & (selec_v_s == 1'b0)) begin
				rf_s[ra3] <= wd3[15];
			end else if (we3 & (selec_v_s == 1'b1)) begin
				rf_v[ra3] <= wd3;
			end
		end
	end

	assign rd1[15] = (ra1 == 4'b1111) & (selec_v_s == 1'b0) ? r15 : (selec_v_s == 1'b0) ? rf_s[ra1] : rf_v[ra1];
	assign rd2[15] = (ra2 == 4'b1111) & (selec_v_s == 1'b0) ? r15 : (selec_v_s == 1'b0) ? rf_s[ra2] : rf_v[ra2];
	
  

endmodule
