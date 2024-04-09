
module sumatoria(input logic [15:0][31:0] rd, output logic [31:0] sum);

	assign sum = rd[15] + rd[14] + rd[13] + rd[12] + rd[11] + rd[10] + rd[9] + rd[8] + rd[7] + rd[6] + rd[5] + rd[4] + rd[3] + rd[2] + rd[1] + rd[0];

endmodule