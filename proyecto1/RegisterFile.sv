
module RegisterFile(input  logic clk,rst,we3, 
               input  logic [3:0]  ra1, ra2, ra3, 
               input  logic [15:0][31:0] wd3, input  logic [31:0] r15, input logic selec_v_s,
               input logic selec_v_s_w, output logic [15:0][31:0] rd1, rd2);

	logic [15:0][15:0][31:0] rf_v;
	logic [14:0][31:0] rf_s;
	
	
	always_ff @(negedge clk or posedge rst) begin
	
		if(rst) begin
			
			rf_s[14:0] = 0;
			
			rf_v[15][15:0] = 0;
			rf_v[14][15:0] = 0;
			rf_v[13][15:0] = 0;
			rf_v[12][15:0] = 0;
			rf_v[11][15:0] = 0;
			rf_v[10][15:0] = 0;
			rf_v[9][15:0] = 0;
			rf_v[8][15:0] = 0;
			rf_v[7][15:0] = 0;
			rf_v[6][15:0] = 0;
			rf_v[5][15:0] = 0;
			rf_v[4][15:0] = 0;
			rf_v[3][15:0] = 0;
			rf_v[2][15:0] = 0;
			rf_v[1][15:0] = 0;
			rf_v[0][15:0] = 0;
			
			rf_v[0][15] = 5;
			rf_v[0][14] = 4;
			rf_v[0][13] = 3;
			rf_v[0][12] = 0;
			rf_v[0][11] = 0;
			rf_v[0][10] = 0;
			rf_v[0][9] = 0;
			rf_v[0][8] = 0;
			rf_v[0][7] = 0;
			rf_v[0][6] = 0;
			rf_v[0][5] = 2;
			rf_v[0][4] = 1;
			rf_v[0][3] = 1;
			rf_v[0][2] = 7;
			rf_v[0][1] = 6;
			rf_v[0][0] = 1;
			
			rf_v[1][15] = 5;
			rf_v[1][14] = 4;
			rf_v[1][13] = 3;
			rf_v[1][12] = 0;
			rf_v[1][11] = 0;
			rf_v[1][10] = 0;
			rf_v[1][9] = 0;
			rf_v[1][8] = 0;
			rf_v[1][7] = 0;
			rf_v[1][6] = 0;
			rf_v[1][5] = 2;
			rf_v[1][4] = 1;
			rf_v[1][3] = 1;
			rf_v[1][2] = 7;
			rf_v[1][1] = 6;
			rf_v[1][0] = 2;
			
			rf_v[2][15] = 1;
			rf_v[2][14] = 1;
			rf_v[2][13] = 1;
			rf_v[2][12] = 1;
			rf_v[2][11] = 1;
			rf_v[2][10] = 1;
			rf_v[2][9] = 1;
			rf_v[2][8] = 1;
			rf_v[2][7] = 1;
			rf_v[2][6] = 1;
			rf_v[2][5] = 1;
			rf_v[2][4] = 1;
			rf_v[2][3] = 1;
			rf_v[2][2] = 1;
			rf_v[2][1] = 1;
			rf_v[2][0] = 1;
			
			
			rf_v[4][15] = 0;
			
			rf_s[4] = 1;
			rf_s[8] = 12;
			rf_s[2] = 1;
			
			
		end
		else begin
			if (we3 & (selec_v_s_w == 1'b0)) begin
				rf_s[ra3] <= wd3[15];
			end else if (we3 & (selec_v_s_w == 1'b1)) begin
				rf_v[ra3] <= wd3;
			end
		end
	end

	assign rd1[15] = (ra1 == 4'b1111) & (selec_v_s == 1'b0) ? r15 : (selec_v_s == 1'b0) ? rf_s[ra1] : rf_v[ra1][15];
	assign rd2[15] = (ra2 == 4'b1111) & (selec_v_s == 1'b0) ? r15 : (selec_v_s == 1'b0) ? rf_s[ra2] : rf_v[ra2][15];
	assign rd1[14:0] = rf_v[ra1][14:0];
	assign rd2[14:0] = rf_v[ra2][14:0];
  

endmodule
